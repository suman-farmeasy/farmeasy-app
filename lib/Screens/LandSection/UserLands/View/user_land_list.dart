import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Constants/image_constant.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:farm_easy/Screens/LandSection/UserLands/Controller/user_land_controller.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLandList extends StatefulWidget {
  const UserLandList({super.key, required this.userId});
  final int userId;

  @override
  State<UserLandList> createState() => _UserLandListState();
}

class _UserLandListState extends State<UserLandList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    landController.allLandList(widget.userId);

    _landScroller.addListener(() {
      if (_landScroller.position.pixels ==
          _landScroller.position.maxScrollExtent) {
        landController.loadMoreData(widget.userId);
      }
    });
  }

  @override
  void dispose() {
    _landScroller.dispose();
    super.dispose();
  }

  final landController = Get.put(UserLandsController());
  final ScrollController _landScroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.06),
        child: CommonAppBar(
          isbackButton: true,
          title: 'Lands',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await landController.refreshAllLandData(widget.userId);
        },
        child: Obx(() {
          if (landController.loading.value && landController.landData.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (landController.rxRequestStatus.value == Status.ERROR) {
            return Text('Error fetching data');
          } else if (landController.landData.isEmpty) {
            return Text('No data available');
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                  controller: _landScroller,
                  itemCount: landController.landData.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => RecommendedLandInfo(
                                  id: landController.landData[index].id
                                          ?.toInt() ??
                                      0,
                                  name: landController
                                          .landData[index].landOwnerName ??
                                      "",
                                ));
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)),
                                    color: Colors.white,
                                    boxShadow: [AppColor.BOX_SHADOW]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return landController.landData[index]
                                                  .landImages?.length !=
                                              0
                                          ? Column(
                                              children: [
                                                Container(
                                                  height: Get.height * 0.17,
                                                  child: ListView.builder(
                                                      itemCount: landController
                                                              .landData[index]
                                                              .landImages
                                                              ?.length ??
                                                          0,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, imgindex) {
                                                        return Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          height:
                                                              Get.height * 0.17,
                                                          width:
                                                              Get.width * 0.34,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      "${landController.landData[index].landImages?[imgindex].image}"),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        );
                                                      }),
                                                ),
                                                Row(
                                                  children: List.generate(
                                                      450 ~/ 4,
                                                      (index) => Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              color: index %
                                                                          2 ==
                                                                      0
                                                                  ? Colors
                                                                      .transparent
                                                                  : AppColor
                                                                      .GREY_BORDER,
                                                              height: 1,
                                                            ),
                                                          )),
                                                ),
                                              ],
                                            )
                                          : Container();
                                    }),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              ImageConstants.LAND,
                                              height: 28,
                                              width: 28,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text(
                                                "Land #${landController.landData[index].id ?? 0}",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.DARK_GREEN,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  height: 2.5,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.25,
                                              child: Text(
                                                "${landController.landData[index].city ?? ""} ${landController.landData[index].state ?? ""} ${landController.landData[index].country ?? ""}",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.GREEN_SUBTEXT,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: Get.height * 0.12,
                                          child: Column(
                                            children: List.generate(
                                              450 ~/ 10,
                                              (index) => Expanded(
                                                child: Container(
                                                  color: index % 2 == 0
                                                      ? Colors.transparent
                                                      : AppColor.GREY_BORDER,
                                                  width:
                                                      1, // Height changed to width
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: Get.height * 0.13,
                                          width: Get.width * 0.3,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  ImageConstants.AREA,
                                                  height: 28,
                                                  width: 28,
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    'Area',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 2.5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: AppDimension.w * 0.5,
                                                  child: Text(
                                                    "${landController.landData[index].landSize ?? ""}",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color: AppColor
                                                          .GREEN_SUBTEXT,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: Get.height * 0.12,
                                          child: Column(
                                            children: List.generate(
                                              450 ~/ 10,
                                              (index) => Expanded(
                                                child: Container(
                                                  // Adjusted to horizontal margin
                                                  color: index % 2 == 0
                                                      ? Colors.transparent
                                                      : AppColor.GREY_BORDER,
                                                  width:
                                                      1, // Height changed to width
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.3,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                  ImageConstants.CROP,
                                                  height: 28,
                                                  width: 28,
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    'Crop Preferences',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 2.5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: Get.width * 0.2,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: landController
                                                            .landData[index]
                                                            .cropToGrow
                                                            ?.length ??
                                                        0,
                                                    itemBuilder:
                                                        (context, cropdata) {
                                                      return Text(
                                                        "${landController.landData[index].cropToGrow?[cropdata].name ?? ""}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .GREEN_SUBTEXT,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        width: double.infinity,
                                        child: DottedBorder(
                                            color: AppColor.GREY_BORDER,
                                            radius: Radius.circular(12),
                                            borderType: BorderType.RRect,
                                            dashPattern: [5, 2],
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('Land Owner’s Purpose',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF044D3A),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              AppColor
                                                                  .DARK_GREEN,
                                                        )),
                                                    Text(
                                                      '${landController.landData[index].purpose?.name ?? ""}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF044D3A),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    color: Color(0x38044D3A),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ImageConstants.ENQUIRIES,
                                      width: Get.width * 0.06,
                                    ),
                                    Text(
                                      'Contact Land Owner',
                                      style: GoogleFonts.poppins(
                                        color: AppColor.DARK_GREEN,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
        }),
      ),
    );
  }
}
