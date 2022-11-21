import 'package:flutter/material.dart';

class IndividualReport extends StatefulWidget {
  final String reportId;

  const IndividualReport({Key? key, required this.reportId}) : super(key: key);

  @override
  State<IndividualReport> createState() => _IndividualReportState();
}

class _IndividualReportState extends State<IndividualReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual report for report #${widget.reportId}'),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image:
                    AssetImage('assets/chart.png'), //TODO: pull image from pi
              ),
            ),
          ), // TODO: Make this rich with a identifying title
          Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Text(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                "Your Report for November 10th, 2022",
              ))
        ],
      ),
    );
  }
}
