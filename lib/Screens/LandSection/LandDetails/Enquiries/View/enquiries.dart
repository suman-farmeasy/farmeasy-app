import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/Controller/enquiries_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EnquiriesView extends StatefulWidget {
  const EnquiriesView({
    super.key,
  });

  @override
  State<EnquiriesView> createState() => _EnquiriesViewState();
}

class _EnquiriesViewState extends State<EnquiriesView> {
  final controller = Get.put(EnquiriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Obx(() {
            return controller.loading.value
                ? Center(child: Text("No Enquiries found"))
                : RefreshIndicator(
                    color: AppColor.DARK_GREEN,
                    onRefresh: () async {
                      await controller.enquiriesListData();
                    },
                    child: controller
                                .enquiriesData.value.result?.data?.length !=
                            0
                        ? Container(
                            height: AppDimension.h * 0.77,
                            child: ListView.builder(
                                controller: controller.scrollController,
                                itemCount: controller.enquiriesData.value.result
                                        ?.data?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ChatScreen(
                                            landId: controller.landId.value,
                                            enquiryId: controller.enquiriesData
                                                .value.result!.data![index].id!
                                                .toInt(),
                                            userId: controller
                                                .enquiriesData
                                                .value
                                                .result!
                                                .data![index]
                                                .connectedPersonUserId!
                                                .toInt(),
                                            userName: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .connectedPersonName ??
                                                "",
                                            userFrom: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .connectedPersonAddress ??
                                                "",
                                            userType: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .connectedPersonUserType ??
                                                "",
                                            image: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .connectedPersonImage ??
                                                "",
                                            enquiryData: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .created ??
                                                "",
                                            isEnquiryCreatedByMe: controller
                                                    .enquiriesData
                                                    .value
                                                    .result!
                                                    .data![index]
                                                    .isCreatedByMe ??
                                                false,
                                            isEnquiryDisplay: true,
                                          ));
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            height: Get.height * 0.12,
                                            width: Get.width * 0.25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${controller.enquiriesData.value.result?.data?[index].connectedPersonImage ?? ""}"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Get.size.width * 0.55,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Enquiry # ${controller.enquiriesData.value.result?.data?[index].id ?? 0}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0x7F484848),
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Color(0xFFEB5757),
                                                        ),
                                                        Text(
                                                          '   ${controller.enquiriesData.value.result?.data?[index].lastMessageDate ?? ""}',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0x7F484848),
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '${controller.enquiriesData.value.result?.data?[index].connectedPersonName ?? ""}',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF333333),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                width: Get.width * 0.55,
                                                child: Text(
                                                  '${controller.enquiriesData.value.result?.data?[index].connectedPersonAddress ?? ""}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF333333),
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${controller.enquiriesData.value.result?.data?[index].lastMessage ?? ""}',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF888888),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text("No Enquiries Found"),
                          ),
                  );
          }),
        ),
      ),
    );
  }
}
