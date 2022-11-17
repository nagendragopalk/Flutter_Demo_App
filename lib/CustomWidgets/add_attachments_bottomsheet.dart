import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAttachmentsBtmShtWidget extends StatelessWidget {
  final void Function() onTapCamera;
  final void Function() onTapGAllery;
  const AddAttachmentsBtmShtWidget({Key? key, required this.onTapCamera, required this.onTapGAllery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // final _bottomSheetHeight = MediaQuery.of(context).size.height * (219 / 896);

    return SafeArea(
      // top: false,
      child: Stack(alignment: Alignment.center, children: [
        Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: _height * (30 / 896)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Attachment Here",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: _width * (24 / 414),
                        height: _height * (24 / 896),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  onTap: onTapCamera,
                  leading: const Icon(Icons.camera_alt),
                  title: const Text(
                    "Take a picture",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  onTap: onTapGAllery,
                  leading: const Icon(Icons.photo_library),
                  title: const Text(
                    "Select from photos",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
