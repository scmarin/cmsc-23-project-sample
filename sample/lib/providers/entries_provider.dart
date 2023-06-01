import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/api/firebase_auth_api.dart';
import '../api/firebase_entries.dart';
import 'package:sample/api/firebase_entries.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntriesProvider with ChangeNotifier {
  late FirebaseEntriesAPI firebaseEntriesService;
  late FirebaseAuthAPI firebaseAuthService;
  late Future<Map<String, dynamic>> _data;
  late Stream<QuerySnapshot> _entriesStream;
  late Stream<QuerySnapshot> _entryTodayStream;
  String? userDocRef = "";
  late Stream<User?> uStream;
  User? userObj;

  Stream<QuerySnapshot> get entriesStream => _entriesStream;
  Stream<QuerySnapshot> get entryTodayStream => _entryTodayStream;
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
    firebaseAuthService = FirebaseAuthAPI();
    // firebaseAuthService.getUser().listen((user) {
    //   print(user?.uid);
    //   this.userDocRef = user?.uid;
    // });

    print("init entries: $userDocRef");
    fetchEntries(this.userDocRef);
  }

  void fetchEntries(String? userDocRef) {
    _entriesStream = firebaseEntriesService.getUserEntries(userDocRef!);
    _entryTodayStream = firebaseEntriesService.getEntryToday(userDocRef);
    this.userDocRef = userDocRef;
    print("in fetch entries: $_entriesStream");
    notifyListeners();
  }

  void getTodaysEntry(String? userDocRef) {
    _entryTodayStream = firebaseEntriesService.getEntryToday(userDocRef!);
    notifyListeners();
  }
}
