library data_types;

class UserType {
  UserType({
    this.uuid = '',
    this.firstName = '',
    this.lastName = '',
    this.numHighPriority = -1,
    this.numMedications = -1,
    this.numNotTaken = -1,
    this.percentTaken = -1,
    DateTime? timeStamp,
  }) : timeStamp = timeStamp ?? DateTime.parse("1969-07-20 20:18:04Z");

  final String uuid;
  final String firstName;
  final String lastName;
  final int numMedications;
  final int numNotTaken;
  final int numHighPriority;
  final double percentTaken;
  DateTime? timeStamp;
  late final String token;
}

class MedicationType {
  MedicationType({this.medicationName = '', this.medicationPriority = -1});

  final int medicationPriority;
  final String medicationName;
}

class AlertType {
  AlertType(
      {this.id = 0,
      this.medicationPriority = -1,
      this.medicationName = '',
      this.firstName = '',
      this.lastName = '',
      DateTime? timeStamp,
      this.cleared = false,
      this.alertRead = false});
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

class ReportType {
  ReportType(
      {this.id = 0,
      this.medicationPriority = -1,
      this.medicationName = '',
      this.firstName = '',
      this.lastName = ''});

  final int id;
  final int medicationPriority;
  final String medicationName;
  final String firstName;
  final String lastName;
  late final DateTime timeStamp;

  bool? cleared;
  bool? alertRead;
}
