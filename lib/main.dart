import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  List<Widget> mylist = [];

  void getdata() async {
    var resp = await http.get(
      Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"),
    );
    if (resp.statusCode == 200) {
      String data = resp.body;
      for (int i = 0; i < 50; i += 2) {
        String txt1 = jsonDecode(data)[i]['name'];
        String url1 = jsonDecode(data)[i]['image_link'];
        String price1 = jsonDecode(data)[i]['price'];
        String txt2 = jsonDecode(data)[i + 1]['name'];
        String url2 = jsonDecode(data)[i + 1]['image_link'];
        String price2 = jsonDecode(data)[i + 1]['price'];
        mylist.add(mytile(txt1, url1, price1, txt2, url2, price2));
      }
      // setState(() {
      // });

    } else
      print(resp.statusCode);
  }

  Color getColor(Set states) {
    return Color(0xFF126e82);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF132c33),
          body: ListView(children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(getColor),
              ),
              onPressed: () async {
                await getdata();
                setState(() {});
              },
              child: Text("Show Catalogue"),
            ),
            Column(
              children: mylist,
            )
          ])),
    );
  }
}

class mytile extends StatelessWidget {
  String txt1;
  String url1;
  String price1;
  String txt2;
  String url2;
  String price2;
  mytile(this.txt1, this.url1, this.price1, this.txt2, this.url2, this.price2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: mycard(txt1, url1, price1)),
        Expanded(child: mycard(txt2, url2, price2)),
      ],
    );
  }
}

class mycard extends StatelessWidget {
  String txt;
  String url;
  String price;
  mycard(this.txt, this.url, this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  txt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Text(
                  " PRICE: \$$price ",
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Color(0xFF51c4d3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(url),
                )),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
