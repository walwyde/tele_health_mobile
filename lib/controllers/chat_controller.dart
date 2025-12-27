import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'diagnosis_controller.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;
  final diagnosis = Get.find<DiagnosisController>();

  var messages = <Map<String, dynamic>>[].obs;
  var isTyping = false.obs;

  // Store symptoms from DB for validation

  final dbSymptoms = <String>[].obs;
  final symptomMap = <String, String>{}.obs;




  @override
  void onInit() {
    super.onInit();
    _loadSymptoms();
    _loadInitialMessages();
  }


Future<void> _loadSymptoms() async {
  final symptoms = await supabase
      .from('symptoms')
      .select('id, name');

  for (final s in symptoms) {
    symptomMap[s['name'].toLowerCase()] = s['name'].toLowerCase();
  }

  final synonyms = await supabase
      .from('symptom_synonyms')
      .select('synonym, symptoms(name)');

  for (final syn in synonyms) {
    symptomMap[syn['synonym'].toLowerCase()] =
        syn['symptoms']['name'].toLowerCase();
  }
}


//   List<String> _extractSymptoms(String text) {
//   final lower = text.toLowerCase();

//   return dbSymptoms
//       .where((symptom) => lower.contains(symptom))
//       .toList();
// }

List<String> _extractSymptoms(String text) {
  final lower = text.toLowerCase();

  final matches = <String>{};

  symptomMap.forEach((key, value) {
    if (lower.contains(key)) {
      matches.add(value);
    }
  });

  return matches.toList();
}

String _detectIntent(String text) {
  final t = text.toLowerCase();

  if (t.contains('what can i do') ||
      t.contains('what should i do')) {
    return 'advice';
  }

  if (t.contains('what do you prescribe') ||
      t.contains('medication') ||
      t.contains('drug')) {
    return 'medication';
  }

  if (t.contains('is it serious') ||
      t.contains('dangerous')) {
    return 'severity';
  }

  return 'unknown';
}



  // Future<void> _loadSymptoms() async {
  // final res = await supabase
  //     .from('symptoms')
  //     .select('name');

  // dbSymptoms.value =
  //     res.map<String>((s) => s['name'].toString().toLowerCase()).toList();
  // }

  Future<void> _loadInitialMessages() async {
    if (diagnosis.disease.value.isEmpty) return;

    isTyping.value = true;

    final responses = await supabase
        .from('disease_chat_responses')
        .select('stage, message')
        .eq('disease_id', diagnosis.diseaseId);

    // Intro
    _addAIMessage(
      "Based on your symptoms, ${diagnosis.disease.value} is a possible condition "
      "with ${(diagnosis.confidence.value * 100).toInt()}% confidence."
    );

    for (final r in responses) {
      await Future.delayed(const Duration(milliseconds: 600));
      _addAIMessage(r['message']);
    }

    // Drug summary
    if (diagnosis.drugs.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 600));
      _addAIMessage("Recommended medications include:");
      for (final drug in diagnosis.drugs) {
        _addAIMessage(
          "${drug['name']} — ${drug['dosage']}"
        );
      }
    }

    isTyping.value = false;
  }

  void sendUserMessage(String text) {
    messages.add({
      'sender': 'user',
      'text': text,
    });

    _respondToUser(text);
  }

  // void _respondToUser(String text) async {
  //   isTyping.value = true;

  //   await Future.delayed(const Duration(seconds: 1));

  //   if (text.toLowerCase().contains('serious') ||
  //       text.toLowerCase().contains('danger')) {
  //     _addAIMessage(
  //       "If symptoms worsen or persist, you should seek medical attention immediately."
  //     );
  //   } else {
  //     _addAIMessage(
  //       "I can help explain your diagnosis, medications, or next steps."
  //     );
  //   }

  //   isTyping.value = false;
  // }

void _respondToUser(String text) async {
  isTyping.value = true;

  final extracted = _extractSymptoms(text);

  // If new symptoms found → re-diagnose
  if (extracted.isNotEmpty) {
    final merged = {
      ...diagnosis.selectedSymptoms,
      ...extracted,
    }.toList();

    await diagnosis.diagnoseFromSymptoms(merged);

    _addAIMessage(
      "Based on your updated symptoms, ${diagnosis.disease.value} "
      "is a possible condition with "
      "${(diagnosis.confidence.value * 100).toInt()}% confidence."
    );

    isTyping.value = false;
    return;
  }

  // No symptoms → intent-based response
  final intent = _detectIntent(text);

  switch (intent) {
    case 'advice':
      _addAIMessage(
        "General self-care may include rest, hydration, and monitoring symptoms. "
        "Avoid self-medication beyond recommended doses."
      );
      break;

    case 'medication':
      if (diagnosis.drugs.isEmpty) {
        _addAIMessage(
          "Medication depends on professional evaluation. "
          "I can only show commonly used options, not prescriptions."
        );
      } else {
        _addAIMessage("Commonly used medications include:");
        for (final drug in diagnosis.drugs) {
          _addAIMessage("${drug['name']} — ${drug['dosage']}");
        }
      }
      break;

    case 'severity':
      _addAIMessage(
        "If symptoms worsen, persist, or include severe pain, breathing difficulty, "
        "or loss of consciousness, seek medical attention immediately."
      );
      break;

    default:
      _addAIMessage(
        "I can help identify symptoms, explain possible conditions, or guide next steps."
      );
  }

  // Mandatory disclaimer
  await Future.delayed(const Duration(milliseconds: 400));
  _addAIMessage(
    "Please note: This system provides informational guidance only. "
    "It does not replace a licensed medical professional."
  );

  isTyping.value = false;
}



  void _addAIMessage(String text) {
    messages.add({
      'sender': 'ai',
      'text': text,
    });
  }
}
