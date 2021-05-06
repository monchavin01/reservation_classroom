import 'package:admin_cru_recognition/widgets/dropDown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddReserveRoomScreen extends StatefulWidget {
  @override
  _AddReserveRoomScreenState createState() => _AddReserveRoomScreenState();
}

class _AddReserveRoomScreenState extends State<AddReserveRoomScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  var _chosenValueCollection;
  var _chosenValueDoc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  DateTime currentDate = DateTime.now();
  TimeOfDay selectedTimeTo = TimeOfDay.now();
  TimeOfDay selectedTimeFrom = TimeOfDay.now();

  var formatter = DateFormat('dd-MM-yyyy');
  var formattedTime = DateFormat('kk:mm a');

  @override
  void initState() {
    dateController.text = formatter.format(currentDate);
    timeFromController.text = formattedTime.format(currentDate);
    timeToController.text = formattedTime.format(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
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
                    MediaQuery.of(context).size.width * 0.25,
                    MediaQuery.of(context).size.height * 0.06,
                    _chosenValueDoc, (String value) {
                  setState(() {
                    _chosenValueDoc = value;
                  });
                }),
              ],
            ),
          ),
          _buildTextFormField('Room Number', 'Enter Room Number',
              roomNumberController, validate),
          _buildTextFormField(
              'Subject', 'Enter Subject', subjectController, validate),
          _buildDateFormField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeFormField(timeFromController, "timeFrom"),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text('to'),
              ),
              _buildTimeFormField(timeToController, "timeTo"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              _onPressed(context);
            },
            child: Text('Add'),
          ),
        ),
      ),
    );
  }

  String validate(String value) {
    print("value");
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
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

  Widget _buildTimeFormField(TextEditingController controller, String type) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.41,
        child: InkWell(
          onTap: () {
            _selectTime(context, type);
          },
          child: IgnorePointer(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter time';
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                  labelText: "",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timelapse_rounded)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateFormField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: IgnorePointer(
          child: TextFormField(
            // onSaved: (val) {
            //   task.date = selectedDate;
            // },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter date';
              }
              return null;
            },
            controller: dateController,
            decoration: InputDecoration(
                labelText: "",
                border: OutlineInputBorder(),
                hintText: "55555",
                prefixIcon: Icon(Icons.date_range)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String lebelText, String hintText,
      TextEditingController controller, validate) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: validate,
        controller: controller,
        decoration: InputDecoration(
          labelText: lebelText,
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        String formattedDate = formatter.format(pickedDate);
        currentDate = pickedDate;
        dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    if (type == "timeTo") {
      final TimeOfDay pickedTimeTo = await showTimePicker(
          context: context,
          initialTime: selectedTimeTo,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (pickedTimeTo != null && pickedTimeTo != selectedTimeTo)
        setState(() {
          selectedTimeTo = pickedTimeTo;
          String resultFormatTime = pickedTimeTo.format(context);
          timeToController.text = resultFormatTime;
        });
    } else {
      final TimeOfDay pickedFrom = await showTimePicker(
          context: context,
          initialTime: selectedTimeFrom,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (pickedFrom != null && pickedFrom != selectedTimeFrom)
        setState(() {
          selectedTimeFrom = pickedFrom;
          String resultFormatTime = pickedFrom.format(context);
          timeFromController.text = resultFormatTime;
        });
    }
  }

  void _onPressed(BuildContext context) {
    if (_chosenValueCollection == null ||
        _chosenValueCollection.isEmpty ||
        _chosenValueDoc == null ||
        _chosenValueDoc.isEmpty ||
        roomNumberController.text.isEmpty ||
        roomNumberController.text == null ||
        subjectController.text.isEmpty ||
        subjectController.text == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('validate value should not empty.'),
        backgroundColor: Colors.red,
      ));
    } else {
      firestoreInstance
          .collection("reservation-classroom")
          .doc(_chosenValueCollection)
          .collection(_chosenValueDoc)
          .add({
        "date": dateController.text,
        "roomNumber": roomNumberController.text,
        "subject": subjectController.text,
        "timeFromSchedule": timeFromController.text,
        "timeToSchedule": timeToController.text,
      }).then((value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('success.'),
          backgroundColor: Colors.green,
        ));
      });
    }
  }
}
