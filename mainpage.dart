// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, sized_box_for_whitespace, equal_keys_in_map, avoid_print, unused_local_variable

import 'dart:collection';
import 'dart:ui';
import 'package:flutter_add/datails.dart';
import 'package:flutter_add/main.dart';
import 'package:flutter_add/page/searchpage.dart';
import 'package:http/http.dart';

import '../model/drawer.dart';
import 'api.dart';
import 'package:flutter_add/model/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  var images = {
    "icon1.png": "siliguri",
    "sevok.jpg": "sevok",
    "tree.png": "malda",
    "tav.png": "kolkata",
  };

  late List<Photo> photos;
  bool loading = true;
  getAlluser() async {
    photos = await GetDatails().getDatails();
    setState(() {
      loading = false;
    });
    print(photos.length);
  }

  @override
  void initState() {
    super.initState();
    getAlluser();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      drawer: NavigationDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 70, left: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationDrawer()));
                  },
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage('assests/images/icon1.png'),
                          fit: BoxFit.cover),
                      color: Colors.grey.withOpacity(0.5)),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text("Discover",
                style: TextStyle(
                    fontSize: 50,
                    //fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Color.fromARGB(255, 30, 10, 102))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Color.fromARGB(255, 0, 0, 0),
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    text: "places",
                  ),
                  Tab(
                    text: "inspiration",
                  ),
                  Tab(
                    text: "places",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: [
                loading
                    ? Center(
                        child: SerchPage(),
                      )
                    : ListView.builder(
                        itemCount: photos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final data = photos[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DataiPage(),
                                      settings:
                                          RouteSettings(arguments: data)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10, top: 10),
                              height: 300,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://tbhcr.online/New%20Folder/images/" +
                                            data.filename),
                                    fit: BoxFit.cover),
                              ),
                              padding: EdgeInsets.only(left: 50, top: 240),
                              child: Stack(
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                      fontSize: 40,
                                      //fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color =
                                            Color.fromARGB(255, 10, 184, 253),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                Text(' hacker '),
                Text('final year project  '),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore more',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text('see all',
                    style: TextStyle(color: Colors.grey, fontSize: 18))
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 120,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 20),
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(right: 10, top: 10),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assests/images/" +
                                    images.keys.elementAt(index)),
                                fit: BoxFit.cover),
                          ),
                          child: Text(''),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Text(images.values.elementAt(index)),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
