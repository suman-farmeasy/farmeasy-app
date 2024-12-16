import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/state_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateFilter extends StatefulWidget {
  const StateFilter({super.key});

  @override
  State<StateFilter> createState() => _StateFilterState();
}

class _StateFilterState extends State<StateFilter> {
  final controller = Get.put(StateFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: "State Filter",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
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
                  controller.getStateList(); // Call API on every change
                },
                decoration: InputDecoration(
                    hintText: "Enter State",
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
                            controller.stateData.value.result?.length ?? 0,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.stateId.value = controller
                                      .stateData.value.result?[index].id!
                                      .toInt() ??
                                  0;
                              controller.state.value = controller
                                      .stateData.value.result?[index].name ??
                                  "";
                              print("MARKET ${controller.state.value}");
                              print("STATE ${controller.stateId.value}");
                              // print(
                              //     "EDUCATION ${controller.education.value}");
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(),
                              child: Text(controller
                                      .stateData.value.result?[index].name ??
                                  ""),
                            ),
                          );
                        });
              }),
            )
          ],
        ),
      ),
    );
  }
}
