import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:killcorona/screens/charts.dart';

void main() => runApp(MaterialApp(
      title: "Kill Corona",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: ThuloCovid(),
    ));

class ThuloCovid extends StatefulWidget {
  @override
  _ThuloCovidState createState() => _ThuloCovidState();
}

class _ThuloCovidState extends State<ThuloCovid> {
  //fpr loading icon
  bool loading = true;
  List lstCountry;

  //taking Data from API
  Future<String> _getWorldData() async {
    var respose = await http.get("https://brp.com.np/covid/country.php");
    var getData = json.decode(respose.body);
    if (this.mounted) {
      setState(() {
        loading = false;
        lstCountry = [getData];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kill COrorna'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getWorldData();
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lstCountry == null
                      ? 0
                      : lstCountry[0]["countries_stat"].length,
                  itemBuilder: (context, i) {
                    return listItem(i);
                  }),
        ],
      ),
    );
  }

  Widget listItem(int i) {
    return Column(
      children: <Widget>[
        Center(
            child: Text(
          lstCountry[0]["countries_stat"][i]["country_name"],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["active_cases"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'Sankramit',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["deaths"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'Mrityu',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["deaths"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'Niko vako',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.orange,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["new_cases"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'Naya Sankramit',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["new_deaths"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'Naya Mrityu',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    lstCountry[0]["countries_stat"][i]["deaths"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  Text(
                    'raheko case',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
