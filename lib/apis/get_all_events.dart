import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itf_assignment/models/event_model.dart';

class ApiServices{
  Future<List<EventModel>> fetchEvents() async {
  final String apiUrl = "https://sde-007.api.assignment.theinternetfolks.works/v1/event"; 
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final List<dynamic> eventData = jsonData['content']['data'];

    if (eventData != null) {
      List<EventModel> events = eventData.map((event) {
        return EventModel.fromJson(event);
      }).toList();
      return events;
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load event data');
  }
}
Future<List<EventModel>> searchEvents(String query) async {
   const String apiUrl = "https://sde-007.api.assignment.theinternetfolks.works/v1/event";
    final searchUrl = Uri.parse('$apiUrl?search=$query');
    final response = await http.get(searchUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> eventData = jsonData['content']['data'];

      if (eventData != null) {
        List<EventModel> events = eventData.map((event) {
          return EventModel.fromJson(event);
        }).toList();
        return events;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to search for events');
    }
  }
}
