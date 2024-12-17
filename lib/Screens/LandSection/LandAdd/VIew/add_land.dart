import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/crop_suggestion_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/land_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/listother_crop.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/map_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddLand extends StatefulWidget {
  const AddLand({super.key});

  @override
  State<AddLand> createState() => _AddLandState();
}

class _AddLandState extends State<AddLand> {
  final controller = Get.put(LandController());
  final mapcontroller = Get.put(MapController());
  final chatgptCropController = Get.put(ChatGPTCropSuggestionController());
  final otherCropController = Get.put(ListOthersCropController());
  final _formKey = GlobalKey<FormState>();
  final _landSize = GlobalKey<FormState>();
  final _landlease = GlobalKey<FormState>();
  final _landTitle = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  RxString fulladdress = "".obs;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.BROWN_TEXT,
                  )),
              Text(
                'Add Land',
                style: GoogleFonts.poppins(
                  color: AppColor.BROWN_TEXT,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                '      ',
                style: GoogleFonts.poppins(
                  color: AppColor.BROWN_TEXT,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColor.PRIMARY_GRADIENT,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Obx(() {
            return SingleChildScrollView(
              physics: controller.useNeverScrollPhysics.value
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.ARROW,
                        width: 20,
                      ),
                      Text(
                        '    Address information',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF483C32),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0.17,
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return mapcontroller.showMap.value
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFF7),
                              border: Border.all(color: AppColor.GREY_BORDER),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                AppColor.BOX_SHADOW,
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Pin Your Land’s Location',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF272727),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '*',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFEB5757),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Select a location by searching and then press add location',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF757575),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  Obx(() {
                                    return mapcontroller
                                                .currentLocationMarker.value ==
                                            null
                                        ? const CircularProgressIndicator(
                                            color: AppColor.DARK_GREEN,
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              height: Get.height * 0.5,
                                              child: Stack(
                                                children: [
                                                  GoogleMap(
                                                    onMapCreated: (value) {
                                                      mapcontroller
                                                          .mapController
                                                          .value = value;
                                                    },
                                                    initialCameraPosition: mapcontroller
                                                                .pinnedLocation
                                                                .value !=
                                                            null
                                                        ? CameraPosition(
                                                            target: mapcontroller
                                                                .pinnedLocation
                                                                .value!,
                                                            zoom: 15,
                                                          )
                                                        : mapcontroller
                                                                .initialCameraPosition
                                                                .value ??
                                                            const CameraPosition(
                                                              target:
                                                                  LatLng(0, 0),
                                                              zoom: 15,
                                                            ),
                                                    myLocationEnabled: true,
                                                    mapType: MapType.hybrid,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    compassEnabled: true,
                                                    markers: mapcontroller
                                                            .fullAddress
                                                            .value
                                                            .isEmpty
                                                        ? {}
                                                        : {
                                                            mapcontroller
                                                                .currentLocationMarker
                                                                .value!,
                                                          },
                                                    onTap: (LatLng
                                                        position) async {
                                                      List<Placemark>
                                                          placemarks =
                                                          await placemarkFromCoordinates(
                                                              position.latitude,
                                                              position
                                                                  .longitude);

                                                      if (placemarks
                                                          .isNotEmpty) {
                                                        Placemark placemark =
                                                            placemarks.first;
                                                        String streetName =
                                                            "${placemark.thoroughfare} ${placemark.subThoroughfare}";
                                                        String address =
                                                            "${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

                                                        // Save full address and location
                                                        mapcontroller
                                                            .fullAddress
                                                            .value = address;
                                                        mapcontroller
                                                            .pinnedLocation
                                                            .value = position;

                                                        // Update the address fields
                                                        controller
                                                            .addressLine
                                                            .value
                                                            .text = address;

                                                        controller.state.value
                                                                .text =
                                                            placemark
                                                                .administrativeArea!;
                                                        controller.city.value
                                                                .text =
                                                            placemark.locality!;
                                                        controller.county.value
                                                                .text =
                                                            placemark.country!;
                                                        controller.longiTude
                                                                .value =
                                                            position.longitude
                                                                .toString();
                                                        controller.latiTude
                                                                .value =
                                                            position.latitude
                                                                .toString();

                                                        // Print logs
                                                        print(
                                                            "Full address: ${mapcontroller.fullAddress.value}");

                                                        print(
                                                            "Full address2: ${controller.addressLine.value}");

                                                        print(
                                                            "Latitude: ${controller.latiTude.value}");
                                                        print(
                                                            "Longitude: ${controller.longiTude.value}");

                                                        // Update the marker location
                                                        mapcontroller
                                                                .currentLocationMarker
                                                                .value =
                                                            mapcontroller
                                                                .currentLocationMarker
                                                                .value
                                                                ?.copyWith(
                                                                    positionParam:
                                                                        position);
                                                      } else {
                                                        print(
                                                            "Location not found");
                                                      }

                                                      // Add position to drawnPolygon and create the polygon
                                                      mapcontroller.drawnPolygon
                                                          .add(position);
                                                      if (mapcontroller
                                                              .drawnPolygon
                                                              .length >
                                                          2) {
                                                        mapcontroller.polygons
                                                            .add(
                                                          Polygon(
                                                            polygonId:
                                                                const PolygonId(
                                                                    'boundary_polygon'),
                                                            points: mapcontroller
                                                                .drawnPolygon
                                                                .toList(),
                                                            strokeWidth: 2,
                                                            strokeColor:
                                                                Colors.blue,
                                                            fillColor: Colors
                                                                .blue
                                                                .withOpacity(
                                                                    0.2),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    height: Get.height * 0.068,
                                                    width: Get.width * 0.8,
                                                    child:
                                                        GooglePlaceAutoCompleteTextField(
                                                      boxDecoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                          boxShadow: [
                                                            AppColor.BOX_SHADOW
                                                          ]),
                                                      textEditingController:
                                                          mapcontroller
                                                              .locationController
                                                              .value,
                                                      googleAPIKey:
                                                          StringConstatnt
                                                              .GOOGLE_PLACES_API,
                                                      inputDecoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            "Search your location",
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                      ),
                                                      debounceTime: 400,
                                                      isLatLngRequired: true,
                                                      getPlaceDetailWithLatLng:
                                                          (Prediction
                                                              prediction) {
                                                        print(
                                                            "placeDetails${prediction.lat}");
                                                      },
                                                      focusNode: _focusNode,
                                                      itemClick: (Prediction
                                                          prediction) {
                                                        String location =
                                                            prediction
                                                                    .description ??
                                                                "";
                                                        mapcontroller
                                                            .locationController
                                                            .value
                                                            .text = location;
                                                        mapcontroller
                                                                .locationController
                                                                .value
                                                                .selection =
                                                            TextSelection
                                                                .fromPosition(
                                                          TextPosition(
                                                              offset: location
                                                                  .length),
                                                        );
                                                        if (location
                                                            .isNotEmpty) {
                                                          mapcontroller
                                                              .moveToLocation(
                                                                  location
                                                                      .trim());
                                                          _focusNode.unfocus();
                                                        }
                                                      },
                                                      seperatedBuilder:
                                                          const Divider(),
                                                      containerHorizontalPadding:
                                                          10,
                                                      itemBuilder: (context,
                                                          index,
                                                          Prediction
                                                              prediction) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: AppColor
                                                                    .DARK_GREEN,
                                                              ),
                                                              const SizedBox(
                                                                width: 7,
                                                              ),
                                                              Expanded(
                                                                  child: Text(
                                                                      prediction
                                                                              .description ??
                                                                          ""))
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      isCrossBtnShown: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120),
                                    child: InkWell(
                                      onTap: controller.latiTude.value == ""
                                          ? () {
                                              Get.snackbar(
                                                "Error",
                                                "Please select a location",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                              );
                                            }
                                          : () {
                                              controller.useNeverScrollPhysics
                                                      .value =
                                                  !controller
                                                      .useNeverScrollPhysics
                                                      .value;
                                              mapcontroller.showMap.value =
                                                  false;
                                              controller
                                                      .displayedAddress.value =
                                                  mapcontroller
                                                      .fullAddress.value;
                                              // controller.addAddress();
                                              controller.isAdded.value = true;
                                              // controller
                                              //     .addressLine.value.text = "";
                                              chatgptCropController
                                                  .cropSuggestion(
                                                      controller
                                                          .city.value.text,
                                                      controller
                                                          .state.value.text,
                                                      controller
                                                          .county.value.text);
                                              print(
                                                  "CITY:: ${controller.city.value.text}");
                                              print(
                                                  "STATE:: ${controller.state.value.text}");
                                              print(
                                                  "Country:: ${controller.county.value.text}");
                                            },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: AppColor.DARK_GREEN,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Add Location',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              mapcontroller.showMap.value = true;
                              controller.useNeverScrollPhysics.value =
                                  !controller.useNeverScrollPhysics.value;
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Location pinned',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF919191),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Added',
                                          style: GoogleFonts.poppins(
                                            color: AppColor.LIGHT_GREEN,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.task_alt_rounded,
                                        color: AppColor.LIGHT_GREEN,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.isAdded.value
                        ? controller.isaddressAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isaddressAdded.value = false;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Full Address',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.5,
                                            child: Text(
                                              controller.displayedAddress.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isaddressAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFF7),
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    AppColor.BOX_SHADOW,
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Full Address',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF272727),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: TextFormField(
                                            controller:
                                                controller.addressLine.value,
                                            decoration: InputDecoration(
                                                hintText: "Address Line",
                                                hintStyle: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0x994F4F4F),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0.10,
                                                ),
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the address';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Get.width * 0.35,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.GREY_BORDER),
                                                boxShadow: [
                                                  AppColor.BOX_SHADOW
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    controller.city.value,
                                                decoration: InputDecoration(
                                                    hintText: "City",
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                      color: const Color(
                                                          0x994F4F4F),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.10,
                                                    ),
                                                    border: InputBorder.none),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter the city';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.35,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.GREY_BORDER),
                                                boxShadow: [
                                                  AppColor.BOX_SHADOW
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    controller.state.value,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter the state';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    hintText: "State",
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                      color: const Color(
                                                          0x994F4F4F),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.10,
                                                    ),
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: TextFormField(
                                            controller: controller.county.value,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the country';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Country",
                                                hintStyle: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0x994F4F4F),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0.10,
                                                ),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 120),
                                          child: InkWell(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                controller.addAddress();
                                                chatgptCropController
                                                    .cropSuggestion(
                                                        controller
                                                            .city.value.text,
                                                        controller
                                                            .state.value.text,
                                                        controller
                                                            .county.value.text);
                                              }
                                              {
                                                controller.addresstostMsg();
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              decoration: ShapeDecoration(
                                                color: AppColor.DARK_GREEN,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Add Address',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                        : InkWell(
                            onTap: () {
                              controller.add;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Full Address",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF919191),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.add,
                                    child: Text(
                                      'Add Address',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.ARROW,
                        width: 20,
                      ),
                      Text(
                        '    Land information',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF483C32),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0.17,
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return controller.landtitleValue.value
                        ? controller.isTitleAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isTitleAdded.value = false;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Land Nickname',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.5,
                                            child: Text(
                                              controller.landTitle.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isTitleAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Land Nickname',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Form(
                                            key: _landTitle,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              width: Get.width * 0.75,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: controller
                                                    .landTitleController.value,
                                                decoration: InputDecoration(
                                                  hintText: 'Land Nickname',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color:
                                                        const Color(0x994F4F4F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.10,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter nickname';
                                                  }
                                                  {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          if (_landTitle.currentState!
                                              .validate()) {
                                            controller.addTitle();
                                          }
                                          {
                                            return;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  if (_landTitle.currentState!
                                                      .validate()) {
                                                    controller.addTitle();
                                                  }
                                                  {
                                                    return;
                                                  }
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.landTitleValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Land Nickname',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.landTitleValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.landSizeValue.value
                        ? controller.isLandAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isLandAdded.value = false;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Land Size(Area)',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.5,
                                            child: Text(
                                              controller.landArea.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isLandAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Land Size(Area)',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Form(
                                            key: _landSize,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              width: Get.width * 0.33,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    controller.landSize.value,
                                                decoration: InputDecoration(
                                                  hintText: 'Land Size',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color:
                                                        const Color(0x994F4F4F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.10,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter land size';
                                                  }
                                                  {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Obx(
                                              () => DropdownButton(
                                                underline: Container(),
                                                value: controller
                                                        .selectedUnit.value ??
                                                    "Square Meters",
                                                items: controller.units
                                                    .map((unit) {
                                                  return DropdownMenuItem(
                                                    value: unit,
                                                    child: Text(
                                                      unit,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF4F4F4F),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.10,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (selectedUnit) {
                                                  controller.updateSelectedUnit(
                                                      selectedUnit.toString());
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          if (_landSize.currentState!
                                              .validate()) {
                                            controller.addLand();
                                          }
                                          {
                                            return;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  if (_landSize.currentState!
                                                      .validate()) {
                                                    controller.addLand();
                                                  }
                                                  {
                                                    return;
                                                  }
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.landValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Land Size (Area)',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.landValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.addPurpose.value
                        ? controller.isPurposeAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isPurposeAdded.value = false;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Purpose',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              controller
                                                  .selectedPurposeName.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isPurposeAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Purpose',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      if (controller.rxPurposeRequestStatus ==
                                          Status.LOADING) {
                                        return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColor.DARK_GREEN,
                                              ),
                                            ));
                                      } else if (controller
                                              .rxPurposeRequestStatus ==
                                          Status.SUCCESS) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Wrap(
                                            spacing: 10,
                                            children: List.generate(
                                                controller.purposeData.value
                                                    .result!.length,
                                                (index) => InkWell(
                                                      onTap: () {
                                                        controller.current
                                                            .value = index;
                                                        controller
                                                                .selectedPurposeid
                                                                .value =
                                                            controller
                                                                .purposeData
                                                                .value
                                                                .result![index]
                                                                .id
                                                                .toString();
                                                        controller
                                                                .selectedPurposeName
                                                                .value =
                                                            controller
                                                                .purposeData
                                                                .value
                                                                .result![index]
                                                                .name
                                                                .toString();
                                                      },
                                                      child: AnimatedContainer(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            border: controller
                                                                        .current ==
                                                                    index
                                                                ? Border.all(
                                                                    color: AppColor
                                                                        .DARK_GREEN)
                                                                : Border.all(
                                                                    color: AppColor
                                                                        .GREY_BORDER),
                                                            gradient: controller
                                                                        .current ==
                                                                    index
                                                                ? AppColor
                                                                    .PRIMARY_GRADIENT
                                                                : AppColor
                                                                    .WHITE_GRADIENT),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    10),
                                                        child: Text(controller
                                                            .purposeData
                                                            .value
                                                            .result![index]
                                                            .name
                                                            .toString()),
                                                      ),
                                                    )),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          controller.purposeAdded();
                                          print(
                                              "============================================================${controller.selectedPurposeName.value}");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  controller.purposeAdded();
                                                  print(
                                                      "============================================================${controller.selectedPurposeName.value}");
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.addPurposeValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Purpose',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.addPurposeValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  controller.selectedPurposeName.value ==
                              "Give on lease for farming" ||
                          controller.selectedPurposeName.value ==
                              "Profit sharing lease"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return controller.landleaseValue.value
                                  ? controller.isLandleaseAdded.value
                                      ? InkWell(
                                          onTap: () {
                                            controller.isLandleaseAdded.value =
                                                false;
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10, top: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER),
                                              boxShadow: [AppColor.BOX_SHADOW],
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Lease duration',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
                                                                    0xFF919191),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text: '*',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFEB5757),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.5,
                                                      child: Text(
                                                        controller.leaseDUration
                                                            .value,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF272727),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        controller
                                                            .isLandleaseAdded
                                                            .value = false;
                                                      },
                                                      child: Text(
                                                        'Added',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .LIGHT_GREEN,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.task_alt_rounded,
                                                      color:
                                                          AppColor.LIGHT_GREEN,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Lease duration',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF272727),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '*',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFEB5757),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.075,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          AppColor.GREY_BORDER),
                                                  boxShadow: [
                                                    AppColor.BOX_SHADOW
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Form(
                                                      key: _landlease,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        width: Get.width * 0.33,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: controller
                                                              .landlease.value,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'duration',
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .poppins(
                                                              color: const Color(
                                                                  0x994F4F4F),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.10,
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'enter the duration';
                                                            }
                                                            {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: Obx(
                                                        () => DropdownButton(
                                                          underline:
                                                              Container(),
                                                          value: controller
                                                                  .selectedleaseUinit
                                                                  .value ??
                                                              "Months",
                                                          items: controller
                                                              .leaseunits
                                                              .map((unit) {
                                                            return DropdownMenuItem(
                                                              value: unit,
                                                              child: Text(
                                                                unit,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xFF4F4F4F),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0.10,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (selectedUnit) {
                                                            controller
                                                                .updateSelectedleaseUnit(
                                                                    selectedUnit
                                                                        .toString());
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 120),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (_landlease.currentState!
                                                        .validate()) {
                                                      controller.addLease();
                                                    }
                                                    {
                                                      return;
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 3,
                                                    ),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    decoration: ShapeDecoration(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            if (_landlease
                                                                .currentState!
                                                                .validate()) {
                                                              controller
                                                                  .addLease();
                                                            }
                                                            {
                                                              return;
                                                            }
                                                          },
                                                          child: Text(
                                                            'Add ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                  : InkWell(
                                      onTap: controller.leaseValue,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER),
                                          boxShadow: [AppColor.BOX_SHADOW],
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Lease duration',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: controller.landValue,
                                              child: Text(
                                                'Add',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF272727),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                            Obx(() {
                              return controller.landleaseAmountvalue.value
                                  ? controller.islandleaseAmountvalue.value
                                      ? InkWell(
                                          onTap: () {
                                            controller.islandleaseAmountvalue
                                                .value = false;
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER),
                                              boxShadow: [AppColor.BOX_SHADOW],
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Leasing type',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
                                                                    0xFF919191),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text: '*',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFEB5757),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.5,
                                                      child: Text(
                                                        controller
                                                            .lease_type.value,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF272727),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        controller
                                                            .islandleaseAmountvalue
                                                            .value = false;
                                                      },
                                                      child: Text(
                                                        'Added',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .LIGHT_GREEN,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.task_alt_rounded,
                                                      color:
                                                          AppColor.LIGHT_GREEN,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Lease type',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF272727),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '*',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFEB5757),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(() {
                                                return Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Obx(
                                                              () =>
                                                                  RadioListTile<
                                                                      bool>(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                activeColor:
                                                                    AppColor
                                                                        .DARK_GREEN,
                                                                title: Text(
                                                                  'Rent/${controller.selectedleaseUinit.value == 'Years' ? 'Year' : 'Month'}',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xFF333333),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                value: true,
                                                                groupValue:
                                                                    controller
                                                                        .isleaseAvailable
                                                                        .value,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .isleaseAvailable
                                                                      .value = value!;
                                                                  controller
                                                                      .lease_type
                                                                      .value = "Rent";
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Obx(
                                                              () =>
                                                                  RadioListTile<
                                                                      bool>(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                title: Text(
                                                                  'Share profit',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xFF333333),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                value: false,
                                                                activeColor:
                                                                    AppColor
                                                                        .DARK_GREEN,
                                                                groupValue:
                                                                    controller
                                                                        .isleaseAvailable
                                                                        .value,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .isleaseAvailable
                                                                      .value = value!;
                                                                  controller
                                                                          .lease_type
                                                                          .value =
                                                                      "Share Profit";
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: controller
                                                            .isleaseAvailable
                                                            .value,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 15),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.075,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .GREY_BORDER),
                                                            boxShadow: [
                                                              AppColor
                                                                  .BOX_SHADOW
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child: Obx(
                                                                  () =>
                                                                      DropdownButton(
                                                                    icon: null,
                                                                    underline:
                                                                        Container(),
                                                                    value: controller
                                                                            .amount
                                                                            .value ??
                                                                        "Months",
                                                                    items: controller
                                                                        .amountType
                                                                        .map(
                                                                            (unit) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            unit,
                                                                        child:
                                                                            Text(
                                                                          unit,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                const Color(0xFF4F4F4F),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                0.10,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (selectedUnit) {
                                                                      controller
                                                                          .updateSelectedamount(
                                                                              selectedUnit.toString());
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                width:
                                                                    Get.width *
                                                                        0.33,
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      controller
                                                                          .isleaseAmount
                                                                          .value,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'amount',
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .poppins(
                                                                      color: const Color(
                                                                          0x994F4F4F),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      height:
                                                                          0.10,
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'enter the amount';
                                                                    }
                                                                    {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 120),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(
                                                        "LEASE TYPE1:::${controller.lease_type.value}");
                                                    controller.addAmount();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 3,
                                                    ),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    decoration: ShapeDecoration(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            controller
                                                                    .lease_type
                                                                    .value
                                                                    .isEmpty
                                                                ? controller
                                                                        .lease_type
                                                                        .value =
                                                                    'Rent'
                                                                : controller
                                                                    .lease_type
                                                                    .value;
                                                            print(
                                                                "LEASE TYPE2:::${controller.lease_type.value}");
                                                            controller
                                                                .addAmount();
                                                          },
                                                          child: Text(
                                                            'Add ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                  : InkWell(
                                      onTap: controller.leaseAmountValue,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER),
                                          boxShadow: [AppColor.BOX_SHADOW],
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Lease type',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: controller.landValue,
                                              child: Text(
                                                'Add',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF272727),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                          ],
                        )
                      : Container(),
                  Obx(() {
                    return controller.iscropAdded.value
                        ? controller.isCropValue.value
                            ? InkWell(
                                onTap: () {
                                  controller.isCropValue.value = false;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Crops',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.53,
                                            child: Wrap(
                                              children: List.generate(
                                                controller
                                                        .cropAddedName.length +
                                                    controller
                                                        .otherCropAddedName
                                                        .length,
                                                (index) {
                                                  final isCropAddedName =
                                                      index <
                                                          controller
                                                              .cropAddedName
                                                              .length;
                                                  final cropName = isCropAddedName
                                                      ? controller
                                                          .cropAddedName[index]
                                                      : controller
                                                              .otherCropAddedName[
                                                          index -
                                                              controller
                                                                  .cropAddedName
                                                                  .length];

                                                  // Check if it's the last item
                                                  final isLast = index ==
                                                      (controller.cropAddedName
                                                              .length +
                                                          controller
                                                              .otherCropAddedName
                                                              .length -
                                                          1);

                                                  return Container(
                                                    child: Text(
                                                      isLast
                                                          ? "$cropName"
                                                          : "$cropName, ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF272727),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isCropValue.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: controller.selectedPurposeName
                                                        .value ==
                                                    "Give on lease for farming"
                                                ? 'What crop can be grown?'
                                                : 'What kind of crop do you want to grow?',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        'You can select multiple options',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF757575),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          height: 0.16,
                                        ),
                                      ),
                                    ),
                                    Obx(() {
                                      if (chatgptCropController
                                              .rxRequestStatus ==
                                          Status.LOADING) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColor.DARK_GREEN,
                                            ),
                                          ),
                                        );
                                      } else if (chatgptCropController
                                              .rxRequestStatus ==
                                          Status.SUCCESS) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Wrap(
                                            spacing: 10,
                                            children: List.generate(
                                                chatgptCropController.cropData
                                                        .value.result!.length +
                                                    1, (index) {
                                              if (index ==
                                                  chatgptCropController.cropData
                                                      .value.result!.length) {
                                                bool isSelected = controller
                                                    .cropAdded
                                                    .contains(-1);
                                                return InkWell(
                                                  onTap: () {
                                                    otherCropController
                                                        .listOtherCrop("");
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.white,
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.7,
                                                          color: Colors.white,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColor.GREY_BORDER),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.72,
                                                                    child:
                                                                        TextFormField(
                                                                      controller: otherCropController
                                                                          .cropController
                                                                          .value,
                                                                      onChanged:
                                                                          (value) {
                                                                        otherCropController
                                                                            .listOtherCrop(value); // Call API on every change
                                                                      },
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        hintText:
                                                                            "Enter Crop",
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(horizontal: 15),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child: Obx(() {
                                                                  if (otherCropController
                                                                          .rxRequestStatus ==
                                                                      Status
                                                                          .LOADING) {
                                                                    return const Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                      ),
                                                                    );
                                                                  } else if (otherCropController
                                                                          .rxRequestStatus ==
                                                                      Status
                                                                          .SUCCESS) {
                                                                    return SingleChildScrollView(
                                                                      child:
                                                                          Wrap(
                                                                        spacing:
                                                                            10,
                                                                        children:
                                                                            List.generate(
                                                                          otherCropController
                                                                              .cropData
                                                                              .value
                                                                              .result!
                                                                              .length,
                                                                          (index) {
                                                                            final cropId =
                                                                                otherCropController.cropData.value.result![index].id;
                                                                            final cropName =
                                                                                otherCropController.cropData.value.result![index].name.toString();
                                                                            bool
                                                                                isSelected =
                                                                                cropId != null && controller.otherCropAdded.contains(cropId.toInt());
                                                                            bool
                                                                                isSelectedName =
                                                                                controller.otherCropAddedName.contains(cropName.toString());

                                                                            return InkWell(
                                                                              onTap: () {
                                                                                if (cropId != null) {
                                                                                  if (isSelected) {
                                                                                    controller.otherCropAdded.remove(cropId);
                                                                                  } else {
                                                                                    controller.otherCropAdded.add(cropId);
                                                                                  }
                                                                                }
                                                                                if (isSelectedName) {
                                                                                  controller.otherCropAddedName.remove(cropName);
                                                                                } else {
                                                                                  controller.otherCropAddedName.add(cropName);
                                                                                }
                                                                              },
                                                                              child: AnimatedContainer(
                                                                                margin: const EdgeInsets.symmetric(vertical: 5),
                                                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                  border: isSelected ? Border.all(color: AppColor.DARK_GREEN) : Border.all(color: AppColor.GREY_BORDER),
                                                                                  gradient: isSelected ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT,
                                                                                ),
                                                                                duration: const Duration(milliseconds: 200),
                                                                                child: Text(cropName),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Container();
                                                                  }
                                                                }),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .addselectCrop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical: 3,
                                                                  ),
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: TextButton(
                                                                        onPressed: controller.addselectCrop,
                                                                        child: Text(
                                                                          'Add ',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );

//                                                     if (isSelected) {
//                                                       controller.cropAdded
//                                                           .remove(-1);
// //controller.cropAddedName.remove("Others");
//                                                     } else {
//                                                       controller.cropAdded
//                                                           .add(-1);
//                                                       //  controller.cropAddedName.add("Others");
//                                                     }
                                                  },
                                                  child: AnimatedContainer(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: isSelected
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .DARK_GREEN)
                                                          : Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                      gradient: isSelected
                                                          ? AppColor
                                                              .PRIMARY_GRADIENT
                                                          : AppColor
                                                              .WHITE_GRADIENT,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: const Text("Others"),
                                                  ),
                                                );
                                              } else {
                                                final cropId =
                                                    chatgptCropController
                                                        .cropData
                                                        .value
                                                        .result![index]
                                                        .id;
                                                final cropName =
                                                    chatgptCropController
                                                        .cropData
                                                        .value
                                                        .result![index]
                                                        .name
                                                        .toString();
                                                bool isSelected =
                                                    cropId != null &&
                                                        controller.cropAdded
                                                            .contains(
                                                                cropId.toInt());
                                                bool isSelectedName = controller
                                                    .cropAddedName
                                                    .contains(
                                                        cropName.toString());

                                                return InkWell(
                                                  onTap: () {
                                                    if (cropId != null) {
                                                      if (isSelected) {
                                                        controller.cropAdded
                                                            .remove(cropId);
                                                      } else {
                                                        controller.cropAdded
                                                            .add(cropId);
                                                      }
                                                    }
                                                    if (isSelectedName) {
                                                      controller.cropAddedName
                                                          .remove(cropName);
                                                    } else {
                                                      controller.cropAddedName
                                                          .add(cropName);
                                                    }
                                                  },
                                                  child: AnimatedContainer(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: isSelected
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .DARK_GREEN)
                                                          : Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                      gradient: isSelected
                                                          ? AppColor
                                                              .PRIMARY_GRADIENT
                                                          : AppColor
                                                              .WHITE_GRADIENT,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: Text(cropName),
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: controller
                                            .addselectCropfromContainer,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: controller
                                                    .addselectCropfromContainer,
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.cropAdd,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    if (controller.lease_type.value == "") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'What kind of crop do you want to grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (controller.lease_type.value ==
                                        "Share Profit") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'What kind of crop do you want to grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (controller.lease_type.value ==
                                        "Rent") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Types of crop you can grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  TextButton(
                                    onPressed: controller.cropAdd,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                ],
              ),
            );
          }),
        ),
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: Get.height * 0.08,
            child: Obx(() {
              return controller.addLandLoading.value &&
                      controller.areFieldsValid.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.DARK_GREEN)),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: AppColor.DARK_GREEN,
                      )),
                    )
                  : GestureDetector(
                      onTap: controller.areFieldsValid.value == false
                          ? () {}
                          : () {
                              controller.addLandData();
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: ShapeDecoration(
                          color: controller.areFieldsValid.value
                              ? AppColor.DARK_GREEN
                              : AppColor.DARK_GREEN.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: TextButton(
                              onPressed:
                                  controller.areFieldsValid.value == false
                                      ? () {}
                                      : () {
                                          controller.addLandData();
                                        },
                              child: Text(
                                'Proceed ',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              )),
                        ),
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
