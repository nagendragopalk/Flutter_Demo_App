import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home/CustomWidgets/gradient_containers.dart';
import 'package:home/CustomWidgets/my_custom_app_bar.dart';
import 'package:home/CustomWidgets/snackbar.dart';
import 'package:home/routes/app_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? backButtonPressTime;

  String name = Hive.box('settings').get('name', defaultValue: 'Guest') as String;

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null || now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ShowSnackBar().showSnackBar(
        context,
        "exitConfirm",
        duration: const Duration(seconds: 2),
        noAction: true,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: const MyCustomAppBar(
          height: 80,
          actionsWidget: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
            Icon(Icons.more_vert),
          ],
        ),
        drawer: const Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.newUser);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Stack(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Container(
                                          height: 71,
                                          width: 91,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Image.asset(
                                            "assets/images/Logo.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Wrap(
                                          direction: Axis.vertical,
                                          spacing: 2,
                                          children: [
                                            Text('Nagendra Gopal',
                                                style: TextStyle(
                                                    fontSize: 18, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                                            Row(children: [
                                              const Icon(
                                                Icons.phone_android,
                                                size: 12,
                                              ),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: 190,
                                                child: Text('8790088011',
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: 14,
                                                        color: Theme.of(context).colorScheme.secondary,
                                                        fontWeight: FontWeight.w500)),
                                              )
                                            ]),
                                            Row(children: [
                                              const Icon(
                                                Icons.email,
                                                size: 12,
                                              ),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: 240,
                                                child: Text('nagendragopalkatakamsetti@gmail.com',
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontSize: 14, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500)),
                                              )
                                            ])
                                          ],
                                        ),
                                      ]),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[500],
                                    thickness: 2.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.date_range_sharp,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "12-06-2022",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.verified_user_outlined,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Locally",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
          ])),
        ),
      ),
    );
  }
}
