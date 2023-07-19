// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:smartcook/Utils/colors.dart';

// class Test extends StatelessWidget {
//   String ingredientTitle;
//   String ingredientsNumber;
//   String calories;
//   String servings;
//   String time;
//   Test(
//       {key,
//       this.ingredientTitle,
//       this.ingredientsNumber,
//       this.calories,
//       this.servings,
//       this.time});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 1.2,
//       decoration: BoxDecoration(
//         color: ColorSet.darkWhiteColor,
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Center(
//               child: Column(
//                 children: [
//                   Text(
//                     "Ingredient title",
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     ingredientsNumber,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 28,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Icon(
//                       CommunityMaterialIcons.clock,
//                       size: 22,
//                       color: ColorSet.primaryColor,
//                     ),
//                     Text(
//                       time + " min",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Icon(
//                       CommunityMaterialIcons.fire,
//                       size: 22,
//                       color: ColorSet.primaryColor,
//                     ),
//                     Text(
//                       calories + " Kcal",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Icon(
//                       CommunityMaterialIcons.silverware_fork_knife,
//                       size: 22,
//                       color: ColorSet.primaryColor,
//                     ),
//                     Text(
//                       servings,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           )
//         ],
//       ),
//     );
//   }
// }
