import 'package:image_picker/image_picker.dart';

class CommonService {
  static final CommonService _singleton = CommonService._internal();
  CommonService._internal();
  static CommonService get instance => _singleton;

  int pageSize = 15;
  String deviceId = "";
  String deviceType = "";
  int counter = 0;
  bool rememberMe = false;
  String accessToken = "";
  String refreshToken = "";
  String username = "";
  String userProfile = "";
  String userId = "";
  List<String> permissions = [];

  static Future<XFile?> cameraImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    XFile? file;
    // showLoadingDialog();
    file = await _picker.pickImage(source: ImageSource.camera);
    // closeLoadingDialog();
    if (file == null) {
      return null;
    } else {
      return file;
    }
  }

  static Future<XFile?> galleryImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    XFile? file;
    // showLoadingDialog();
    file = await _picker.pickImage(source: ImageSource.gallery);
    // closeLoadingDialog();
    if (file == null) {
      return null;
    } else {
      return file;
    }
  }
}
