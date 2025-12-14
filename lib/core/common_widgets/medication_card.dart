// import 'package:flutter/material.dart';
//
// class MedicationCard extends StatelessWidget {
//   final String title;
//   final String time;
//   final bool isTaken;
//   final VoidCallback onTap;
//
//   const MedicationCard({
//     super.key,
//     required this.title,
//     required this.time,
//     required this.isTaken,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isTaken ? Colors.green.shade50 : Colors.blue.shade50,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isTaken ? Colors.green : Colors.blue,
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Icon
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: isTaken ? Colors.green.shade100 : Colors.blue.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.medication,
//                 color: isTaken ? Colors.green : Colors.blue,
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // Text
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       decoration:
//                       isTaken ? TextDecoration.lineThrough : null,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     time,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Check Icon
//             Icon(
//               isTaken
//                   ? Icons.check_circle
//                   : Icons.radio_button_unchecked,
//               color: isTaken ? Colors.green : Colors.grey,
//               size: 26,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  const HorizontalDatePicker({super.key});

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  int selectedIndex = 2;

  final List<DateTime> dates = List.generate(
    7,
        (index) => DateTime.now().add(Duration(days: index)),
  );

  String dayName(DateTime date) {
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              width: 65,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName(date),
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
