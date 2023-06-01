import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../api/firebase_entries.dart';
import 'package:sample/api/firebase_entries.dart';

class EntriesProvider with ChangeNotifier {
  late FirebaseEntriesAPI firebaseEntriesService;
  late Future<Map<String, dynamic>> _data;
  late Stream<QuerySnapshot> _entriesStream;
  String userDocRef = "";

  Stream<QuerySnapshot> get entriesStream => _entriesStream;
  Future<Map<String, dynamic>> get data => _data;

  // late bool _hasEntry;

  // bool get hasEntry => _hasEntry;
  // Future<Map<String, dynamic>> get data => _data;

  // void fetchTodaysEntry(String docRef) {
  //   _data = firebaseEntriesService.getTodaysEntry(docRef);
  //   notifyListeners();
  // }

  void addEntry(
      List<String> symptoms, bool hasContact, String userDocRef) async {
    Map<String, dynamic> newData = {
      "Date Generated": Timestamp.now(),
      "Has Contact": hasContact,
      "Status":
          (symptoms.isEmpty && !hasContact) ? "Cleared" : "Under Monitoring",
      "Symptoms": symptoms,
      "User DocRef": userDocRef
    };

    String message = await firebaseEntriesService.addEntry(newData);

    // if (message == "Successfully added an entry") {
    //   _hasEntry = true;
    // } else {
    //   print("no entry added");
    // }

    notifyListeners();
  }

  EntriesProvider() {
    firebaseEntriesService = FirebaseEntriesAPI();
    print("init entries");
    fetchEntries(userDocRef);
  }

  void fetchEntries(String userDocRef) {
    _entriesStream = firebaseEntriesService.getUserEntries(userDocRef);
    this.userDocRef = userDocRef;
    print("in fetch entries: $_entriesStream");
    notifyListeners();
  }
}
