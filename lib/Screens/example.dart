// import 'package:easybillbook/Routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 720),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             textTheme: GoogleFonts.nunitoSansTextTheme(
//               Theme.of(context).textTheme.apply(fontSizeFactor: 1.sp),
//             ),
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             useMaterial3: true,
//           ),
//
//           builder: (context, widget) {
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 textScaleFactor: 1.0,
//               ),
//               child: widget ?? const SizedBox(),
//             );
//           },
//           getPages: AppRoutes.appPages(),
//         );
//       },
//     );
//   }
// }
