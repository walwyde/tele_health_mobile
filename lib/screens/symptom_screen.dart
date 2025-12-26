
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/diagnosis_controller.dart';
import 'result_screen.dart';

class SymptomScreen extends StatelessWidget {
  SymptomScreen({super.key});

  // Initialize controller outside build
  final controller = Get.put(DiagnosisController());

  final symptoms = const [
    'fever', 'headache', 'cough', 'shortness of breath', 'chest pain',
    'vomiting', 'diarrhea', 'fatigue', 'weight loss', 'frequent urination',
    'excessive thirst', 'blurred vision', 'dizziness', 'joint pain',
    'skin rash', 'sore throat', 'loss of appetite', 'night sweats'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('TeleHealth AI Symptom Diagnosis', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      // We wrap the whole Stack in ONE Obx to ensure all observables are tracked together
      body: Obx(() {
        // EXPLICIT ACCESS: This tells GetX to listen to these two variables
        // if this code is not here, and the list is empty/loading is false, 
        // GetX might think there's nothing to watch.
        bool loading = controller.isLoading.value;
        int selectedCount = controller.selectedSymptoms.length;

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Identify Symptoms", 
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E))),
                      SizedBox(height: 8),
                      Text("Select all that apply to you.", 
                        style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: symptoms.length,
                    itemBuilder: (context, index) {
                      final symptom = symptoms[index];
                      // Use the controller directly here
                      final isSelected = controller.selectedSymptoms.contains(symptom);
                      
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            if (isSelected) {
                              controller.selectedSymptoms.remove(symptom);
                            } else {
                              controller.selectedSymptoms.add(symptom);
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? Colors.blueAccent : Colors.transparent,
                                width: 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.black.withOpacity(0.02),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.check_circle : Icons.add_circle_outline,
                                  color: isSelected ? Colors.blueAccent : Colors.grey[400],
                                  size: 28,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  symptom.capitalizeFirst!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? Colors.blueAccent : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom Button
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  child: ElevatedButton(
                    onPressed: loading ? null : () async {
                      if (controller.selectedSymptoms.isEmpty) {
                        Get.snackbar("Required", "Please select a symptom");
                        return;
                      }
                      await controller.diagnose();
                      Get.to(() => const ResultScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 65),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    child: loading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Analyze $selectedCount Symptoms', 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),

            // Loading Overlay
            if (loading)
              Container(
                color: Colors.white.withOpacity(0.8),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.blueAccent),
                      SizedBox(height: 20),
                      Text("AI is analyzing...", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}