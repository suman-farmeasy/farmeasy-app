import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ListTagsResponseModel.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/ViewModel/createthreads_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ListNewTagsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tagList();
    print("TAGSDATA");
  }

  final _api = ListNewTagsViewModel();
  final tagsData = ListTagsResponseModel().obs;
  final loading = false.obs;
  RxList tags = [].obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListTagsResponseModel _value) =>
      tagsData.value = _value;
  void tagList() {
    loading.value = true;
    _api.listTags().then((value) {
      rxRequestStatus.value = Status.SUCCESS;
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
