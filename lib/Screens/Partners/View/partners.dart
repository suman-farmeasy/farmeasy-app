import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/agri_provider_controller.dart';
import 'package:farm_easy/Screens/Partners/Controller/partner_services_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AllPartners extends StatefulWidget {
  AllPartners({super.key, required this.id});
  int id;
  @override
  State<AllPartners> createState() => _AllPartnersState();
}

class _AllPartnersState extends State<AllPartners> {
  final ScrollController _agriScroller = ScrollController();
  final servicecontroller = Get.put(PartnerServicesController());
  final agriController = Get.put(ListAgriProviderController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    servicecontroller.nearbyPartnerServices(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(servicecontroller.selectedIndex.value);
    _agriScroller.addListener(() {
      if (_agriScroller.position.pixels ==
          _agriScroller.position.maxScrollExtent) {
        agriController.loadMoreData();
      }
    });
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            title: 'Agri-Partners',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            controller: _agriScroller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: AppDimension.h * 0.05,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (servicecontroller
                                    .servicesData.value.result?.length ??
                                0) +
                            1,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              servicecontroller.selectedIndex.value == index;
                          if (index == 0) {
                            return InkWell(
                              onTap: () {
                                servicecontroller.selectItem(0);
                                servicecontroller.nearbyPartnerServices(0);
                                setState(() {});
                                agriController.agriDataListId(index);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? AppColor.PRIMARY_GRADIENT
                                      : AppColor.WHITE_GRADIENT,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? Color(0x70044D3A)
                                        : AppColor.GREY_BORDER,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'All Services',
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? AppColor.DARK_GREEN
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            int serviceIndex = index - 1;
                            return InkWell(
                              onTap: () {
                                agriController.refreshAllagriProviderId();
                                servicecontroller.selectItem(index);
                                servicecontroller.nearbyPartnerServices(index);
                                agriController.agriDataListId(index);
                                widget.id = index;
                                print("#@@#@#@${widget.id}");
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? AppColor.PRIMARY_GRADIENT
                                      : AppColor.WHITE_GRADIENT,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? Color(0x70044D3A)
                                        : AppColor.GREY_BORDER,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    servicecontroller.servicesData.value
                                            .result?[serviceIndex].name ??
                                        '',
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? AppColor.DARK_GREEN
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.GREY_BORDER),
                  ),
                  child: TextFormField(
                    controller: servicecontroller.searchKeyword.value,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: InputBorder.none,
                        hintText: "Search  Agri-partner",
                        hintStyle: TextStyle(
                          color: Color(0xCC61646B),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            agriController.clearSearch();
                          },
                          child: Icon(Icons.close, color: AppColor.BROWN_TEXT),
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: AppColor.BROWN_TEXT)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' Nearby Agri-Partners ',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF483C32),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: Get.height * 0.14,
                  child: Obx(() {
                    if (servicecontroller.nearbyLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (servicecontroller.rxRequestStatusNearby.value ==
                        Status.ERROR) {
                      return Text('Error fetching data');
                    } else if (servicecontroller
                            .nearbyPartner.value.result?.data?.length ==
                        0) {
                      return Center(
                          child: Text(
                        'No Partners Found',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF483C32),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: servicecontroller
                                  .nearbyPartner.value.result?.data?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container(
                              width: Get.width * 0.8,
                              margin: EdgeInsets.only(top: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => UserProfileScreen(
                                          id: servicecontroller
                                                  .nearbyPartner
                                                  .value
                                                  .result
                                                  ?.data?[index]
                                                  .userId!
                                                  .toInt() ??
                                              0,
                                          userType: servicecontroller
                                                  .nearbyPartner
                                                  .value
                                                  .result
                                                  ?.data?[index]
                                                  .userType ??
                                              ""));
                                    },
                                    child: Container(
                                        width: Get.width * 0.24,
                                        height: Get.height * 0.14,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${servicecontroller.nearbyPartner.value.result?.data?[index].image ?? ""}"),
                                                fit: BoxFit.cover),
                                            color: AppColor.DARK_GREEN,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(18),
                                                topLeft: Radius.circular(18)))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Text(
                                            '${servicecontroller.nearbyPartner.value.result?.data?[index].fullName ?? ""}',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.BROWN_TEXT,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/farm/locationbrown.svg",
                                              width: 14,
                                            ),
                                            Container(
                                              width: Get.width * 0.45,
                                              child: Text(
                                                '  ${servicecontroller.nearbyPartner.value.result?.data?[index].livesIn ?? ""}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF61646B),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            ' Deals in ',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF61646B),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          width: Get.width * 0.45,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: servicecontroller
                                                    .nearbyPartner
                                                    .value
                                                    .result
                                                    ?.data?[index]
                                                    .services
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, itemIndex) {
                                              int displayLimit =
                                                  1; // Number of items to display directly
                                              int totalItems = servicecontroller
                                                      .nearbyPartner
                                                      .value
                                                      .result
                                                      ?.data?[index]
                                                      .services
                                                      ?.length ??
                                                  0;

                                              if (itemIndex < displayLimit) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color(0x14167C0C),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${servicecontroller.nearbyPartner.value.result?.data?[index].services?[itemIndex].name ?? ""}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (itemIndex ==
                                                  displayLimit) {
                                                int remainingItems =
                                                    totalItems - displayLimit;
                                                return Center(
                                                  child: Text(
                                                    '  +${remainingItems} more',
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF61646B),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                // Hide additional items
                                                return SizedBox.shrink();
                                              }
                                            },
                                          ),
                                        )

                                        // Container(
                                        //   margin: EdgeInsets.only(
                                        //       left: Get.width * 0.37, bottom: 5),
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 15, vertical: 2),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     border: Border.all(
                                        //         color: AppColor.DARK_GREEN,
                                        //         width: 1),
                                        //   ),
                                        //   child: InkWell(
                                        //     onTap: () {
                                        //       Get.to(() => ChatScreen(
                                        //             landId: 0,
                                        //             enquiryId: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .enquiryId
                                        //                     ?.toInt() ??
                                        //                 0,
                                        //             userId: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .userId
                                        //                     ?.toInt() ??
                                        //                 0,
                                        //             userType: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .userType ??
                                        //                 "",
                                        //             userFrom: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .livesIn ??
                                        //                 "",
                                        //             userName: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .fullName ??
                                        //                 "",
                                        //             image: agriController
                                        //                     .agriProviderData[
                                        //                         index]
                                        //                     .image ??
                                        //                 "",
                                        //             isEnquiryCreatedByMe: false,
                                        //             isEnquiryDisplay: false,
                                        //             enquiryData: "",
                                        //           ));
                                        //     },
                                        //     child: Row(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Icon(
                                        //           Icons.call,
                                        //           color: AppColor.DARK_GREEN,
                                        //           size: 15,
                                        //         ),
                                        //         Text(
                                        //           '  Contact ',
                                        //           style: TextStyle(
                                        //             color: Color(0xFF044D3A),
                                        //             fontSize: 9,
                                        //             fontFamily: 'Poppins',
                                        //             fontWeight: FontWeight.w500,
                                        //             height: 0.16,
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Agri-Partner ',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF483C32),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                widget.id == 0
                    ? Obx(() {
                        if (agriController.loading.value &&
                            agriController.agriProviderData.isEmpty) {
                          return CircularProgressIndicator();
                        } else if (agriController.rxRequestStatus.value ==
                            Status.ERROR) {
                          return Text('Error fetching data');
                        } else if (agriController.agriProviderData.isEmpty) {
                          return Text('No data available');
                        } else {
                          return ListView.builder(
                              itemCount:
                                  agriController.agriProviderData.length ?? 0,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
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
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                              id: agriController
                                                  .agriProviderData[index]
                                                  .userId!
                                                  .toInt(),
                                              userType: agriController
                                                      .agriProviderData[index]
                                                      .userType ??
                                                  ""));
                                        },
                                        child: Container(
                                            width: Get.width * 0.24,
                                            height: Get.height * 0.14,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${agriController.agriProviderData[index].image ?? ""}"),
                                                    fit: BoxFit.cover),
                                                color: AppColor.DARK_GREEN,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(18),
                                                    topLeft:
                                                        Radius.circular(18)))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: Text(
                                                '${agriController.agriProviderData[index].fullName ?? ""}',
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.BROWN_TEXT,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/farm/locationbrown.svg",
                                                  width: 14,
                                                ),
                                                Container(
                                                  width: Get.width * 0.45,
                                                  child: Text(
                                                    '  ${agriController.agriProviderData[index].livesIn ?? ""}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF61646B),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                ' Deals in ',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF61646B),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              width: Get.width * 0.6,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: agriController
                                                        .agriProviderData[index]
                                                        .roles
                                                        ?.length ??
                                                    0,
                                                itemBuilder:
                                                    (context, itemIndex) {
                                                  int displayLimit =
                                                      1; // Number of items to display directly
                                                  int totalItems =
                                                      agriController
                                                              .agriProviderData[
                                                                  index]
                                                              .roles
                                                              ?.length ??
                                                          0;

                                                  if (itemIndex <
                                                      displayLimit) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            Color(0x14167C0C),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${agriController.agriProviderData[index].roles![itemIndex].name ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (itemIndex ==
                                                      displayLimit) {
                                                    // Display summary for the remaining items
                                                    int remainingItems =
                                                        totalItems -
                                                            displayLimit;
                                                    return Center(
                                                      child: Text(
                                                        '  +${remainingItems} more',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF61646B),
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    // Hide additional items
                                                    return SizedBox.shrink();
                                                  }
                                                },
                                              ),
                                            )

                                            // Container(
                                            //   margin: EdgeInsets.only(
                                            //       left: Get.width * 0.37, bottom: 5),
                                            //   padding: EdgeInsets.symmetric(
                                            //       horizontal: 15, vertical: 2),
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //         BorderRadius.circular(20),
                                            //     border: Border.all(
                                            //         color: AppColor.DARK_GREEN,
                                            //         width: 1),
                                            //   ),
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       Get.to(() => ChatScreen(
                                            //             landId: 0,
                                            //             enquiryId: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .enquiryId
                                            //                     ?.toInt() ??
                                            //                 0,
                                            //             userId: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .userId
                                            //                     ?.toInt() ??
                                            //                 0,
                                            //             userType: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .userType ??
                                            //                 "",
                                            //             userFrom: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .livesIn ??
                                            //                 "",
                                            //             userName: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .fullName ??
                                            //                 "",
                                            //             image: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .image ??
                                            //                 "",
                                            //             isEnquiryCreatedByMe: false,
                                            //             isEnquiryDisplay: false,
                                            //             enquiryData: "",
                                            //           ));
                                            //     },
                                            //     child: Row(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.center,
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment.center,
                                            //       children: [
                                            //         Icon(
                                            //           Icons.call,
                                            //           color: AppColor.DARK_GREEN,
                                            //           size: 15,
                                            //         ),
                                            //         Text(
                                            //           '  Contact ',
                                            //           style: TextStyle(
                                            //             color: Color(0xFF044D3A),
                                            //             fontSize: 9,
                                            //             fontFamily: 'Poppins',
                                            //             fontWeight: FontWeight.w500,
                                            //             height: 0.16,
                                            //           ),
                                            //         )
                                            //       ],
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Lottie.asset(
                                      "assets/lotties/animation.json",
                                      height: 100,
                                      width: double.infinity),
                                )
                              ],
                            ),
                          );
                        }
                      })
                    : Obx(() {
                        if (agriController.loading.value &&
                            agriController.agriProviderDataId.isEmpty) {
                          return CircularProgressIndicator();
                        } else if (agriController.rxRequestStatus.value ==
                            Status.ERROR) {
                          return Text('Error fetching data');
                        } else if (agriController.agriProviderDataId.isEmpty) {
                          return Text('No data available');
                        } else {
                          return ListView.builder(
                              itemCount:
                                  agriController.agriProviderDataId.length ?? 0,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
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
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                              id: agriController
                                                  .agriProviderDataId[index]
                                                  .userId!
                                                  .toInt(),
                                              userType: agriController
                                                      .agriProviderDataId[index]
                                                      .userType ??
                                                  ""));
                                        },
                                        child: Container(
                                            width: Get.width * 0.24,
                                            height: Get.height * 0.14,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${agriController.agriProviderDataId[index].image ?? ""}"),
                                                    fit: BoxFit.cover),
                                                color: AppColor.DARK_GREEN,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(18),
                                                    topLeft:
                                                        Radius.circular(18)))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: Text(
                                                '${agriController.agriProviderDataId[index].fullName ?? ""}',
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.BROWN_TEXT,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/farm/locationbrown.svg",
                                                  width: 14,
                                                ),
                                                Container(
                                                  width: Get.width * 0.45,
                                                  child: Text(
                                                    '  ${agriController.agriProviderDataId[index].livesIn ?? ""}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF61646B),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                ' Deals in ',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF61646B),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              width: Get.width * 0.6,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: agriController
                                                        .agriProviderDataId[
                                                            index]
                                                        .roles
                                                        ?.length ??
                                                    0,
                                                itemBuilder:
                                                    (context, itemIndex) {
                                                  int displayLimit =
                                                      1; // Number of items to display directly
                                                  int totalItems = agriController
                                                          .agriProviderDataId[
                                                              index]
                                                          .roles
                                                          ?.length ??
                                                      0;

                                                  if (itemIndex <
                                                      displayLimit) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            Color(0x14167C0C),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${agriController.agriProviderDataId[index].roles![itemIndex].name ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (itemIndex ==
                                                      displayLimit) {
                                                    // Display summary for the remaining items
                                                    int remainingItems =
                                                        totalItems -
                                                            displayLimit;
                                                    return Center(
                                                      child: Text(
                                                        '  +${remainingItems} more',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF61646B),
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    // Hide additional items
                                                    return SizedBox.shrink();
                                                  }
                                                },
                                              ),
                                            )

                                            // Container(
                                            //   margin: EdgeInsets.only(
                                            //       left: Get.width * 0.37, bottom: 5),
                                            //   padding: EdgeInsets.symmetric(
                                            //       horizontal: 15, vertical: 2),
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //         BorderRadius.circular(20),
                                            //     border: Border.all(
                                            //         color: AppColor.DARK_GREEN,
                                            //         width: 1),
                                            //   ),
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       Get.to(() => ChatScreen(
                                            //             landId: 0,
                                            //             enquiryId: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .enquiryId
                                            //                     ?.toInt() ??
                                            //                 0,
                                            //             userId: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .userId
                                            //                     ?.toInt() ??
                                            //                 0,
                                            //             userType: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .userType ??
                                            //                 "",
                                            //             userFrom: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .livesIn ??
                                            //                 "",
                                            //             userName: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .fullName ??
                                            //                 "",
                                            //             image: agriController
                                            //                     .agriProviderData[
                                            //                         index]
                                            //                     .image ??
                                            //                 "",
                                            //             isEnquiryCreatedByMe: false,
                                            //             isEnquiryDisplay: false,
                                            //             enquiryData: "",
                                            //           ));
                                            //     },
                                            //     child: Row(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.center,
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment.center,
                                            //       children: [
                                            //         Icon(
                                            //           Icons.call,
                                            //           color: AppColor.DARK_GREEN,
                                            //           size: 15,
                                            //         ),
                                            //         Text(
                                            //           '  Contact ',
                                            //           style: TextStyle(
                                            //             color: Color(0xFF044D3A),
                                            //             fontSize: 9,
                                            //             fontFamily: 'Poppins',
                                            //             fontWeight: FontWeight.w500,
                                            //             height: 0.16,
                                            //           ),
                                            //         )
                                            //       ],
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Lottie.asset(
                                      "assets/lotties/animation.json",
                                      height: 100,
                                      width: double.infinity),
                                )
                              ],
                            ),
                          );
                        }
                      }),
                Obx(() {
                  return agriController.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(); // Empty SizedBox when not loading
                }),
              ],
            ),
          ),
        ));
  }
}
