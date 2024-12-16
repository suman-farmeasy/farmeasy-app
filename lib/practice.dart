// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
//
// class OtpAutoFillExample extends StatefulWidget {
//   @override
//   _OtpAutoFillExampleState createState() => _OtpAutoFillExampleState();
// }
//
// class _OtpAutoFillExampleState extends State<OtpAutoFillExample> {
//   final TextEditingController _mainController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _mainController.addListener(_handleInputChange);
//   }
//
//   void _handleInputChange() {
//     String input = _mainController.text;
//
//     if (input.length <= 4) {
//       _otpController.text =
//           input;
//     } else {
//       // Optionally, you can handle cases where input length exceeds 4
//       _otpController.text = input.substring(0, 4);
//     }
//   }
//
//   @override
//   void dispose() {
//     _mainController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Auto Fill Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _mainController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter OTP',
//                 hintText: 'Type here...',
//               ),
//             ),
//             SizedBox(height: 20),
//             Pinput(
//               controller: _otpController,
//               length: 4, // Define OTP length
//               onChanged: (value) {
//                 print('OTP Changed: $value');
//               },
//               onCompleted: (value) {
//                 print('OTP Completed: $value');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
