import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itf_assignment/utils/textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;

class EventTile extends StatelessWidget {
  String title;
  String dateTime;
  String venuename;
  String venuecity;
  String venuecountry;
  String organizerIcon;

  EventTile({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.venuename,
    required this.venuecity,
    required this.venuecountry,
    required this.organizerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (path.extension(organizerIcon).toLowerCase() == ".svg") {
      imageWidget = SvgPicture.network(
        organizerIcon,
        fit: BoxFit.contain,
      );
    } else {
      imageWidget = Image.network(
        organizerIcon,
        fit: BoxFit.contain,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        bottom: 2.h,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 13.h,
            width: 25.w,
            child: imageWidget,
          ),
          Container(
            margin: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateTimeWidget(),
                TitleWidget(),
                LocationWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container LocationWidget() {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.grey,
          ),
          SizedBox(
            width: 60.w,
            child: Text(
              "$venuename · $venuecity · $venuecountry",
              maxLines: 1,
              style: MyTextStyle.headingWithGrey,
            ),
          )
        ],
      ),
    );
  }

  SizedBox TitleWidget() {
    return SizedBox(
      width: 60.w,
      child: Text(
        title,
        maxLines: 2,
        style: MyTextStyle.headingWithBlack,
      ),
    );
  }

  Container DateTimeWidget() {
    return Container(
      child: Text(
        dateTime,
        style: MyTextStyle.headingWithBlue,
      ),
    );
  }
}
