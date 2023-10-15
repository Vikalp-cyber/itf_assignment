import 'package:flutter/material.dart';
import 'package:itf_assignment/models/event_list.dart';
import 'package:itf_assignment/models/event_model.dart';

class EventListProvider extends ChangeNotifier {
  EventListModel eventListModel = EventListModel();

  void updateEvents(List<EventModel> newEvents) {
    eventListModel.events = newEvents;
    notifyListeners();
  }
}