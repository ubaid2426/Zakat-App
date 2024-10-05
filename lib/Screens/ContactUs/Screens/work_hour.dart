import 'package:flutter/material.dart';
import 'package:zakat_app/core/app_dummy.dart';

class WorkingHour extends StatelessWidget {
  const WorkingHour({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Working Hours'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: workingHoursData.length,
        itemBuilder: (context, index) {
          final workingHours = workingHoursData[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workingHours['title']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    workingHours['days']!,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    workingHours['friday']!,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: WorkingHour()));
