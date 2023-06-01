import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseEntriesAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUserEntries(String userDocRef) {
    print(userDocRef);
    final entriesSnapshot = db
        .collection("entries")
        .where("User DocRef", isEqualTo: userDocRef)
        .snapshots();
    entriesSnapshot.listen((event) {
      print("current data: ${event.docs.length}");
      event.docs.forEach((element) {
        print(element.data() as Map<String, dynamic>);
      });
    });
    return entriesSnapshot;
  }

  Stream<QuerySnapshot> getEntryToday(String userDocRef) {
    print(userDocRef);
    final entryTodaySnapshot = db
        .collection("entries")
        .where("User DocRef", isEqualTo: userDocRef)
        .where("Date Generated",
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.parse(
                DateFormat("yyyy-MM-dd").format(DateTime.now()))))
        .where("Date Generated",
            isLessThan: Timestamp.fromDate(
                DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
                    .add(const Duration(days: 1))))
        .snapshots();
    print(entryTodaySnapshot.listen((event) {
      print("today's data: ${event.docs.length}");
    }));
    return entryTodaySnapshot;
  }

  // Future<Map<String, dynamic>> getTodaysEntry(String docRef) async {
  //   print("CHECK");
  //   Map<String, dynamic> todaysEntry = {};

  //   DocumentSnapshot userSnapshot =
  //       await db.collection("user-info").doc(docRef).get();
  //   List<DocumentReference> entriesList =
  //       (userSnapshot.data() as Map<String, dynamic>)["Entries"]
  //           .cast<DocumentReference>();

  //   entriesList.forEach((element) async {
  //     DocumentSnapshot entrySnapshot =
  //         await db.collection("entries").doc(element.toString()).get();
  //     Timestamp entryDate = ((entrySnapshot.data()
  //         as Map<String, dynamic>)["Date Generated"] as Timestamp);
  //     DateTime entryDateTime = entryDate.toDate();
  //     DateFormat("yyyy-MM-dd").format(entryDateTime);
  //     if ((entrySnapshot.data() as Map<String, dynamic>)["Date Generated"] ==
  //         DateFormat("yyyy-MM-dd").format(DateTime.now())) {
  //       todaysEntry = entrySnapshot.data() as Map<String, dynamic>;
  //     }
  //   });

  //   return todaysEntry;
  // }

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      DocumentReference entryDocRef = await db.collection("entries").add(entry);
      DocumentSnapshot userSnapshot =
          await db.collection("user-info").doc(entry["User DocRef"]).get();
      List<DocumentReference> entriesList =
          (userSnapshot.data() as Map<String, dynamic>)["Entries"]
              .cast<DocumentReference>();
      entriesList.add(entryDocRef);
      db
          .collection("entries")
          .doc(entry["User DocRef"])
          .update({'Entries': entriesList});

      return "Successfully added an entry";
    } on FirebaseException catch (e) {
      return "Failed with error code: ${e.code}";
    }
  }
}
