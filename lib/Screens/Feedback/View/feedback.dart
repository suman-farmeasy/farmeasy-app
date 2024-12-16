import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Feedback/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  int _selectedIndex = 5;
  final controller = Get.put(FeedbackController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: 'Feedback',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Center(
              child: Text(
                "How are you feeling?",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.BROWN_TEXT),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Your input is valuable in helping us better understand your \nneeds and tailor our service accordingly",
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF61646B)),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // Space on the sides of the list

                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectedFeedback.length,
                    itemBuilder: (context, index) {
                      int adjustedIndex = index + 1;

                      bool isSelected = _selectedIndex == adjustedIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = isSelected ? 5 : adjustedIndex;
                          });
                          print(_selectedIndex);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Make the container circular
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                4.0), // Optional padding around the image
                            child: ClipOval(
                              child: ColorFiltered(
                                colorFilter: isSelected
                                    ? ColorFilter.mode(
                                        Colors
                                            .transparent, // Show original color on tap
                                        BlendMode.dst,
                                      )
                                    : ColorFilter.mode(
                                        Colors.grey, // Black-and-white effect
                                        BlendMode.saturation,
                                      ),
                                child: Image.asset(
                                  controller.selectedFeedback[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                color: AppColor.BACKGROUND,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x66044D3A)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 8,
                ),
                child: TextFormField(
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  controller: controller.description.value,
                  autocorrect: true,
                  cursorColor: Colors.grey,
                  minLines: 4,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add a Comment...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.42),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print(_selectedIndex);
                controller.addFeedback(
                    _selectedIndex, controller.description.value.text);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.06,
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.DARK_GREEN),
                child: Center(
                  child: Text(
                    'Submit Now',
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
          ],
        ),
      ),
    );
  }
}
