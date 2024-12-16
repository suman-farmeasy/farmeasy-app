import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/View/add_product.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final controller = Get.put(ProductViewController());
  final getProfileDetails = Get.find<GetProfileController>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.productList(
        userId: getProfileDetails.getProfileData.value.result?.userId ?? 0,
      );
    });

    _productScroller.addListener(() {
      if (_productScroller.position.pixels ==
          _productScroller.position.maxScrollExtent) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.loadMoreData(
            getProfileDetails.getProfileData.value.result?.userId ?? 0,
          );
        });
      }
    });
  }

  final ScrollController _productScroller = ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    _productScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.productDataList.clear();
        controller.productList(
            userId: getProfileDetails.getProfileData.value.result?.userId ?? 0);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.width * 0.16),
          child: CommonAppBar(
            title: 'Add Products/Services',
            onBackPressed: () {
              controller.productDataList.clear();
              controller.productList(
                  userId:
                      getProfileDetails.getProfileData.value.result?.userId ??
                          0);

              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.loading.value &&
                    controller.productDataList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.rxRequestStatus.value == Status.ERROR) {
                  return Text('Error fetching data');
                } else if (controller.productDataList.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshAllproduct(getProfileDetails
                              .getProfileData.value.result?.userId ??
                          0);
                    },
                    child: Container(
                      height: Get.height * 0.72,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _productScroller,
                          shrinkWrap: true,
                          itemCount: controller.productDataList.length,
                          itemBuilder: (context, products) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFFFFFF7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 24,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller.productDataList[products]
                                                    .image?.length !=
                                                0
                                            ? Container(
                                                height: Get.height * 0.14,
                                                child: ListView.builder(
                                                    itemCount: controller
                                                            .productDataList[
                                                                products]
                                                            .image
                                                            ?.length ??
                                                        0,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, img) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 8),
                                                        height:
                                                            Get.height * 0.14,
                                                        width: Get.width * 0.3,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image: NetworkImage(controller
                                                                        .productDataList[
                                                                            products]
                                                                        .image?[
                                                                            img]
                                                                        .image ??
                                                                    ""),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      );
                                                    }),
                                              )
                                            : Container(),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${controller.productDataList[products].name ?? ""}',
                                                style: TextStyle(
                                                  color: AppColor.BROWN_TEXT,
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTapDown: (details) {
                                                  final images = controller
                                                          .productDataList[
                                                              products]
                                                          .image
                                                          ?.map((img) =>
                                                              img.image ?? "")
                                                          .toList() ??
                                                      [];
                                                  final imagesId = controller
                                                          .productDataList[
                                                              products]
                                                          .image
                                                          ?.map((img) =>
                                                              img.id ?? 0)
                                                          .toList() ??
                                                      [];
                                                  controller.showPopupMenu(
                                                    context,
                                                    products,
                                                    details,
                                                    controller
                                                            .productDataList[
                                                                products]
                                                            .name ??
                                                        "",
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .id!,
                                                    images,
                                                    imagesId,
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .description!,
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .currency!,
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .unitPrice!,
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .unit!,
                                                    controller
                                                        .productDataList[
                                                            products]
                                                        .unitValue!,
                                                  );
                                                },
                                                child: Icon(Icons.more_vert),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 5,
                                              left: 0,
                                              right: 10,
                                              top: 5),
                                          child: Text(
                                            '${controller.productDataList[products].description ?? ""}',
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF61646B),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${controller.productDataList[products].currency ?? ""} ${controller.productDataList[products].unitPrice}/${controller.productDataList[products].unitValue} ${controller.productDataList[products].unit}',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.DARK_GREEN,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            Get.to(() => AddProduct());
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            height: Get.height * 0.06,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.DARK_GREEN),
            child: Center(
              child: Text(
                'Add Product/Service',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
