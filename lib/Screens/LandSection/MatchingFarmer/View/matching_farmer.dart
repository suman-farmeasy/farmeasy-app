import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Controller/matching_farmer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchingFarmer extends StatefulWidget {
   MatchingFarmer({super.key,  required this.id});
   int id;

  @override
  State<MatchingFarmer> createState() => _MatchingFarmerState();
}

class _MatchingFarmerState extends State<MatchingFarmer> {
  final farmerController = Get.put(MatchingFarmerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.1),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.DARK_GREEN,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60, left: 10,right: 30),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Get.back();
                }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
                Text(
                  '         Matching Farmers(#${widget.id})',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),


              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          color: AppColor.DARK_GREEN,
          onRefresh: ()async {
            await farmerController.matchingFarmer();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,),
                height: AppDimension.h * 0.83,
                child: ListView.builder(
                    itemCount: farmerController.matchingFarmerData.value.result?.matchingFarmerList?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.GREY_BORDER),
                          boxShadow: [AppColor.BOX_SHADOW],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: Get.width*0.3,
                                height: Get.height*0.15,
                                decoration: BoxDecoration(

                                    image: DecorationImage(
                                        image: NetworkImage(
                                            farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image??""),
                                        fit: BoxFit.cover),
                                    color: Colors.black,
                                    borderRadius:
                                    BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(
                                            18),
                                        topLeft:
                                        Radius.circular(
                                            18)))),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin:EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      '${farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].fullName ?? ""}',
                                      style: GoogleFonts.poppins(
                                        color: AppColor.BROWN_TEXT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/farm/locationbrown.svg",
                                          width: 20,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          child: Text(
                                            '  ${farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
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
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/farm/brownPort.svg",
                                        width: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 5),
                                        height: 20,
                                        width: Get.width*0.4,
                                        child: ListView.builder(
                                            scrollDirection: Axis
                                                .horizontal,
                                            itemCount:
                                            farmerController
                                                .matchingFarmerData
                                                .value
                                                .result!.matchingFarmerList?[
                                            index]
                                                .expertise!
                                                .length??0,
                                            itemBuilder: (context,
                                                experties) {
                                              return Container(
                                                margin: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20),
                                                    color: Color(
                                                        0x14167C0C)),
                                                child: Center(
                                                  child: Text(
                                                    '${farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise![experties].name ?? ""}',
                                                    style: GoogleFonts
                                                        .poppins(
                                                      color: AppColor
                                                          .DARK_GREEN,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      height:
                                                      0.22,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 100,top: 10,bottom: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColor.DARK_GREEN, width: 1),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: AppColor.DARK_GREEN,
                                          size: 22,
                                        ),
                                        Text(
                                          '  Contact Farmer',
                                          style: TextStyle(
                                            color: Color(0xFF044D3A),
                                            fontSize: 9,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0.16,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),

            ],
          ),
        ),
      )
    );
  }
}
