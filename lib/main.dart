import 'package:flutter/material.dart';
import 'package:itf_assignment/provider/event_list_provider.dart';
import 'package:itf_assignment/screens/event_search.dart';
import 'package:itf_assignment/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> routes = {
      "/home-page": (context) => const MyHomePage(),
      "/event-search": (context) => const EventSearch(),
    };
    return ChangeNotifierProvider(
      create: (context) => EventListProvider(),
      child: Sizer(
        builder: (context, _, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            ),
            routes: routes,
            initialRoute: "/home-page",
          );
        },
      ),
    );
  }
}
