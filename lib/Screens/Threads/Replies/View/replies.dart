import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Threads/Controller/reply_controller.dart';
import 'package:farm_easy/Screens/Threads/ParticularThread/Controller/particular_thread_controller.dart';
import 'package:farm_easy/Screens/Threads/Replies/Controller/controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Replies extends StatefulWidget {
  Replies({
    Key? key,
    required this.threadId,
  }) : super(key: key);
  int threadId;

  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  final controller = Get.put(RespliesController());
  final replyController = Get.put(ReplyController());
  final getThreadData = Get.put(ParticularThreadController());
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThreadData.threads(widget.threadId);
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    controller.threadId.value = widget.threadId;
    replyController.threadId.value = widget.threadId;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          controller.opacity.value;
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:
            AppColor.BACKGROUND.withOpacity(controller.opacity.value),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.width * 0.16),
          child: CommonAppBar(
            title: 'Replies',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                child: Text(
                                  getThreadData
                                          .threadData.value.result?.title ??
                                      "",
                                  style: TextStyle(
                                    color: AppColor.BROWN_TEXT,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              getThreadData.threadData.value.result?.images
                                          ?.length !=
                                      0
                                  ? Container(
                                      height: Get.height * 0.14,
                                      child: ListView.builder(
                                          itemCount: getThreadData
                                                  .threadData
                                                  .value
                                                  .result
                                                  ?.images
                                                  ?.length ??
                                              0,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, img) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10, right: 8),
                                              height: Get.height * 0.14,
                                              width: Get.width * 0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          getThreadData
                                                                  .threadData
                                                                  .value
                                                                  .result
                                                                  ?.images?[img]
                                                                  .image ??
                                                              ""),
                                                      fit: BoxFit.cover)),
                                            );
                                          }),
                                    )
                                  : Container(),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 15, left: 10, right: 10),
                                child: Text(
                                  getThreadData.threadData.value.result
                                          ?.description ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF61646B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 5,
                                children: List.generate(
                                    getThreadData.threadData.value.result?.tags
                                            ?.length ??
                                        0, (tags) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0x14167C0C),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "${getThreadData.threadData.value.result?.tags?[tags].name}",
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF044D3A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColor.GREY_BORDER,
                        )
                      ],
                    ),
                  );
                }),
                Obx(() {
                  return Text(
                    "    ${controller.repliesData.value.result?.pageInfo?.totalObject ?? 0} Replies",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9A9A9A)),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: Get.height * 0.52,
                  child: Obx(() {
                    final replyCount =
                        controller.repliesData.value.result?.data?.length ?? 0;
                    if (replyCount == 0) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/img/replyempty.svg"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Currently there are no replies  ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColor.BROWN_TEXT),
                            ),
                            Text(
                              "to show",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColor.BROWN_TEXT),
                            ),
                          ],
                        ),
                      ));
                    }
                    return ListView.builder(
                      itemCount: replyCount,
                      controller: controller.scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final displayIndex = replyCount - index - 1;
                        final replies = controller
                            .repliesData.value.result!.data![displayIndex];

                        return ListTile(
                          leading: InkWell(
                            onTap: () {
                              Get.to(() => UserProfileScreen(
                                  id: replies.userId!.toInt(),
                                  userType: replies.userType ?? ""));
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.DARK_GREEN.withOpacity(0.2),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(replies.userImage ?? ""),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: replies.userImage == ""
                                    ? Center(
                                        child: Text(
                                          replies.userName![0].toUpperCase(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: AppColor
                                                .DARK_GREEN, // Text color contrasting the background
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container()),
                          ),
                          title: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${replies.userName ?? ""} ',
                                  style: TextStyle(
                                    color: Color(0xFF484848),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '${replies.reply ?? ""}',
                                  style: TextStyle(
                                    color: Color(0xFF484848),
                                    fontSize: 11,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            "${replies.createdOn ?? ""}",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xBC484848),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColor.BACKGROUND,
                    border: Border(
                      top: BorderSide(width: 1, color: Color(0xFFE3E3E3)),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          String? imageUrl = controller.getProfileController
                              .getProfileData.value.result?.image;

                          return (imageUrl == null || imageUrl == "")
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.DARK_GREEN.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller
                                              .getProfileController
                                              .getProfileData
                                              .value
                                              .result
                                              ?.fullName![0]
                                              .toUpperCase() ??
                                          "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: AppColor.DARK_GREEN,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(imageUrl),
                                );
                        }),
                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              color: AppColor.BACKGROUND,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x66044D3A)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 8,
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                controller:
                                    replyController.replyController.value,
                                autocorrect: true,
                                cursorColor: Colors.grey,
                                minLines: 1,
                                maxLines: 8,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      replyController.replyThread();
                                      controller.isScrollable.value = true;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF044D3A),
                                        shape: CircleBorder(),
                                      ),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Reply...",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.42),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
