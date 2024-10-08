import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Commented out the error
    // throw UnimplementedError();

    int count;
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text("GeoLoc"),
        ),
        appBar: AppBar(
          title: const Text("Geolocation based attedance"),
          centerTitle: true,
        ),
        // ignore: prefer_const_constructors
        floatingActionButtonAnimator: FloatingActionButton()(
            child: const Icon(Icons.add_ic_call_rounded),
            count = 0, Onpressed: () {
          count = count + 5;
          print("This button has been clicked");
          print(count);
        }),
      ),
    );
  }
}
