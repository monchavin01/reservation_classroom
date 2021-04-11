import 'package:admin_cru_recognition/screens/addReserveRoom.dart';
import 'package:admin_cru_recognition/screens/detailReserve.dart';
import 'package:admin_cru_recognition/widgets/dropDown.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _chosenValue;
  List<String> buildingList = [
    'onGrass',
    'running',
    'court',
  ];
  List<String> floorList = [
    '1',
    '2',
    '3',
  ];
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // controller: _controller, //new line
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      itemCount: 100,
                      itemBuilder: _buildScheduleList),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.white70,
          child: Row(
            children: [
              DropDown().buildDropDown(
                  "building name",
                  buildingList,
                  MediaQuery.of(context).size.width * 0.6,
                  MediaQuery.of(context).size.height * 0.06,
                  _chosenValue, (String value) {
                setState(() {
                  _chosenValue = value;
                });
              }),
              DropDown().buildDropDown(
                  "floor",
                  buildingList,
                  MediaQuery.of(context).size.width * 0.25,
                  MediaQuery.of(context).size.height * 0.06,
                  _chosenValue, (String value) {
                setState(() {
                  _chosenValue = value;
                });
              })
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReserveRoomScreen(),
            ),
          );
        },
        tooltip: 'reserve room',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildScheduleList(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailReserve(),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500], spreadRadius: 0.2, blurRadius: 2),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('room number'),
                    SizedBox(width: 16),
                    Text('9002')
                  ],
                ),
                Row(
                  children: [
                    Text('subject'),
                    SizedBox(width: 16),
                    Text('math')
                  ],
                ),
                Row(
                  children: [
                    Text('time'),
                    SizedBox(width: 16),
                    Text('9002'),
                    SizedBox(width: 16),
                    Text('to'),
                    SizedBox(width: 16),
                    Text('9002')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
