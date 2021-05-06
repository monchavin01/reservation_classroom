import 'package:admin_cru_recognition/screens/addReserveRoom.dart';
import 'package:admin_cru_recognition/screens/detailReserve.dart';
import 'package:admin_cru_recognition/widgets/dropDown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var _chosenValueCollection;
  var _chosenValueDoc;

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
                  _chosenValueCollection != null && _chosenValueDoc != null
                      ? FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("reservation-classroom")
                              .doc(_chosenValueCollection)
                              .collection(_chosenValueDoc)
                              .orderBy("date", descending: true)
                              .get(),
                          builder: (context, snapshot) {
                            return (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? Center(child: CircularProgressIndicator())
                                : snapshot.data.documents.length > 0
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        // controller: _controller, //new line
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (context, index) {
                                          return _buildScheduleList(
                                              context, index, snapshot);
                                        })
                                    : Center(
                                        child: Text(
                                          "Don't have data",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      );
                          })
                      : Center(
                          child: Text(
                            'Please select building and floor',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                ],
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          // color: Colors.white70,
          child: Row(
            children: [
              DropDown().buildDropDown(
                  "building name",
                  ListData.buildingList,
                  MediaQuery.of(context).size.width * 0.6,
                  MediaQuery.of(context).size.height * 0.06,
                  _chosenValueCollection, (String value) {
                setState(() {
                  _chosenValueCollection = value;
                });
              }),
              DropDown().buildDropDown(
                  "floor",
                  checkCondition(),
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.height * 0.06,
                  _chosenValueDoc, (String value) {
                setState(() {
                  _chosenValueDoc = value;
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
          ).then((value) => {setState(() {})});
        },
        tooltip: 'reserve room',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildScheduleList(
      BuildContext context, index, AsyncSnapshot snapshot) {
    DocumentSnapshot data = snapshot.data.docs[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailReserve(
                  data: data,
                  collection: _chosenValueCollection,
                  doc: _chosenValueDoc),
            ),
          ).then((value) => {setState(() {})});
        },
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.1,
          // width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500], spreadRadius: 0.2, blurRadius: 2),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Room number:'),
                    SizedBox(width: 16),
                    Text(
                      data.data()['roomNumber'],
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Subject:'),
                    SizedBox(width: 16),
                    Text(
                      data.data()['subject'],
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Date:'),
                    SizedBox(width: 16),
                    Text(
                      data.data()['date'],
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('time:'),
                    SizedBox(width: 16),
                    Text(
                      data.data()['timeFromSchedule'],
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(width: 16),
                    Text('to'),
                    SizedBox(width: 16),
                    Text(
                      data.data()['timeToSchedule'],
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> checkCondition() {
    if (_chosenValueCollection != "building 15") {
      if (_chosenValueCollection != "building 28") {
        if (_chosenValueCollection != "building it") {
          if (_chosenValueCollection != "building physical education") {
            if (_chosenValueCollection != "building welfare") {
              return ListData.gym;
            }
            return ListData.floorBuildingWelfare;
          }
          return ListData.floorBuildingPhysicalEducation;
        }
        return ListData.floorBuildingIT;
      }
      return ListData.floorBuilding28;
    }
    return ListData.floorBuilding15;
  }
}
