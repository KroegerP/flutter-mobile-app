import 'package:eva/classes/data_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndividualReport extends StatefulWidget {
  final AlertType reportId;

  const IndividualReport({Key? key, required this.reportId}) : super(key: key);

  @override
  State<IndividualReport> createState() => _IndividualReportState();
}

class _IndividualReportState extends State<IndividualReport> {
  @override
  Widget build(BuildContext context) {
    AlertType report = widget.reportId;

    String formattedDate = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    debugPrint(report.medicationName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Individual report for ${report.medicationName}'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/chart.png'),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Text(
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                "Your Report for $formattedDate",
              ))
        ],
      ),
    );
  }
}
