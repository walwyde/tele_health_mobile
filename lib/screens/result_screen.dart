
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/diagnosis_controller.dart';
// import '../screens/chat_screen.dart';

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DiagnosisController>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0, 
//         backgroundColor: Colors.white, 
//         foregroundColor: Colors.black,
//         title: const Text("Analysis Report", style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//         child: Obx(() => Column(
//           crossAxisAlignment: CrossAxisAlignment.center, // Center aligned for better impact
//           children: [
//             const Text(
//               "AI Analysis Result", 
//               style: TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               controller.disease.value.capitalizeFirst!, 
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E)),
//             ),
            
//             const SizedBox(height: 40),
            
//             // DRAMATIC CONFIDENCE METER
//             Center(
//               child: TweenAnimationBuilder<double>(
//                 duration: const Duration(milliseconds: 1500),
//                 curve: Curves.easeOutCubic,
//                 tween: Tween<double>(begin: 0, end: controller.confidence.value),
//                 builder: (context, value, child) {
//                   return Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Background Glow / Subtle Circle
//                       Container(
//                         width: 180,
//                         height: 180,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.blueAccent.withOpacity(0.03),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blueAccent.withOpacity(0.1),
//                               blurRadius: 30,
//                               spreadRadius: 2,
//                             )
//                           ],
//                         ),
//                       ),
//                       // The Progress Indicator
//                       SizedBox(
//                         width: 160,
//                         height: 160,
//                         child: CircularProgressIndicator(
//                           value: value,
//                           strokeWidth: 12, // Thicker for dramatic effect
//                           strokeCap: StrokeCap.round, // Rounded ends for a modern look
//                           backgroundColor: Colors.grey.shade100,
//                           valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
//                         ),
//                       ),
//                       // The Percentage Text
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "${(value * 100).toInt()}%",
//                             style: const TextStyle(
//                               fontSize: 42, 
//                               fontWeight: FontWeight.w900, // Black weight
//                               color: Color(0xFF1A1C2E),
//                               letterSpacing: -1,
//                             ),
//                           ),
//                           const Text(
//                             "CONFIDENCE",
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueGrey,
//                               letterSpacing: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 50),
            
//             // RECOMMENDED DRUGS SECTION
//             Align(
//               alignment: Alignment.centerLeft,
//               child: const Text(
//                 "Recommended Medication", 
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E)),
//               ),
//             ),
//             const SizedBox(height: 15),

//             if (controller.drugs.isEmpty)
//               _buildEmptyState()
//             else
//               ...controller.drugs.map((drug) => _buildDrugCard(drug)),

//             const SizedBox(height: 40),
//             _buildWarningBox(),
//             const SizedBox(height: 20),
//           ],
//         )),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: const Text(
//         "No specific drugs found in database. Please consult a pharmacist or doctor for a prescription.",
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.blueGrey),
//       ),
//     );
//   }

//   Widget _buildDrugCard(Map<String, dynamic> drug) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.blue.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
//           child: const Icon(Icons.medication_rounded, color: Colors.blueAccent, size: 28),
//         ),
//         title: Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//         subtitle: Text("Dosage: ${drug['dosage']}", style: const TextStyle(color: Colors.blueGrey)),
//       ),
//     );
//   }

//   Widget _buildWarningBox() {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFFBFA),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.red.withOpacity(0.1)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(Icons.gpp_maybe_rounded, color: Colors.redAccent, size: 24),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Medical Disclaimer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
//                 const SizedBox(height: 4),
//                 Text(
//                   "This AI result is for informational purposes only. It is not a clinical diagnosis. Seek professional medical help if your symptoms persist.",
//                   style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 13, height: 1.4),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//   onPressed: () => Get.to(() => ChatScreen()),
//   child: const Text("Chat with AI Assistant"),
// )
//         ],

//       ),
      
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/diagnosis_controller.dart';
import './chat_screen.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "AI ANALYSIS RESULT",
              style: TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            Text(
              controller.disease.value.isEmpty ? "No Disease Found" : controller.disease.value.capitalizeFirst!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E)),
            ),

            // --- DISEASE DESCRIPTION SECTION ---
            if (controller.diseaseDescription.value.isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.description_outlined, color: Colors.blueAccent, size: 20),
                        SizedBox(width: 8),
                        Text("About this condition", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.diseaseDescription.value,
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade800, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],

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
                      Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.03),
                          boxShadow: [BoxShadow(color: Colors.blueAccent.withOpacity(0.1), blurRadius: 30)],
                        ),
                      ),
                      SizedBox(
                        width: 160, height: 160,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 12,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.grey.shade100,
                          valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900)),
                          const Text("CONFIDENCE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 50),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Recommended Medication", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1C2E))),
            ),
            const SizedBox(height: 18),

            // RENDERING THE MEDICATION LIST
            if (controller.drugs.isEmpty)
              _buildEmptyState()
            else
              ...controller.drugs.map((drug) => _buildDrugCard(drug)),

            const SizedBox(height: 30),

            // PRIMARY CHAT ACTION
            ElevatedButton(
              onPressed: () => Get.to(() => ChatScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 8,
                shadowColor: Colors.blueAccent.withOpacity(0.3),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded),
                  SizedBox(width: 12),
                  Text("Ask AI About This Result", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _buildWarningBox(),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Text(
        "No specific drugs found in database. Please consult a professional medical doctor.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blueGrey, height: 1.4),
      ),
    );
  }

  Widget _buildDrugCard(Map<String, dynamic> drug) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medication_liquid_rounded, color: Colors.blueAccent, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(drug['name'] ?? 'Unknown Medication', 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1A1C2E))),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow(Icons.timer_outlined, "Dosage", drug['dosage'] ?? 'As directed'),
          
          if (drug['advice'] != null && drug['advice'].toString().isNotEmpty)
            _buildInfoRow(Icons.lightbulb_outline, "Advice", drug['advice']),
            
          if (drug['warning'] != null && drug['warning'].toString().isNotEmpty)
             _buildInfoRow(Icons.warning_amber_rounded, "Warning", drug['warning'], isWarning: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: isWarning ? Colors.redAccent : Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: isWarning ? Colors.redAccent : Colors.black87, height: 1.4),
                children: [
                  TextSpan(text: "$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.gpp_maybe_rounded, color: Colors.redAccent, size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Disclaimer: This AI result is for informational purposes only. Seek professional medical help immediately if symptoms persist.",
              style: TextStyle(color: Colors.redAccent, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}