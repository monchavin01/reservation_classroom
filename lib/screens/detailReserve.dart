import 'package:flutter/material.dart';

class DetailReserve extends StatefulWidget {
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
                    child: Text('2222'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Subject:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('math'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Date:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('01/02/2540'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Time:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('01.00 AM'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('To'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('02.00 AM'),
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
