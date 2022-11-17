import 'package:get/get.dart';
import 'package:home/CustomWidgets/loading_dialog.dart';

const tokenBox = "token";

showLoadingDialog() {
  return Get.dialog(
    LoadingDialog(
      color: Get.theme.primaryColor,
    ),
    barrierDismissible: false,
    useSafeArea: false,
  );
}

closeLoadingDialog() {
  if (Get.isDialogOpen!) {
    return Get.back();
  }
}
