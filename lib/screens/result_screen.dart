

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/diagnosis_controller.dart';

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DiagnosisController>();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFF),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black87,
//         title: const Text('Diagnosis Analysis'),
//       ),
//       body: Obx(() => SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Main Result Card
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(25),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.blue]),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
//                   ),
//                   child: Column(
//                     children: [
//                       const Text('Likely Condition', style: TextStyle(color: Colors.white70, fontSize: 16)),
//                       const SizedBox(height: 8),
//                       Text(
//                         controller.disease.value.capitalizeFirst!,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20),
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             height: 80,
//                             width: 80,
//                             child: CircularProgressIndicator(
//                               value: controller.confidence.value,
//                               strokeWidth: 8,
//                               backgroundColor: Colors.white.withOpacity(0.2),
//                               valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           ),
//                           Text(
//                             "${(controller.confidence.value * 100).toStringAsFixed(0)}%",
//                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       const Text('Confidence Level', style: TextStyle(color: Colors.white70, fontSize: 14)),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),
//                 const Text('Recommended Treatment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
//                 const SizedBox(height: 15),

//                 // Drug List
//                 ...controller.drugs.map((drug) => Container(
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey.shade200),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
//                             child: const Icon(Icons.medication_liquid, color: Colors.blue),
//                           ),
//                           const SizedBox(width: 15),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                                 Text('Dosage: ${drug['dosage']}', style: TextStyle(color: Colors.grey.shade600)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),

//                 const SizedBox(height: 40),
//                 // Warning Box
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.red.withOpacity(0.05),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.red.withOpacity(0.1)),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.info_outline, color: Colors.redAccent, size: 20),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           'AI guidance only. Please consult a professional medical doctor.',
//                           style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/diagnosis_controller.dart';

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DiagnosisController>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Obx(() => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("AI Analysis Result", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Text(controller.disease.value.capitalizeFirst!, 
//                 style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 25),
            
//             // Confidence Meter
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CircularProgressIndicator(
//                         value: controller.confidence.value,
//                         strokeWidth: 6,
//                         backgroundColor: Colors.blue.withOpacity(0.1),
//                         valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
//                       ),
//                       Text("${(controller.confidence.value * 100).toInt()}%", 
//                         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   const SizedBox(width: 20),
//                   const Text("AI Confidence Score", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 35),
//             const Text("Recommended Medication", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 15),

//             if (controller.drugs.isEmpty)
//               const Text("No specific drugs found in database. Please consult a pharmacist.")
//             else
//               ...controller.drugs.map((drug) => _buildDrugCard(drug)),

//             const SizedBox(height: 40),
//             _buildWarningBox(),
//           ],
//         )),
//       ),
//     );
//   }

//   Widget _buildDrugCard(Map<String, dynamic> drug) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.blue.withOpacity(0.1)),
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: const Icon(Icons.medication, color: Colors.blueAccent, size: 30),
//         title: Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//         subtitle: Text("Suggested Dosage: ${drug['dosage']}"),
//       ),
//     );
//   }

//   Widget _buildWarningBox() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(15)),
//       child: const Row(
//         children: [
//           Icon(Icons.warning_amber_rounded, color: Colors.red),
//           SizedBox(width: 15),
//           Expanded(
//             child: Text(
//               "Disclaimer: This AI result is for informational purposes only and is not a clinical diagnosis. Seek professional medical help immediately if your symptoms worsen.",
//               style: TextStyle(color: Colors.red, fontSize: 13),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/diagnosis_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiagnosisController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.white, 
        foregroundColor: Colors.black,
        title: const Text("Analysis Report", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center aligned for better impact
          children: [
            const Text(
              "AI Analysis Result", 
              style: TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            Text(
              controller.disease.value.capitalizeFirst!, 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E)),
            ),
            
            const SizedBox(height: 40),
            
            // DRAMATIC CONFIDENCE METER
            Center(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(begin: 0, end: controller.confidence.value),
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Glow / Subtle Circle
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.03),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.1),
                              blurRadius: 30,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      ),
                      // The Progress Indicator
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 12, // Thicker for dramatic effect
                          strokeCap: StrokeCap.round, // Rounded ends for a modern look
                          backgroundColor: Colors.grey.shade100,
                          valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
                        ),
                      ),
                      // The Percentage Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${(value * 100).toInt()}%",
                            style: const TextStyle(
                              fontSize: 42, 
                              fontWeight: FontWeight.w900, // Black weight
                              color: Color(0xFF1A1C2E),
                              letterSpacing: -1,
                            ),
                          ),
                          const Text(
                            "CONFIDENCE",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 50),
            
            // RECOMMENDED DRUGS SECTION
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Recommended Medication", 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E)),
              ),
            ),
            const SizedBox(height: 15),

            if (controller.drugs.isEmpty)
              _buildEmptyState()
            else
              ...controller.drugs.map((drug) => _buildDrugCard(drug)),

            const SizedBox(height: 40),
            _buildWarningBox(),
            const SizedBox(height: 20),
          ],
        )),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Text(
        "No specific drugs found in database. Please consult a pharmacist or doctor for a prescription.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildDrugCard(Map<String, dynamic> drug) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.medication_rounded, color: Colors.blueAccent, size: 28),
        ),
        title: Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        subtitle: Text("Dosage: ${drug['dosage']}", style: const TextStyle(color: Colors.blueGrey)),
      ),
    );
  }

  Widget _buildWarningBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.gpp_maybe_rounded, color: Colors.redAccent, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Medical Disclaimer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const SizedBox(height: 4),
                Text(
                  "This AI result is for informational purposes only. It is not a clinical diagnosis. Seek professional medical help if your symptoms persist.",
                  style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}