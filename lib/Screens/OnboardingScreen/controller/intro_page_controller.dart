import 'package:get/get.dart';

class IntropageController extends GetxController{

  int currentPage = 0;
  RxInt dotPage = 0.obs;

  final List<String> titles = [
    'About FarmEasy',
    'Landowners',
    'Farmers',
    'Partners',

  ];

  final List<String> subtitles = [
    'Bringing Farmers and Landowners Together, Cultivating Connections for a Prosperous Tomorrow.',
     'Optimize Land Use, Seamlessly Connect with Farmers, Services.',
    'Boost Yield, Access Tools, Market Insights, Connect with Resources.',
    'Tailored Support, Enhance Efficiency, Grow Together with Farming Community.'
  ];

  final List<String> imagePaths = [
    'assets/img/intro1.svg',
    'assets/img/intro2.svg',
    'assets/img/intro3.svg',
    'assets/img/intro2.svg',

  ];
}