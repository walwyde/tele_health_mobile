
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiagnosisController extends GetxController {
  final supabase = Supabase.instance.client;

  var selectedSymptoms = <String>[].obs;
  var disease = ''.obs;
  var confidence = 0.0.obs;
  var drugs = <Map<String, dynamic>>[].obs;
  var diseaseId = ''.obs;

  
  // Added Loading State
  var isLoading = false.obs;

  Future<bool> diagnoseFromSymptoms(List<String> symptoms) async {
  if (symptoms.isEmpty) return false;

  selectedSymptoms
    ..clear()
    ..addAll(symptoms);

  await diagnose();
  return disease.value.isNotEmpty;
}


  Future<void> diagnose() async {
    if (selectedSymptoms.isEmpty) return;

    try {
      isLoading.value = true; // Start loading

      final symptomRows = await supabase
          .from('symptoms')
          .select('id, name')
          .inFilter('name', selectedSymptoms);

      if (symptomRows.isEmpty) {
        disease.value = "Unknown Condition";
        confidence.value = 0.0;
        return;
      }

      final symptomIds = symptomRows.map((e) => e['id'] as String).toList();

      final matches = await supabase
          .from('disease_symptoms')
          .select('disease_id, diseases(name)')
          .inFilter('symptom_id', symptomIds);

      final Map<String, int> counts = {};
      final Map<String, String> diseaseIds = {};

      for (final row in matches) {
        final name = row['diseases']['name'];
        final id = row['disease_id'];
        counts[name] = (counts[name] ?? 0) + 1;
        diseaseIds[name] = id;
      }

      if (counts.isEmpty) {
        disease.value = "No match found";
        confidence.value = 0.0;
        drugs.clear();
        return;
      }

  //     final sorted = counts.entries.toList()
  //       ..sort((a, b) => b.value.compareTo(a.value));

  //     disease.value = sorted.first.key;
  //     // Improved confidence logic: cap at 1.0 (100%)
  //     confidence.value = (sorted.first.value / selectedSymptoms.length).clamp(0.0, 1.0);

  //     final diseaseId = diseaseIds[disease.value]!;

  //     // final drugData = await supabase
  //     //     .from('drugs')
  //     //     .select('name, dosage')
  //     //     .eq('disease_id', diseaseId);
      
  //    drugs.value = await supabase
  // .from('drugs')
  // .select('name, dosage, advice, warning')
  // .eq('disease_id', diseaseId);

  final sorted = counts.entries.toList()
  ..sort((a, b) => b.value.compareTo(a.value));

disease.value = sorted.first.key;
confidence.value =
    sorted.first.value / selectedSymptoms.length;

// STORE DISEASE UUID
diseaseId.value = diseaseIds[disease.value]!;

drugs.value = await supabase
    .from('drugs')
    .select('name, dosage, advice, warning')
    .eq('disease_id', diseaseId.value);


    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}