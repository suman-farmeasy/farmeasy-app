import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/education_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationList extends StatefulWidget {
  const EducationList({super.key});

  @override
  State<EducationList> createState() => _EducationListState();
}

class _EducationListState extends State<EducationList> {
  final controller = Get.put(EducationListController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.GREY_BORDER),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: TextFormField(
                  controller: controller.textController.value,
                  onChanged: (value) {
                    controller.getEducationList(); // Call API on every change
                  },
                  decoration: InputDecoration(
                      hintText: "Enter education",
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Obx(() {
                  return controller.loading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount:
                              controller.educationData.value.result?.length ??
                                  0,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.education.value = controller
                                        .educationData
                                        .value
                                        .result?[index]
                                        .name ??
                                    "";
                                controller.educationId.value = controller
                                        .educationData.value.result?[index].id
                                        ?.toInt() ??
                                    0;
                                print(
                                    "EDUCATION ${controller.educationId.value}");
                                print(
                                    "EDUCATION ${controller.education.value}");
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(),
                                child: Text(controller.educationData.value
                                        .result?[index].name ??
                                    ""),
                              ),
                            );
                          });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
