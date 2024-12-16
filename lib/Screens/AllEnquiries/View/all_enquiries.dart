import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/AllEnquiries/Controller/all_enquiries_controller.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllEnquiries extends StatefulWidget {
  AllEnquiries({super.key, this.isbackButton});
  bool? isbackButton = false;
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
            child: CommonAppBar(
              isbackButton: widget.isbackButton ?? false,
              title: 'All Enquiries',
            )),
        body: LayoutBuilder(builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshAllEnquiries();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Obx(() {
                    if (controller.loading.value &&
                        controller.allEnquiriesList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.rxRequestStatus.value ==
                        Status.ERROR) {
                      return const Center(child: Text('Error fetching data'));
                    } else if (controller.allEnquiriesList.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await controller.refreshAllEnquiries();
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.7,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _enquiryScroller,
                                itemCount: controller.allEnquiriesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ChatScreen(
                                            landId: controller
                                                    .allEnquiriesList[index]
                                                    .land
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
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
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => UserProfileScreen(
                                                  id: controller
                                                          .allEnquiriesList[
                                                              index]
                                                          .connectedPersonUserId!
                                                          .toInt() ??
                                                      0,
                                                  userType: controller
                                                          .allEnquiriesList[
                                                              index]
                                                          .connectedPersonUserType ??
                                                      ""));
                                            },
                                            child: Container(
                                              width: Get.width * 0.22,
                                              height: Get.height * 0.12,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                color: AppColor.DARK_GREEN
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  topLeft: Radius.circular(18),
                                                ),
                                                image: controller
                                                                .allEnquiriesList[
                                                                    index]
                                                                .connectedPersonImage !=
                                                            null &&
                                                        controller
                                                                .allEnquiriesList[
                                                                    index]
                                                                .connectedPersonImage !=
                                                            ""
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                          controller
                                                                  .allEnquiriesList[
                                                                      index]
                                                                  .connectedPersonImage! ??
                                                              "",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                              ),
                                              child: controller
                                                          .allEnquiriesList[
                                                              index]
                                                          .connectedPersonImage ==
                                                      ""
                                                  ? Center(
                                                      child: Text(
                                                        controller
                                                                .allEnquiriesList[
                                                                    index]
                                                                .connectedPersonName![
                                                                    0]
                                                                .toUpperCase() ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 50,
                                                          color: AppColor
                                                              .DARK_GREEN, // Text color contrasting the background
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(), // Show nothing if image exists
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Get.size.width * 0.55,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Enquiry #${controller.allEnquiriesList[index].id ?? ""}',
                                                      style: const TextStyle(
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
                                                        const CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Color(0xFFEB5757),
                                                        ),
                                                        Text(
                                                          '  ${controller.allEnquiriesList[index].lastMessageDate ?? ""}',
                                                          style:
                                                              const TextStyle(
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
                                                controller
                                                        .allEnquiriesList[index]
                                                        .connectedPersonName ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF333333),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                width: Get.width * 0.58,
                                                child: Text(
                                                  '${controller.allEnquiriesList[index].connectedPersonUserType ?? ""} from ${controller.allEnquiriesList[index].connectedPersonAddress ?? ""}',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF333333),
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                        .allEnquiriesList[index]
                                                        .lastMessage ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF888888),
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
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const SizedBox(); // Empty SizedBox when not loading
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
