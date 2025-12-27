// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'diagnosis_controller.dart';

// class ChatController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final diagnosis = Get.find<DiagnosisController>();

//   var messages = <Map<String, dynamic>>[].obs;
//   var isTyping = false.obs;

//   // Store symptoms from DB for validation

//   final dbSymptoms = <String>[].obs;
//   final symptomMap = <String, String>{}.obs;




//   @override
//   void onInit() {
//     super.onInit();
//     _loadSymptoms();
//     _loadInitialMessages();
//   }


// Future<void> _loadSymptoms() async {
//   final symptoms = await supabase
//       .from('symptoms')
//       .select('id, name');

//   for (final s in symptoms) {
//     symptomMap[s['name'].toLowerCase()] = s['name'].toLowerCase();
//   }

//   final synonyms = await supabase
//       .from('symptom_synonyms')
//       .select('synonym, symptoms(name)');

//   for (final syn in synonyms) {
//     symptomMap[syn['synonym'].toLowerCase()] =
//         syn['symptoms']['name'].toLowerCase();
//   }
// }


// //   List<String> _extractSymptoms(String text) {
// //   final lower = text.toLowerCase();

// //   return dbSymptoms
// //       .where((symptom) => lower.contains(symptom))
// //       .toList();
// // }

// List<String> _extractSymptoms(String text) {
//   final lower = text.toLowerCase();

//   final matches = <String>{};

//   symptomMap.forEach((key, value) {
//     if (lower.contains(key)) {
//       matches.add(value);
//     }
//   });

//   return matches.toList();
// }

// String _detectIntent(String text) {
//   final t = text.toLowerCase();

//   if (t.contains('what can i do') ||
//       t.contains('what should i do')) {
//     return 'advice';
//   }

//   if (t.contains('what do you prescribe') ||
//       t.contains('medication') ||
//       t.contains('drug')) {
//     return 'medication';
//   }

//   if (t.contains('is it serious') ||
//       t.contains('dangerous')) {
//     return 'severity';
//   }

//   return 'unknown';
// }



//   // Future<void> _loadSymptoms() async {
//   // final res = await supabase
//   //     .from('symptoms')
//   //     .select('name');

//   // dbSymptoms.value =
//   //     res.map<String>((s) => s['name'].toString().toLowerCase()).toList();
//   // }

//   Future<void> _loadInitialMessages() async {
//     if (diagnosis.disease.value.isEmpty) return;

//     isTyping.value = true;

//     final responses = await supabase
//         .from('disease_chat_responses')
//         .select('stage, message')
//         .eq('disease_id', diagnosis.diseaseId);

//     // Intro
//     _addAIMessage(
//       "Based on your symptoms, ${diagnosis.disease.value} is a possible condition "
//       "with ${(diagnosis.confidence.value * 100).toInt()}% confidence."
//     );

//     for (final r in responses) {
//       await Future.delayed(const Duration(milliseconds: 600));
//       _addAIMessage(r['message']);
//     }

//     // Drug summary
//     if (diagnosis.drugs.isNotEmpty) {
//       await Future.delayed(const Duration(milliseconds: 600));
//       _addAIMessage("Recommended medications include:");
//       for (final drug in diagnosis.drugs) {
//         _addAIMessage(
//           "${drug['name']} — ${drug['dosage']}"
//         );
//       }
//     }

//     isTyping.value = false;
//   }

//   void sendUserMessage(String text) {
//     messages.add({
//       'sender': 'user',
//       'text': text,
//     });

//     _respondToUser(text);
//   }

//   // void _respondToUser(String text) async {
//   //   isTyping.value = true;

//   //   await Future.delayed(const Duration(seconds: 1));

//   //   if (text.toLowerCase().contains('serious') ||
//   //       text.toLowerCase().contains('danger')) {
//   //     _addAIMessage(
//   //       "If symptoms worsen or persist, you should seek medical attention immediately."
//   //     );
//   //   } else {
//   //     _addAIMessage(
//   //       "I can help explain your diagnosis, medications, or next steps."
//   //     );
//   //   }

//   //   isTyping.value = false;
//   // }

// void _respondToUser(String text) async {
//   isTyping.value = true;

//   final extracted = _extractSymptoms(text);

//   // If new symptoms found → re-diagnose
//   if (extracted.isNotEmpty) {
//     final merged = {
//       ...diagnosis.selectedSymptoms,
//       ...extracted,
//     }.toList();

//     await diagnosis.diagnoseFromSymptoms(merged);

//     _addAIMessage(
//       "Based on your updated symptoms, ${diagnosis.disease.value} "
//       "is a possible condition with "
//       "${(diagnosis.confidence.value * 100).toInt()}% confidence."
//     );

//     isTyping.value = false;
//     return;
//   }

//   // No symptoms → intent-based response
//   final intent = _detectIntent(text);

//   switch (intent) {
//     case 'advice':
//       _addAIMessage(
//         "General self-care may include rest, hydration, and monitoring symptoms. "
//         "Avoid self-medication beyond recommended doses."
//       );
//       break;

//     case 'medication':
//       if (diagnosis.drugs.isEmpty) {
//         _addAIMessage(
//           "Medication depends on professional evaluation. "
//           "I can only show commonly used options, not prescriptions."
//         );
//       } else {
//         _addAIMessage("Commonly used medications include:");
//         for (final drug in diagnosis.drugs) {
//           _addAIMessage("${drug['name']} — ${drug['dosage']}");
//         }
//       }
//       break;

//     case 'severity':
//       _addAIMessage(
//         "If symptoms worsen, persist, or include severe pain, breathing difficulty, "
//         "or loss of consciousness, seek medical attention immediately."
//       );
//       break;

//     default:
//       _addAIMessage(
//         "I can help identify symptoms, explain possible conditions, or guide next steps."
//       );
//   }

//   // Mandatory disclaimer
//   await Future.delayed(const Duration(milliseconds: 400));
//   _addAIMessage(
//     "Please note: This system provides informational guidance only. "
//     "It does not replace a licensed medical professional."
//   );

//   isTyping.value = false;
// }



//   void _addAIMessage(String text) {
//     messages.add({
//       'sender': 'ai',
//       'text': text,
//     });
//   }
// }

// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'diagnosis_controller.dart';

// class ChatController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final diagnosis = Get.find<DiagnosisController>();

//   var messages = <Map<String, dynamic>>[].obs;
//   var isTyping = false.obs;
//   var conversationClosed = false.obs;
//   var isChatActive = true.obs; // Add this line


//   // Store symptoms from DB for validation
//   final symptomMap = <String, String>{}.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadSymptoms();
//     _loadInitialMessages();
//   }

//   Future<void> _loadSymptoms() async {
//     // Load primary symptoms
//     final symptoms = await supabase
//         .from('symptoms')
//         .select('id, name');

//     for (final s in symptoms) {
//       symptomMap[s['name'].toLowerCase()] = s['name'].toLowerCase();
//     }

//     // Load synonyms
//     final synonyms = await supabase
//         .from('symptom_synonyms')
//         .select('synonym, symptoms(name)');

//     for (final syn in synonyms) {
//       symptomMap[syn['synonym'].toLowerCase()] =
//           syn['symptoms']['name'].toLowerCase();
//     }
//   }

//   // Extract symptoms from user text
//   List<String> _extractSymptoms(String text) {
//     final lower = text.toLowerCase();
//     final matches = <String>{};

//     symptomMap.forEach((key, value) {
//       // Use word boundaries for better matching
//       final pattern = RegExp(r'\b' + RegExp.escape(key) + r'\b');
//       if (pattern.hasMatch(lower)) {
//         matches.add(value);
//       }
//     });

//     return matches.toList();
//   }

//   // Detect if user wants to end conversation
//   bool _isFarewellIntent(String text) {
//     final lower = text.toLowerCase().trim();
    
//     final farewellPhrases = [
//       'okay',
//       'ok',
//       'thank you',
//       'thanks',
//       'thank u',
//       'thx',
//       'got it',
//       'understood',
//       'alright',
//       'bye',
//       'goodbye',
//       'see you',
//       'that\'s all',
//       'that is all',
//       'no more questions',
//       'i\'m done',
//       'im done',
//       'nothing else',
//       'that helps',
//     ];

//     return farewellPhrases.any((phrase) => lower.contains(phrase));
//   }

//   // Detect question intent
//   String _detectIntent(String text) {
//     final t = text.toLowerCase();

//     if (t.contains('what can i do') ||
//         t.contains('what should i do') ||
//         t.contains('how do i') ||
//         t.contains('advice')) {
//       return 'advice';
//     }

//     if (t.contains('what do you prescribe') ||
//         t.contains('medication') ||
//         t.contains('medicine') ||
//         t.contains('drug') ||
//         t.contains('treatment')) {
//       return 'medication';
//     }

//     if (t.contains('is it serious') ||
//         t.contains('dangerous') ||
//         t.contains('severity') ||
//         t.contains('how bad') ||
//         t.contains('urgent')) {
//       return 'severity';
//     }

//     if (t.contains('what is') ||
//         t.contains('tell me about') ||
//         t.contains('explain')) {
//       return 'explanation';
//     }

//     if (t.contains('side effect') ||
//         t.contains('risk') ||
//         t.contains('complication')) {
//       return 'side_effects';
//     }

//     return 'unknown';
//   }

//   Future<void> _loadInitialMessages() async {
//     if (diagnosis.disease.value.isEmpty) return;

//     isTyping.value = true;

//     final responses = await supabase
//         .from('disease_chat_responses')
//         .select('stage, message')
//         .eq('disease_id', diagnosis.diseaseId);

//     // Intro
//     _addAIMessage(
//       "Based on your symptoms, ${diagnosis.disease.value} is a possible condition "
//       "with ${(diagnosis.confidence.value * 100).toInt()}% confidence."
//     );

//     for (final r in responses) {
//       await Future.delayed(const Duration(milliseconds: 600));
//       _addAIMessage(r['message']);
//     }

//     // Drug summary
//     if (diagnosis.drugs.isNotEmpty) {
//       await Future.delayed(const Duration(milliseconds: 600));
//       _addAIMessage("Recommended medications include:");
//       for (final drug in diagnosis.drugs) {
//         _addAIMessage(
//           "• ${drug['name']} — ${drug['dosage']}"
//         );
//       }
//     }

//     await Future.delayed(const Duration(milliseconds: 800));
//     _addAIMessage(
//       "You can ask me questions about your condition, medications, or what to do next. "
//       "You can also mention any additional symptoms you're experiencing."
//     );

//     isTyping.value = false;
//   }

  

//   // Example of how you would close the chat:
//   void endChat() {
//     isChatActive.value = false;
//   }

//   void sendUserMessage(String text) {
//     if (conversationClosed.value) {
//       _addAIMessage("This conversation has ended. Please start a new diagnosis if needed.");
//       return;
//     }

//     messages.add({
//       'sender': 'user',
//       'text': text,
//     });

//     _respondToUser(text);
//   }

//   void _respondToUser(String text) async {
//     isTyping.value = true;
//     await Future.delayed(const Duration(milliseconds: 800));

//     // Check for farewell intent FIRST
//     if (_isFarewellIntent(text)) {
//       _handleFarewell();
//       return;
//     }

//     // Extract symptoms from user message
//     final extracted = _extractSymptoms(text);

//     // If NEW symptoms found → re-diagnose
//     if (extracted.isNotEmpty) {
//       final newSymptoms = extracted.where(
//         (s) => !diagnosis.selectedSymptoms.contains(s)
//       ).toList();

//       if (newSymptoms.isNotEmpty) {
//         _addAIMessage(
//           "I noticed you mentioned: ${newSymptoms.join(', ')}. "
//           "Let me update the diagnosis..."
//         );

//         await Future.delayed(const Duration(milliseconds: 500));

//         // Merge and re-diagnose
//         final merged = {
//           ...diagnosis.selectedSymptoms,
//           ...extracted,
//         }.toList();

//         await diagnosis.diagnoseFromSymptoms(merged);

//         // Show updated diagnosis
//         _addAIMessage(
//           "Based on your updated symptoms, ${diagnosis.disease.value} "
//           "is a possible condition with "
//           "${(diagnosis.confidence.value * 100).toInt()}% confidence."
//         );

//         await Future.delayed(const Duration(milliseconds: 600));

//         // Show medications if available
//         if (diagnosis.drugs.isNotEmpty) {
//           _addAIMessage("Recommended medications:");
//           for (final drug in diagnosis.drugs) {
//             await Future.delayed(const Duration(milliseconds: 300));
//             _addAIMessage("• ${drug['name']} — ${drug['dosage']}");
//           }
//         }

//         await Future.delayed(const Duration(milliseconds: 500));
//         _addAIMessage(
//           "Do you have any questions about this diagnosis or treatment?"
//         );

//         isTyping.value = false;
//         return;
//       } else {
//         // Symptoms already covered
//         _addAIMessage(
//           "I've already considered those symptoms in the diagnosis. "
//           "Anything else you'd like to know?"
//         );
//         isTyping.value = false;
//         return;
//       }
//     }

//     // No new symptoms → handle question intent
//     final intent = _detectIntent(text);

//     switch (intent) {
//       case 'advice':
//         await _handleAdviceQuestion();
//         break;

//       case 'medication':
//         await _handleMedicationQuestion();
//         break;

//       case 'severity':
//         await _handleSeverityQuestion();
//         break;

//       case 'explanation':
//         await _handleExplanationQuestion();
//         break;

//       case 'side_effects':
//         await _handleSideEffectsQuestion();
//         break;

//       default:
//         await _handleUnknownQuestion();
//     }

//     isTyping.value = false;
//   }

//   Future<void> _handleAdviceQuestion() async {
//     _addAIMessage(
//       "For ${diagnosis.disease.value}, here are some general recommendations:"
//     );

//     await Future.delayed(const Duration(milliseconds: 500));

//     _addAIMessage(
//       "• Get adequate rest and stay hydrated\n"
//       "• Take prescribed medications as directed\n"
//       "• Monitor your symptoms closely\n"
//       "• Avoid strenuous activities until you feel better\n"
//       "• Maintain good hygiene to prevent spread"
//     );

//     await Future.delayed(const Duration(milliseconds: 600));
//     _addAIMessage(
//       "If symptoms worsen or you experience severe pain, difficulty breathing, "
//       "or high fever, seek immediate medical attention."
//     );
//   }

//   Future<void> _handleMedicationQuestion() async {
//     if (diagnosis.drugs.isEmpty) {
//       _addAIMessage(
//         "Specific medication depends on professional medical evaluation. "
//         "I recommend consulting a healthcare provider for a proper prescription."
//       );
//     } else {
//       _addAIMessage(
//         "For ${diagnosis.disease.value}, commonly recommended medications include:"
//       );

//       await Future.delayed(const Duration(milliseconds: 500));

//       for (final drug in diagnosis.drugs) {
//         await Future.delayed(const Duration(milliseconds: 300));
//         _addAIMessage("• ${drug['name']} — ${drug['dosage']}");
//       }

//       await Future.delayed(const Duration(milliseconds: 500));
//       _addAIMessage(
//         "⚠️ Important: Take medications exactly as prescribed. "
//         "Do not exceed recommended doses or share medications with others."
//       );
//     }
//   }

//   Future<void> _handleSeverityQuestion() async {
//     final confidence = (diagnosis.confidence.value * 100).toInt();

//     if (confidence >= 70) {
//       _addAIMessage(
//         "Based on your symptoms, there's a ${confidence}% match with ${diagnosis.disease.value}. "
//         "I recommend seeing a healthcare professional for proper diagnosis and treatment."
//       );
//     } else if (confidence >= 50) {
//       _addAIMessage(
//         "Your symptoms suggest ${diagnosis.disease.value} with moderate confidence (${confidence}%). "
//         "It's advisable to consult a doctor for accurate diagnosis."
//       );
//     } else {
//       _addAIMessage(
//         "The symptom match is ${confidence}%, which is relatively low. "
//         "Consider monitoring your symptoms and consulting a healthcare provider "
//         "if they persist or worsen."
//       );
//     }

//     await Future.delayed(const Duration(milliseconds: 600));
//     _addAIMessage(
//       "⚠️ Seek immediate medical attention if you experience:\n"
//       "• Difficulty breathing or chest pain\n"
//       "• Severe pain or high fever (>39°C)\n"
//       "• Loss of consciousness or confusion\n"
//       "• Uncontrolled bleeding"
//     );
//   }

//   Future<void> _handleExplanationQuestion() async {
//     // Fetch disease description from database
//     final diseaseData = await supabase
//         .from('diseases')
//         .select('description')
//         .eq('id', diagnosis.diseaseId)
//         .single();

//     _addAIMessage(
//       "${diagnosis.disease.value}: ${diseaseData['description']}"
//     );

//     await Future.delayed(const Duration(milliseconds: 500));
//     _addAIMessage(
//       "This condition was identified based on your reported symptoms. "
//       "Would you like to know more about treatment or precautions?"
//     );
//   }

//   Future<void> _handleSideEffectsQuestion() async {
//     _addAIMessage(
//       "Common side effects may vary depending on specific medications. "
//       "Always read medication labels and consult your pharmacist or doctor."
//     );

//     await Future.delayed(const Duration(milliseconds: 500));
//     _addAIMessage(
//       "If you experience unusual reactions like severe allergic symptoms, "
//       "difficulty breathing, or severe rash, stop medication and seek medical help immediately."
//     );
//   }

//   Future<void> _handleUnknownQuestion() async {
//     _addAIMessage(
//       "I can help you with:\n"
//       "• Explaining your diagnosis\n"
//       "• Information about medications\n"
//       "• Advice on what to do next\n"
//       "• Severity assessment\n"
//       "\nYou can also mention any new symptoms you're experiencing."
//     );
//   }

//   void _handleFarewell() async {
//     _addAIMessage(
//       "You're welcome! I'm glad I could help."
//     );

//     await Future.delayed(const Duration(milliseconds: 600));
//     _addAIMessage(
//       "Remember:\n"
//       "✓ This is informational guidance only\n"
//       "✓ Consult a licensed healthcare provider for proper diagnosis\n"
//       "✓ Seek emergency care if symptoms worsen\n"
//       "✓ Take care and get well soon!"
//     );

//     await Future.delayed(const Duration(milliseconds: 800));
//     _addAIMessage(
//       "This conversation is now closed. You can start a new diagnosis anytime from the home screen."
//     );

//     conversationClosed.value = true;
//     isTyping.value = false;

//     // Optional: Auto-close chat after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.back(); // Close chat screen
//     });
//   }

//   void _addAIMessage(String text) {
//     messages.add({
//       'sender': 'ai',
//       'text': text,
//       'timestamp': DateTime.now(),
//     });
//   }
// }


import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'diagnosis_controller.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;
  final diagnosis = Get.find<DiagnosisController>();

  var messages = <Map<String, dynamic>>[].obs;
  var isTyping = false.obs;
  var isChatActive = true.obs; // Changed from conversationClosed

  // Store symptoms from DB for validation
  final symptomMap = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSymptoms();
    _loadInitialMessages();
  }

  Future<void> _loadSymptoms() async {
    try {
      // Load primary symptoms
      final symptoms = await supabase
          .from('symptoms')
          .select('id, name');

      for (final s in symptoms) {
        final name = s['name'].toString().toLowerCase();
        symptomMap[name] = name;
      }

      // Load synonyms
      final synonyms = await supabase
          .from('symptom_synonyms')
          .select('synonym, symptom_id, symptoms!inner(name)');

      for (final syn in synonyms) {
        final synonym = syn['synonym'].toString().toLowerCase();
        final originalName = syn['symptoms']['name'].toString().toLowerCase();
        symptomMap[synonym] = originalName;
      }

      print('✅ Loaded ${symptomMap.length} symptom mappings');
    } catch (e) {
      print('❌ Error loading symptoms: $e');
    }
  }

  // Extract symptoms from user text with word boundary matching
  List<String> _extractSymptoms(String text) {
    final lower = text.toLowerCase();
    final matches = <String>{};

    // Sort by length (longest first) to match multi-word phrases first
    final sortedKeys = symptomMap.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final key in sortedKeys) {
      // Create word boundary pattern
      final pattern = RegExp(r'\b' + RegExp.escape(key) + r'\b');
      if (pattern.hasMatch(lower)) {
        matches.add(symptomMap[key]!);
      }
    }

    return matches.toList();
  }

  // Detect if user wants to end conversation
  bool _isFarewellIntent(String text) {
    final lower = text.toLowerCase().trim();
    
    final farewellPhrases = [
      'okay',
      'ok',
      'thank you',
      'thanks',
      'thank u',
      'thx',
      'got it',
      'understood',
      'alright',
      'bye',
      'goodbye',
      'see you',
      'that\'s all',
      'that is all',
      'no more questions',
      'i\'m done',
      'im done',
      'nothing else',
      'that helps',
      'appreciate it',
    ];

    return farewellPhrases.any((phrase) => lower == phrase || lower.contains(phrase));
  }

  // Detect question intent
  String _detectIntent(String text) {
    final t = text.toLowerCase();

    if (t.contains('what can i do') ||
        t.contains('what should i do') ||
        t.contains('how do i') ||
        t.contains('advice') ||
        t.contains('recommend')) {
      return 'advice';
    }

    if (t.contains('what do you prescribe') ||
        t.contains('medication') ||
        t.contains('medicine') ||
        t.contains('drug') ||
        t.contains('treatment') ||
        t.contains('prescription')) {
      return 'medication';
    }

    if (t.contains('is it serious') ||
        t.contains('dangerous') ||
        t.contains('severity') ||
        t.contains('how bad') ||
        t.contains('urgent') ||
        t.contains('emergency')) {
      return 'severity';
    }

    if (t.contains('what is') ||
        t.contains('tell me about') ||
        t.contains('explain') ||
        t.contains('describe')) {
      return 'explanation';
    }

    if (t.contains('side effect') ||
        t.contains('risk') ||
        t.contains('complication') ||
        t.contains('adverse')) {
      return 'side_effects';
    }

    return 'unknown';
  }

  Future<void> _loadInitialMessages() async {
    if (diagnosis.disease.value.isEmpty) return;

    isTyping.value = true;

    try {
      final responses = await supabase
          .from('disease_chat_responses')
          .select('stage, message')
          .eq('disease_id', diagnosis.diseaseId);

      // Intro
      await Future.delayed(const Duration(milliseconds: 300));
      _addAIMessage(
        "Based on your symptoms, ${diagnosis.disease.value} is a possible condition "
        "with ${(diagnosis.confidence.value * 100).toInt()}% confidence."
      );

      // Additional context messages from database
      for (final r in responses) {
        await Future.delayed(const Duration(milliseconds: 600));
        _addAIMessage(r['message']);
      }

      // Drug summary
      if (diagnosis.drugs.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 600));
        _addAIMessage("Recommended medications include:");
        for (final drug in diagnosis.drugs) {
          await Future.delayed(const Duration(milliseconds: 300));
          _addAIMessage("• ${drug['name']} — ${drug['dosage']}");
        }
      }

      await Future.delayed(const Duration(milliseconds: 800));
      _addAIMessage(
        "You can ask me questions about your condition, medications, or mention any additional symptoms you're experiencing."
      );
    } catch (e) {
      print('❌ Error loading initial messages: $e');
      _addAIMessage("I'm ready to answer your questions about the diagnosis.");
    }

    isTyping.value = false;
  }

  void sendUserMessage(String text) {
    if (!isChatActive.value) {
      _addAIMessage("This conversation has ended. You can review the chat history, but no new messages can be sent.");
      return;
    }

    if (text.trim().isEmpty) return;

    messages.add({
      'sender': 'user',
      'text': text,
      'timestamp': DateTime.now(),
    });

    _respondToUser(text);
  }

  void _respondToUser(String text) async {
    isTyping.value = true;
    await Future.delayed(const Duration(milliseconds: 800));

    // Check for farewell intent FIRST
    if (_isFarewellIntent(text)) {
      _handleFarewell();
      return;
    }

    // ALWAYS extract symptoms from user message
    final extracted = _extractSymptoms(text);
    print('🔍 Extracted symptoms: $extracted');

    // If NEW symptoms found → re-diagnose
    if (extracted.isNotEmpty) {
      final currentSymptoms = diagnosis.selectedSymptoms.toSet();
      final newSymptoms = extracted.where(
        (s) => !currentSymptoms.contains(s)
      ).toList();

      if (newSymptoms.isNotEmpty) {
        _addAIMessage(
          "I noticed you mentioned: ${newSymptoms.join(', ')}. "
          "Let me update the diagnosis with these new symptoms..."
        );

        await Future.delayed(const Duration(milliseconds: 800));

        // Merge and re-diagnose
        final merged = [...currentSymptoms, ...extracted].toList();

        try {
          await diagnosis.diagnoseFromSymptoms(merged);

          // Show updated diagnosis
          await Future.delayed(const Duration(milliseconds: 500));
          _addAIMessage(
            "✅ Updated Analysis:\n"
            "${diagnosis.disease.value} is now indicated with "
            "${(diagnosis.confidence.value * 100).toInt()}% confidence."
          );

          await Future.delayed(const Duration(milliseconds: 600));

          // Show medications if available
          if (diagnosis.drugs.isNotEmpty) {
            _addAIMessage("Updated medication recommendations:");
            for (final drug in diagnosis.drugs) {
              await Future.delayed(const Duration(milliseconds: 300));
              _addAIMessage("• ${drug['name']} — ${drug['dosage']}");
            }
          }

          await Future.delayed(const Duration(milliseconds: 500));
          _addAIMessage(
            "The diagnosis has been updated based on all your symptoms. "
            "Do you have any questions?"
          );
        } catch (e) {
          _addAIMessage(
            "I encountered an error updating the diagnosis. Please try again or consult a healthcare professional."
          );
        }

        isTyping.value = false;
        return;
      } else {
        // Symptoms already in diagnosis
        _addAIMessage(
          "Those symptoms are already part of the current diagnosis. "
          "Is there anything else you'd like to know?"
        );
        isTyping.value = false;
        return;
      }
    }

    // No new symptoms → handle question intent
    final intent = _detectIntent(text);

    switch (intent) {
      case 'advice':
        await _handleAdviceQuestion();
        break;
      case 'medication':
        await _handleMedicationQuestion();
        break;
      case 'severity':
        await _handleSeverityQuestion();
        break;
      case 'explanation':
        await _handleExplanationQuestion();
        break;
      case 'side_effects':
        await _handleSideEffectsQuestion();
        break;
      default:
        await _handleUnknownQuestion();
    }

    isTyping.value = false;
  }

  Future<void> _handleAdviceQuestion() async {
    _addAIMessage(
      "For ${diagnosis.disease.value}, here are some general recommendations:"
    );

    await Future.delayed(const Duration(milliseconds: 500));

    _addAIMessage(
      "• Get adequate rest and stay hydrated\n"
      "• Take prescribed medications as directed\n"
      "• Monitor your symptoms closely\n"
      "• Avoid strenuous activities until better\n"
      "• Maintain good hygiene"
    );

    await Future.delayed(const Duration(milliseconds: 600));
    _addAIMessage(
      "⚠️ Seek immediate medical attention if symptoms worsen, you experience severe pain, difficulty breathing, or high fever."
    );
  }

  Future<void> _handleMedicationQuestion() async {
    if (diagnosis.drugs.isEmpty) {
      _addAIMessage(
        "Specific medication depends on professional medical evaluation. "
        "I recommend consulting a healthcare provider for a proper prescription."
      );
    } else {
      _addAIMessage(
        "For ${diagnosis.disease.value}, commonly recommended medications include:"
      );

      await Future.delayed(const Duration(milliseconds: 500));

      for (final drug in diagnosis.drugs) {
        await Future.delayed(const Duration(milliseconds: 300));
        _addAIMessage("• ${drug['name']} — ${drug['dosage']}");
      }

      await Future.delayed(const Duration(milliseconds: 500));
      _addAIMessage(
        "⚠️ Important: Take medications exactly as prescribed. "
        "Do not exceed recommended doses."
      );
    }
  }

  Future<void> _handleSeverityQuestion() async {
    final confidence = (diagnosis.confidence.value * 100).toInt();

    String severityMessage;
    if (confidence >= 70) {
      severityMessage = "Based on your symptoms, there's a strong match ($confidence%) with ${diagnosis.disease.value}. "
          "I recommend seeing a healthcare professional for proper diagnosis and treatment.";
    } else if (confidence >= 50) {
      severityMessage = "Your symptoms suggest ${diagnosis.disease.value} with moderate confidence ($confidence%). "
          "It's advisable to consult a doctor for accurate diagnosis.";
    } else {
      severityMessage = "The symptom match is $confidence%, which is relatively low. "
          "Consider monitoring your symptoms and consulting a healthcare provider if they persist or worsen.";
    }

    _addAIMessage(severityMessage);

    await Future.delayed(const Duration(milliseconds: 600));
    _addAIMessage(
      "🚨 Seek immediate medical attention if you experience:\n"
      "• Difficulty breathing or chest pain\n"
      "• Severe pain or high fever (>39°C)\n"
      "• Loss of consciousness or confusion\n"
      "• Uncontrolled bleeding"
    );
  }

  Future<void> _handleExplanationQuestion() async {
    try {
      // Fetch disease description from database
      final diseaseData = await supabase
          .from('diseases')
          .select('description')
          .eq('id', diagnosis.diseaseId)
          .single();

      _addAIMessage(
        "${diagnosis.disease.value}:\n${diseaseData['description']}"
      );

      await Future.delayed(const Duration(milliseconds: 500));
      _addAIMessage(
        "This condition was identified based on your reported symptoms. "
        "Would you like to know more about treatment or precautions?"
      );
    } catch (e) {
      _addAIMessage(
        "${diagnosis.disease.value} was identified based on your symptoms. "
        "Please consult a healthcare professional for detailed information."
      );
    }
  }

  Future<void> _handleSideEffectsQuestion() async {
    _addAIMessage(
      "Common side effects vary depending on specific medications. "
      "Always read medication labels and consult your pharmacist or doctor."
    );

    await Future.delayed(const Duration(milliseconds: 500));
    _addAIMessage(
      "⚠️ If you experience:\n"
      "• Severe allergic reactions (rash, swelling, difficulty breathing)\n"
      "• Unusual symptoms\n"
      "• Severe side effects\n\n"
      "Stop the medication and seek medical help immediately."
    );
  }

  Future<void> _handleUnknownQuestion() async {
    _addAIMessage(
      "I can help you with:\n"
      "• Explaining your diagnosis\n"
      "• Information about medications\n"
      "• Advice on what to do next\n"
      "• Severity assessment\n"
      "\nYou can also mention any new symptoms you're experiencing."
    );
  }

  void _handleFarewell() async {
    _addAIMessage(
      "You're welcome! I'm glad I could help."
    );

    await Future.delayed(const Duration(milliseconds: 600));
    _addAIMessage(
      "Remember:\n"
      "✓ This is informational guidance only\n"
      "✓ Consult a licensed healthcare provider for proper diagnosis\n"
      "✓ Seek emergency care if symptoms worsen\n"
      "✓ Take care and get well soon!"
    );

    await Future.delayed(const Duration(milliseconds: 800));
    _addAIMessage(
      "📝 This conversation is now closed. You can review the chat history, but I can no longer respond to new messages."
    );

    isChatActive.value = false;
    isTyping.value = false;

    // DO NOT auto-close - let user read through chat
  }

  void _addAIMessage(String text) {
    messages.add({
      'sender': 'ai',
      'text': text,
      'timestamp': DateTime.now(),
    });
  }
}