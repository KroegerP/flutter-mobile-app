import 'dart:convert';
import 'dart:io';

import 'package:eva/utilities/dates.dart';
import 'package:eva/classes/data_types.dart';
import 'package:eva/utilities/firebase/storage/file_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageWidget extends StatefulWidget {
  final String downloadUrl;

  const ImageWidget({super.key, required this.downloadUrl});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late File _imageFile = File('');

  @override
  void initState() {
    super.initState();
    _downloadImage();
  }

  Future<void> _downloadImage() async {
    debugPrint('Download Image call: ${widget.downloadUrl}');
    final downloader = FileDownloader();
    final file = await downloader.downloadFile(widget.downloadUrl);
    setState(() {
      _imageFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_imageFile.path.isNotEmpty) {
      debugPrint('Not Empty!');
      debugPrint(_imageFile.path);
      debugPrint(_imageFile.uri.toString());
    } else {
      debugPrint('EMPTY');
    }

    return _imageFile.path.isNotEmpty
        ? Image.file(_imageFile)
        : const CircularProgressIndicator();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  void _goToReportsPage() async {
    debugPrint("Sending to reports page!");
    await Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  // Local method of gathering JSON data
  Future<UserType> readJson() async {
    final String response =
        await rootBundle.loadString('assets/sampleData/userInfoSample.json');
    final userInfo = await jsonDecode(response);

    debugPrint("DATA: ${userInfo.toString()}");
    debugPrint(userInfo.toString());

    UserType user = UserType(
        uuid: userInfo["uuid"] ?? '',
        firstName: userInfo["firstName"] ?? '',
        lastName: userInfo["lastName"] ?? '',
        numMedications: userInfo["numMedications"] ?? -1,
        numHighPriority: userInfo["numHighPriority"] ?? -1,
        numNotTaken: userInfo["numNotTaken"] ?? -1,
        percentTaken: userInfo["percentTaken"] ?? -1,
        timeStamp: DateTime.parse(userInfo["timeStamp"]));

    debugPrint("creating user ${userInfo["timeStamp"]}");

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: FutureBuilder(
          future: readJson(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              UserType user = snapshot.data;
              debugPrint("TIMESTAMP: ${snapshot.data.timeStamp.toString()}");
              return Column(
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
                      padding: const EdgeInsets.only(
                          bottom: 16, right: 16, left: 16),
                      child: Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        "Your Report for ${formatDate(user.timeStamp ?? DateTime.now())}",
                      )),
                  Text(
                    "${user.firstName} ${user.lastName} has NUMBER medications",
                  ),
                  const Text(
                      "NAME has NOT taken QUANTITY of their medications"),
                  const Text("NUMBER are high priority medications"),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        _goToReportsPage();
                      },
                      child: const Text("Click here to view detailed reports")),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }
}
