import 'package:admin_cru_recognition/widgets/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddReserveRoomScreen extends StatefulWidget {
  @override
  _AddReserveRoomScreenState createState() => _AddReserveRoomScreenState();
}

class _AddReserveRoomScreenState extends State<AddReserveRoomScreen> {
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
  TextEditingController dateController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  DateTime currentDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
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
                }),
              ],
            ),
          ),
          _buildTextFormField(
            'Room Number',
            'Enter Room Number',
            roomNumberController,
          ),
          _buildTextFormField(
            'Subject',
            'Enter Subject',
            subjectController,
          ),
          _buildDateFormField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeFormField(timeFromController),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text('to'),
              ),
              _buildTimeFormField(timeToController),
            ],
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {},
            child: Text('Add'),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFormField(TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.41,
        child: InkWell(
          onTap: () {
            _selectTime(context);
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

  Widget _buildTextFormField(
      String lebelText, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        String resultFormatTime = picked_s.format(context);
        timeFromController.text = resultFormatTime;
      });
  }
}
