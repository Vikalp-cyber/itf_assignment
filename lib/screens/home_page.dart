import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itf_assignment/apis/get_all_events.dart';
import 'package:itf_assignment/formator/dateTimeFormator.dart';
import 'package:itf_assignment/models/event_model.dart';
import 'package:itf_assignment/screens/event_detail.dart';
import 'package:itf_assignment/utils/textstyle.dart';
import 'package:itf_assignment/widgets/event_tile.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formator = Formator();

    final apiServices = ApiServices();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text(
          "Events",
          style: MyTextStyle.heading1,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/event-search");
            },
            child: SvgPicture.asset("assets/icon/search.svg"),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(left: 2.w, right: 2.w),
          child: FutureBuilder(
              future: apiServices.fetchEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error Occured"),
                  );
                } else {
                  List<EventModel>? events = snapshot.data;
                  return ListView.builder(
                    itemCount: events!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetail(
                                bannerImage: events[index].bannerImage,
                                title: events[index].title,
                                organiserName: events[index].organiserName,
                                organisericon: events[index].organiserIcon,
                                date: formator.formatDate(
                                    events[index].dateTime.toString()),
                                time: formator.formatTime(
                                    events[index].dateTime.toString()),
                                venueName: events[index].venueName,
                                venueCity: events[index].venueCity,
                                venueCountry: events[index].venueCountry,
                                description: events[index].description,
                              ),
                            ),
                          );
                        },
                        child: EventTile(
                          title: events[index].title,
                          dateTime: formator.formatDateTime(
                              events[index].dateTime.toString()),
                          venuename: events[index].venueName,
                          venuecity: events[index].venueCity,
                          venuecountry: events[index].venueCountry,
                          organizerIcon: events[index].organiserIcon,
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}
