import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home/CustomWidgets/add_attachments_bottomsheet.dart';
import 'package:home/CustomWidgets/enquiry_cancel_dialog.dart';
import 'package:home/CustomWidgets/gradient_containers.dart';
import 'package:home/CustomWidgets/my_custom_app_bar.dart';
import 'package:home/Screens/Home/user_controller.dart';
import 'package:image_picker/image_picker.dart';

class NewUserAdd extends StatefulWidget {
  const NewUserAdd({super.key});

  @override
  State<NewUserAdd> createState() => _NewUserAddState();
}

class _NewUserAddState extends State<NewUserAdd> {
  final _userFormKey = GlobalKey<FormState>();

  final controller = Get.put(UserController());

  Future<bool> _willPopCallback() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return EnquiryCloseDialog();
      },
    );
    return shouldPop ?? true;
  }

  Future<void> _showDOBPicker(context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now());
    controller.getCustomerDOB(picked!);
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: const MyCustomAppBar(
            height: 80,
            actionsWidget: <Widget>[],
          ),
          body: WillPopScope(
            onWillPop: _willPopCallback,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _userFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                                AddAttachmentsBtmShtWidget(
                                  onTapCamera: () async {
                                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                    if (pickedFile != null) {
                                      controller.userData.imageFile = pickedFile;

                                      controller.update();
                                    }
                                    Get.back();
                                  },
                                  onTapGAllery: () async {
                                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      controller.userData.imageFile = pickedFile;
                                      controller.update();
                                    }
                                    Get.back();
                                  },
                                ),
                                elevation: 10.0,
                                enableDrag: false,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: Get.width * (125 / 414),
                              width: Get.width * (125 / 414),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 5,
                                  // shadowColor: AppConstants.themeConstants.primaryLightColor.withOpacity(0.3),
                                  child: Stack(
                                    children: [
                                      controller.userData.imageFile != null
                                          ? Image.file(
                                              File(controller.userData.imageFile!.path),
                                              height: double.infinity,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              fit: BoxFit.cover,
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.add_a_photo,
                                                size: 35,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: "Name",
                          hintText: "Name",
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter Name";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 20,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) {
                          if (value.trim() != '') {
                            controller.userData.name = value;
                          } else {
                            controller.userData.name = '';
                          }
                        },
                      ),
                      Container(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: "Phone Number",
                          hintText: "Phone Number",
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter Phone Number";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) {
                          if (value.trim() != '') {
                            controller.userData.phoneNumber = value;
                          } else {
                            controller.userData.phoneNumber = '';
                          }
                        },
                      ),
                      Container(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: "Date of birth",
                          hintText: "Date of birth",
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Select Date of birth";
                          } else {
                            return null;
                          }
                        },
                        controller: controller.userDob,
                        readOnly: true,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        onTap: () async {
                          _showDOBPicker(context);
                        },
                        onChanged: (value) {},
                      ),
                      Container(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: "Email address",
                          hintText: "Email address",
                        ),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter Email address";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (value) {
                          if (value.trim() != '') {
                            controller.userData.email = value;
                          } else {
                            controller.userData.email = '';
                          }
                        },
                      ),
                      Container(height: 10),
                      Center(
                        child: MaterialButton(
                          minWidth: 110,
                          height: 50,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            if (_userFormKey.currentState!.validate()) {
                              controller.createEnquiry();
                            }
                          },
                          child: const Text(
                            "Submit",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
