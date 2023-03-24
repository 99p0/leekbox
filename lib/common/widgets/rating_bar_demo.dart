// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class RatingBarDemo extends ConsumerStatefulWidget {
//   const RatingBarDemo({Key? key}) : super(key: key);
//
//   @override
//   State<RatingBarDemo> createState() => _RatingBarDemoState();
// }
//
// class _RatingBarDemoState extends ConsumerState<RatingBarDemo> {
//   final _initialRating = 5.0;
//   double _rating = 5.0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 245, 245),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RatingBar(
//               ratingWidget: RatingWidget(
//                 full: Icon(Icons.star, color: Colors.yellow[600]),
//                 half: Icon(Icons.star_half, color: Colors.yellow[600]),
//                 empty: Icon(Icons.star_border, color: Colors.yellow[600]),
//               ),
//               onRatingUpdate: (ratingValue) {
//                 setState(() {
//                   _rating = ratingValue;
//                 });
//               },
//               glowColor: Colors.yellow[300],
//               initialRating: _initialRating,
//               allowHalfRating: true,
//               itemPadding: const EdgeInsets.all(2.0),
//             ),
//             const SizedBox(width: 5.0),
//             Text(
//               '$_rating',
//               style:
//                   const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RatingBuilderDemo extends ConsumerStatefulWidget {
//   const RatingBuilderDemo({Key? key}) : super(key: key);
//
//   @override
//   State<RatingBuilderDemo> createState() => _RatingBuilderDemoState();
// }
//
// class _RatingBuilderDemoState extends ConsumerState<RatingBuilderDemo> {
//   final _initialRating = 5.0;
//   double _rating = 5.0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('RatingBarBuilder'),
//         backgroundColor: Colors.red[400]!,
//       ),
//       backgroundColor: const Color.fromARGB(255, 245, 245, 245),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RatingBar.builder(
//               itemBuilder: ((context, index) {
//                 switch (index) {
//                   case 0:
//                     return const Icon(
//                       Icons.sentiment_very_dissatisfied,
//                       color: Colors.red,
//                     );
//                   case 1:
//                     return const Icon(
//                       Icons.sentiment_dissatisfied,
//                       color: Colors.redAccent,
//                     );
//                   case 2:
//                     return const Icon(
//                       Icons.sentiment_neutral,
//                       color: Colors.amber,
//                     );
//                   case 3:
//                     return const Icon(
//                       Icons.sentiment_satisfied,
//                       color: Colors.lightGreen,
//                     );
//                   case 4:
//                     return const Icon(
//                       Icons.sentiment_very_satisfied,
//                       color: Colors.green,
//                     );
//                   default:
//                     return Container();
//                 }
//               }),
//               onRatingUpdate: (ratingValue) {
//                 setState(() {
//                   _rating = ratingValue;
//                 });
//               },
//               tapOnlyMode: true,
//               glow: false,
//               unratedColor: Colors.blueGrey,
//               initialRating: _initialRating,
//               itemPadding: const EdgeInsets.all(2.0),
//             ),
//             const SizedBox(width: 5.0),
//             Text(
//               '$_rating',
//               style:
//                   const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RatingIndicatorDemo extends ConsumerStatefulWidget {
//   const RatingIndicatorDemo({Key? key}) : super(key: key);
//
//   @override
//   State<RatingIndicatorDemo> createState() => _RatingIndicatorDemoState();
// }
//
// class _RatingIndicatorDemoState extends ConsumerState<RatingIndicatorDemo> {
//   final maxRating = 5.0;
//   double _rating = 5.0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('RatingBarIndicator'),
//         backgroundColor: Colors.red[400]!,
//       ),
//       backgroundColor: const Color.fromARGB(255, 245, 245, 245),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 RatingBarIndicator(
//                   itemBuilder: ((context, index) => Icon(
//                         Icons.star,
//                         color: Colors.yellow[600],
//                       )),
//                   itemPadding: const EdgeInsets.all(2.0),
//                   rating: _rating,
//                 ),
//                 const SizedBox(
//                   width: 5.0,
//                 ),
//                 Text(
//                   _rating.toStringAsPrecision(2),
//                   style: const TextStyle(
//                       fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 5.0),
//             Slider(
//               value: _rating / maxRating,
//               onChanged: (value) {
//                 setState(() {
//                   _rating = value * maxRating;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
