import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryCloseDialog extends StatelessWidget {
  EnquiryCloseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      title: const Text(
        "Do you want to clear the data?",
        textAlign: TextAlign.left,
      ),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Cancle',
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Ok',
                ),
              ),
            ],
          )
        ])
      ],
    );
  }
}
