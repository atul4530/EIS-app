import 'package:get/get.dart';

class ApproveoaderHelper extends GetxController{
  bool approveLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    approveLoading=true;
    update();
  }
}