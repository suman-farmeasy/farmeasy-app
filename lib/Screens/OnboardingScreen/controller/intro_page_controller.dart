import 'package:get/get.dart';

class IntropageController extends GetxController {
  int currentPage = 0;
  RxInt dotPage = 0.obs;

  final List<String> titles = [
    'About FarmEasy',
    'Landowners',
    'Farmers',
    'Partners',
  ];

  final List<String> subtitles = [
    'FarmEasy connects farmers and landowners to drive innovative, efficient, and sustainable agriculture.',
    'Work with skilled farmers to make your unused land productive and support sustainable farming.',
    'Find new chances to grow crops and succeed by accessing land and resources through FarmEasy.',
    'Be part of FarmEasy to help make farming more productive and eco-friendly with smart solutions.'
  ];

  final List<String> imagePaths = [
    'assets/img/intro1.svg',
    'assets/img/intro2.svg',
    'assets/img/intro3.svg',
    'assets/img/intro2.svg',
  ];
}
