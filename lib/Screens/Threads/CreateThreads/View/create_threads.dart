import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/create_thread_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/list_tags_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/thread_image_controller.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreateThreads extends StatefulWidget {
  const CreateThreads({super.key});

  @override
  State<CreateThreads> createState() => _CreateThreadsState();
}

class _CreateThreadsState extends State<CreateThreads> {
  final controller = Get.put(CreateThreadController());
  final tagsController = Get.put(ListTagsController());
  final imageController = Get.put(ThreadsImageController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.width * 0.16),
          child: CommonAppBar(
            title: 'New Post',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Ask Question',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColor.BROWN_TEXT,
                          fontSize: 12),
                    ),
                    Text(
                      " *",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: Get.height * 0.065,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.GREY_BORDER),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: controller.titleController.value,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF757575),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: Get.height * 0.17,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.GREY_BORDER),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.length > 200) {
                        controller.descriptionController.value.text =
                            value.substring(0, 200);
                        controller.descriptionController.value.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: controller
                                  .descriptionController.value.text.length),
                        );
                      }
                      controller.wordCount.value =
                          controller.descriptionController.value.text.length;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .unfocus(); // Dismiss the keyboard when "Done" is pressed
                    },
                    controller: controller.descriptionController.value,
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: InputBorder.none,
                      hintText: "Description..",
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF757575),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "   ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: AppColor.BROWN_TEXT,
                            fontSize: 14),
                      ),
                      Obx(() {
                        return Text(
                          "${controller.wordCount.value}/200",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: AppColor.BROWN_TEXT,
                              fontSize: 14),
                        );
                      })
                    ],
                  ),
                ),
                Obx(() {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: imageController.photos.length < 3
                        ? imageController.photos.length + 1
                        : 3,
                    itemBuilder: (context, index) {
                      if (index < imageController.photos.length) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                      File(imageController.photos[index])),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  imageController.deleteImage(index);
                                  imageController.deleteImagelocal(index);
                                },
                                child: Container(
                                  height: 28,
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 244, 67, 54),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (index == imageController.photos.length &&
                          index < 3) {
                        return Visibility(
                          visible: imageController.photos.length < 3,
                          child: InkWell(
                            onTap: () {
                              imageController.getImage(ImageSource.gallery);
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColor.DARK_GREEN,
                              dashPattern: [9, 4],
                              radius: Radius.circular(12),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  color: Color(0x1E044D3A),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 25, bottom: 15),
                                          child: SvgPicture.asset(
                                            'assets/logos/gallary.svg',
                                            height: 24,
                                          ),
                                        ),
                                        Text(
                                          "Add",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.DARK_GREEN,
                                          ),
                                        ),
                                        Text(
                                          "Photos",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF73817B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Select Tags',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        " *",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (tagsController.rxRequestStatus == Status.LOADING) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.DARK_GREEN,
                          ),
                        ));
                  } else if (tagsController.rxRequestStatus == Status.SUCCESS) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Wrap(
                        spacing: 10,
                        children: List.generate(
                            tagsController.tagsData.value.result!.length,
                            (index) {
                          final tagsId =
                              tagsController.tagsData.value.result![index].id;
                          bool isSelected = tagsId != null &&
                              tagsController.tags.contains(tagsId.toInt());
                          return InkWell(
                            onTap: () {
                              if (tagsId != null) {
                                if (isSelected) {
                                  tagsController.tags.remove(tagsId);
                                } else {
                                  tagsController.tags.add(tagsId);
                                }
                              }
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: isSelected
                                    ? Border.all(color: AppColor.DARK_GREEN)
                                    : Border.all(color: AppColor.GREY_BORDER),
                                color: isSelected
                                    ? Color(0xFFECF5DE)
                                    : Color(0x19828282),
                              ),
                              duration: Duration(milliseconds: 10),
                              child: Text(
                                "${tagsController.tagsData.value.result![index].name.toString()}",
                                style: GoogleFonts.poppins(
                                  color: isSelected
                                      ? AppColor.DARK_GREEN
                                      : Color(0xFF4F4F4F),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Obx(() {
            return InkWell(
              onTap: () {
                controller.threadDataUpload();
              },
              child: controller.loading.value
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.DARK_GREEN),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.DARK_GREEN),
                      child: Center(
                        child: Text(
                          'Post',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }
}
