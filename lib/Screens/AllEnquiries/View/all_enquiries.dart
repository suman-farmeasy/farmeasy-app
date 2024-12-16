import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/AllEnquiries/Controller/all_enquiries_controller.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class AllEnquiries extends StatefulWidget {
  const AllEnquiries({super.key});

  @override
  State<AllEnquiries> createState() => _AllEnquiriesState();
}

class _AllEnquiriesState extends State<AllEnquiries> {
  final controller = Get.put(AllEnquiriesController());
  final ScrollController _enquiryScroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    _enquiryScroller.addListener(() {
      if (_enquiryScroller.position.pixels ==
          _enquiryScroller.position.maxScrollExtent) {
        controller.loadMoreData();
      }
    });
    return Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: CommonAppBar(title: 'All Enquiries',)),
        body: LayoutBuilder(builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshAllEnquiries();
            },
            child: SingleChildScrollView(

              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Obx(() {
                    if (controller.loading.value &&
                        controller.allEnquiriesList.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.rxRequestStatus.value ==
                        Status.ERROR) {
                      return Center(child: Text('Error fetching data'));
                    } else if (controller.allEnquiriesList.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await controller.refreshAllEnquiries();
                        },
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * 0.8,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _enquiryScroller,
                                itemCount: controller.allEnquiriesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ChatScreen(
                                            landId: controller
                                                    .allEnquiriesList[index].land
                                                    ?.toInt() ??
                                                0,
                                            enquiryId: controller
                                                .allEnquiriesList[index].id!
                                                .toInt(),
                                            userId: controller
                                                .allEnquiriesList[index]
                                                .connectedPersonUserId!
                                                .toInt(),
                                            userName: controller
                                                    .allEnquiriesList[index]
                                                    .connectedPersonName ??
                                                "",
                                            userFrom: controller
                                                    .allEnquiriesList[index]
                                                    .connectedPersonAddress ??
                                                "",
                                            userType: controller
                                                    .allEnquiriesList[index]
                                                    .connectedPersonUserType ??
                                                "",
                                            image: controller
                                                    .allEnquiriesList[index]
                                                    .connectedPersonImage ??
                                                "",
                                            enquiryData: controller
                                                    .allEnquiriesList[index]
                                                    .created ??
                                                "",
                                            isEnquiryCreatedByMe: controller
                                                    .allEnquiriesList[index]
                                                    .isCreatedByMe ??
                                                false,
                                            isEnquiryDisplay: true,
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            height: Get.height * 0.12,
                                            width: Get.width * 0.24,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(controller
                                                            .allEnquiriesList[index]
                                                            .connectedPersonImage ??
                                                        ""),
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
                                                      'Enquiry #${controller.allEnquiriesList[index].id ?? ""}',
                                                      style: TextStyle(
                                                        color: Color(0x7F484848),
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
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
                                                          '  ${controller.allEnquiriesList[index].lastMessageDate ?? ""}',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0x7F484848),
                                                            fontSize: 10,
                                                            fontFamily: 'Poppins',
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
                                                controller.allEnquiriesList[index]
                                                        .connectedPersonName ??
                                                    "",
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
                                                width: Get.width * 0.58,
                                                child: Text(
                                                  '${controller.allEnquiriesList[index].connectedPersonUserType ?? ""} from ${controller.allEnquiriesList[index].connectedPersonAddress ?? ""}',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF333333),
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                controller.allEnquiriesList[index]
                                                        .lastMessage ??
                                                    "",
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
                                },
                              ),
                            ),
                            Obx(() {
                              return controller.loading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : SizedBox(); // Empty SizedBox when not loading
                            }),
                          ],
                        ),
                      );
                    }
                  })),
            ),
          );
        }));
  }
}
