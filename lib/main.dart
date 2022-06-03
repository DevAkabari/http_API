import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
      ),
      home: MyHomePage(),
    );
  }
}

late String stringResponce;
late Map mapResponse;
late Map dataResponse;
late List listRisponse;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var res;

  Future getdata() async {
    var res = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    print(res.statusCode);
    if (res.statusCode == 200) {
      setState(() {
        stringResponce = res.body;
        mapResponse = json.decode(res.body);
        listRisponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Center(
        //           child: listRisponse == null
        //               ? Text("LOADING")
        //               : Text(listRisponse[3]['avatar'].toString())),
        //       Image.asset(
        //         listRisponse[3]['avatar'].toString(),
        //         height: 100,
        //         width: 100,
        //       )
        //     ],
        //   ),
        // ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.5)),
              child: Column(children: [
                Image.network(listRisponse[index]['avatar']),
                Text(listRisponse[index]["id"].toString()),
                Text(listRisponse[index]["email"].toString()),
                Text.rich(TextSpan(
                    text: listRisponse[index]["first_name"].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                        text: listRisponse[index]["last_name"].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ])),
              ]),
            );
          },
          itemCount: listRisponse == null ? 0 : listRisponse.length,
        ),
      ),
    );
  }
}
