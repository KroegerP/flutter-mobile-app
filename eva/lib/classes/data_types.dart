library data_types;

import 'package:cloud_firestore/cloud_firestore.dart';

class UserType {
  UserType({
    this.uuid = '',
    this.firstName = '',
    this.lastName = '',
    this.numHighPriority = -1,
    this.numMedications = -1,
    this.numNotTaken = -1,
    this.percentTaken = -1,
    this.isAnonymous = true,
    DateTime? timeStamp,
  }) : timeStamp = timeStamp ?? DateTime.parse("1969-07-20 20:18:04Z");

  final String uuid;
  final String firstName;
  final String lastName;
  final int numMedications;
  final int numNotTaken;
  final int numHighPriority;
  final num percentTaken;
  DateTime? timeStamp;
  late final String token;
  late final String mobileUserName;
  late bool isAnonymous;
}

class MedicationType {
  MedicationType({this.medicationName = '', this.medicationPriority = -1});

  final int medicationPriority;
  final String medicationName;
}

class AlertType {
  AlertType({
    this.id = 0,
    this.medicationPriority = -1,
    this.medicationName = '',
    this.firstName = '',
    this.lastName = '',
    DateTime? timeStamp,
    this.cleared = false,
    this.alertRead = false,
  });
  // : timeStamp = timeStamp ?? DateTime.now();

  final int id;
  final int medicationPriority;
  final String medicationName;
  final String firstName;
  final String lastName;
  late final DateTime timeStamp;

  bool? cleared;
  bool? alertRead;
}

class Medication {
  final String name;
  final int amountPerUse;
  final DateTime dateAdded;
  final String reportUrl;
  final int initialPillCount;
  final int priority;

  Medication(this.amountPerUse, this.dateAdded, this.reportUrl,
      this.initialPillCount, this.priority, this.name);

  factory Medication.fromFirestore(Map<String, dynamic> data) {
    // return Medication(name: data['medname'] ?? '', );'
    // return Medication(name: data['amountperuse'] ?? '', amountPerUse: data['amountperuse'] ?? 0, dateAdded: data['date_added'] ?? DateTime(), priority: data['priority'] ?? 0)
    int amountPerUse = data['amountperuse'] ?? 0;
    DateTime dateAdded = data['date_added'] ?? DateTime(2023);
    String reportUrl = data['reportUrl'] ?? '';
    int initialPillCount = data['initialpillcount'] ?? 0;
    int priority = data['priority'] ?? 0;
    String name = data['medname'] ?? '';

    return Medication(
        amountPerUse, dateAdded, reportUrl, initialPillCount, priority, name);
  }
}

class ReportType {
  ReportType(
      {this.id = 0,
      this.medicationPriority = -1,
      this.medicationName = '',
      this.chartUrl = '',
      percentMissedWeek = 0,
      this.amountPerUse = 0,
      this.timesPerDay = 0,
      this.timesPerWeek = const [],
      initialPillCount = 0});

  final int id;
  final int medicationPriority;
  final String medicationName;
  final String chartUrl;
  late final DateTime timeStamp;
  late double percentMissedWeek;
  late int timesPerDay;
  late int amountPerUse;
  final List<String> timesPerWeek;
  final int initialPillCount = 0;

  bool? cleared;
  bool? alertRead;

  factory ReportType.fromFirestore(DocumentSnapshot doc) {
    final rep = ReportType(
        medicationName: doc.get('medname') ?? '',
        medicationPriority: doc.get('priority') ?? 0,
        timesPerDay: doc.get('times_per_day') ?? 0,
        amountPerUse: doc.get('amount_per_use') ?? 0,
        timesPerWeek: List<String>.from(doc.get('times_per_week')),
        initialPillCount: doc.get('initial_pill_count') ?? 0);
    return rep;
  }
}
