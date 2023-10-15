import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itf_assignment/apis/get_all_events.dart';
import 'package:itf_assignment/formator/dateTimeFormator.dart';
import 'package:itf_assignment/models/event_model.dart';
import 'package:itf_assignment/provider/event_list_provider.dart';
import 'package:itf_assignment/screens/event_detail.dart';
import 'package:itf_assignment/utils/colors.dart';
import 'package:itf_assignment/utils/textstyle.dart';
import 'package:itf_assignment/widgets/event_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EventSearch extends StatefulWidget {
  const EventSearch({Key? key}) : super(key: key);

  @override
  _EventSearchState createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  final formator = Formator();
  final apiServices = ApiServices();
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<EventModel> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(updateSearchQuery);
  }

  void updateSearchQuery() {
    setState(() {
      searchQuery = searchController.text;
      filterEvents();
    });
  }

  Future<void> filterEvents() async {
    if (searchQuery.isEmpty) {
      final events = await apiServices.fetchEvents();
      context.read<EventListProvider>().updateEvents(events);
    } else {
      final events = await apiServices.searchEvents(searchQuery);
      context.read<EventListProvider>().updateEvents(events);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: MyTextStyle.heading1,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icon/search.svg",
                    color: MyColor.primaryBlue,
                  ),
                  Text(
                    " | ",
                    style: MyTextStyle.heading5,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      cursorColor: MyColor.primaryBlue,
                      style: MyTextStyle.heading6,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Event Name",
                        hintStyle: MyTextStyle.heading6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: context
                    .watch<EventListProvider>()
                    .eventListModel
                    .events
                    .length,
                itemBuilder: (context, index) {
                  final event = context
                      .watch<EventListProvider>()
                      .eventListModel
                      .events[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetail(
                              bannerImage: event.bannerImage,
                              title: event.title,
                              organiserName: event.organiserName,
                              organisericon: event.organiserIcon,
                              date: formator
                                  .formatDate(event.dateTime.toString()),
                              time: formator
                                  .formatTime(event.dateTime.toString()),
                              venueName: event.venueName,
                              venueCity: event.venueCity,
                              venueCountry: event.venueCountry,
                              description: event.description,
                            ),
                          ),
                        );
                      },
                      child: EventTile(
                        title: event.title,
                        dateTime:
                            formator.formatDateTime(event.dateTime.toString()),
                        venuename: event.venueName,
                        venuecity: event.venueCity,
                        venuecountry: event.venueCountry,
                        organizerIcon: event.organiserIcon,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(updateSearchQuery);
    searchController.dispose();
    super.dispose();
  }
}
