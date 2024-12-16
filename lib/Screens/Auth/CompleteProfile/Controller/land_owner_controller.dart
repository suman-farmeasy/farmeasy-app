import 'package:get/get.dart';

class LandOwnerController extends GetxController{
  RxList title =[
    'Land Owner',
    'Agent'
  ].obs;
  RxString userProfieType =''.obs;
  RxList subtitle =[
    'I own the land.',
    '     Property Broker, Land agent, etc.    '
  ].obs;
  RxInt? select = RxInt(-1);


}