// import 'package:flutter/material.dart';
//
//
//
//
//
// class MyHomePage extends StatelessWidget {
//   final List<CardData> cardList = [
//     CardData(
//       backgroundColor: Colors.red,
//       imageAsset: 'assets/card_image1.jpg',
//       title: 'Card 1',
//       subtitle: 'This is the first card',
//     ),
//     CardData(
//       backgroundColor: Colors.blue,
//       imageAsset: 'assets/card_image2.jpg',
//       title: 'Card 2',
//       subtitle: 'This is the second card',
//     ),
//     CardData(
//       backgroundColor: Colors.green,
//       imageAsset: 'assets/card_image3.jpg',
//       title: 'Card 3',
//       subtitle: 'This is the third card',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Card Designs'),
//       ),
//       body: ListView.builder(
//         itemCount: cardList.length,
//         itemBuilder: (context, index) {
//           final cardData = cardList[index];
//           return Card(
//             color: cardData.backgroundColor,
//             child: Column(
//               children: [
//                 Image.asset(cardData.imageAsset),
//                 ListTile(
//                   title: Text(
//                     cardData.title,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     cardData.subtitle,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CardData {
//   final Color backgroundColor;
//   final String imageAsset;
//   final String title;
//   final String subtitle;
//
//   CardData({
//     required this.backgroundColor,
//     required this.imageAsset,
//     required this.title,
//     required this.subtitle,
//   });
// }
