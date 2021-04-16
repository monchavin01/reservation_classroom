import 'package:flutter/material.dart';

class DetailReserve extends StatefulWidget {
  final data;
  DetailReserve({Key key, @required this.data}) : super(key: key);
  @override
  _DetailReserveState createState() => _DetailReserveState();
}

class _DetailReserveState extends State<DetailReserve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Room Number:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.data.data()['roomNumber']),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Subject:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.data.data()['subject']),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Date:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.data.data()['date']),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Time:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.data.data()['timeFromSchedule']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('To'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.data.data()['timeToSchedule']),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
