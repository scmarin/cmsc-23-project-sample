class Entry {
  late String userId;
  late String date;
  late List<String> symptoms;
  late bool hasCloseContact;
  late String status;

  Entry(
      {required this.userId,
      required this.date,
      required this.symptoms,
      required this.hasCloseContact,
      required this.status});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        userId: json['User DocRef'],
        date: json['Date Generated'],
        symptoms: json['Symptoms'].cast(String),
        hasCloseContact: json['Has Contact'].cast(bool),
        status: json["Status"]);
  }

  Map<String, dynamic> toJson(Entry entry) {
    return {
      "User DocRef": entry.userId,
      "Date Generated": entry.date,
      "Symptoms": entry.symptoms,
      "Has Contact": entry.hasCloseContact,
      "Status": entry.status
    };
  }
}
