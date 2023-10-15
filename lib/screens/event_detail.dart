import 'package:flutter/material.dart';
import 'package:itf_assignment/utils/colors.dart';
import 'package:itf_assignment/utils/textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetail extends StatelessWidget {
  final String title;
  final String bannerImage;
  final String organiserName;
  final String organisericon;
  final String date;
  final String time;
  final String venueName;
  final String venueCity;
  final String venueCountry;
  final String description;

  const EventDetail({
    super.key,
    required this.bannerImage,
    required this.title,
    required this.organiserName,
    required this.organisericon,
    required this.date,
    required this.time,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Positioned(
        left: 0,
        right: 3.w,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 7.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.primaryBlue,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Book Now",
                  style: MyTextStyle.heading2,
                ),
                SvgPicture.asset("assets/icon/arrow.svg")
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0, 
            floating: true,
            pinned: true,
            title: Text(
              "Event Detail",
              style: MyTextStyle.heading1,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                ),
              )
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                bannerImage, 
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 2.h, left: 4.w, right: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 2.h),
                    child: Text(
                      title,
                      style: MyTextStyle.heading3,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        ImageWidget(organisericon: organisericon),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                organiserName,
                                style: MyTextStyle.headingWithBlack,
                              ),
                              const Text("Organiser"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SvgIcon(svg: "calender"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              date,
                              style: MyTextStyle.headingWithBlack,
                            ),
                          ),
                          Container(
                            child: Text(
                              time,
                              style: MyTextStyle.headingWithGrey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SvgIcon(svg: "location"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              venueName,
                              style: MyTextStyle.headingWithBlack,
                            ),
                          ),
                          Container(
                            child: Text(
                              "$venueCity, $venueCountry",
                              style: MyTextStyle.headingWithGrey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    child: Text(
                      "About Event",
                      style: MyTextStyle.heading1,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      description,
                      style: MyTextStyle.heading4,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  String svg;
  SvgIcon({super.key, required this.svg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColor.primaryBlue.withOpacity(0.1)),
      height: 8.h,
      width: 15.w,
      child: SvgPicture.asset(
        "assets/icon/$svg.svg",
        fit: BoxFit.contain,
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.organisericon,
  }) : super(key: key);

  final String organisericon;

  @override
  Widget build(BuildContext context) {
    if (organisericon.toLowerCase().endsWith('.svg')) {
      return Container(
        margin: EdgeInsets.only(right: 5.w),
        width: 15.w,
        height: 8.h,
        child: SvgPicture.network(
          organisericon,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 5.w),
        width: 15.w,
        height: 8.h,
        child: Image.network(
          organisericon,
          fit: BoxFit.contain,
        ),
      );
    }
  }
}
