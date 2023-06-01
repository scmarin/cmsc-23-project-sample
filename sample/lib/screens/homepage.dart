import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample/providers/entries_provider.dart';

import 'package:sample/screens/authentication/login.dart';
import 'package:sample/screens/entries-page.dart';

import '../providers/auth_provider.dart';

import '../models/model_entry.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(Timestamp.fromDate(
        DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
            .add(const Duration(days: 1))));
    Stream<User?> userStream = context.watch<AuthProvider>().uStream;
    Stream<QuerySnapshot> entriesStream =
        context.watch<EntriesProvider>().entriesStream;

    StreamBuilder<QuerySnapshot> entriesStreamBuilder = StreamBuilder(
      stream: entriesStream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Text("no entry");
        } else {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(children: [
                  ListTile(
                    title: Text(
                        "${snapshot.data?.docs[index].data() as Map<String, dynamic>}"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<EntriesProvider>().getTodaysEntry(
                            context.read<AuthProvider>().userObj?.uid);
                        Navigator.pushNamed(context, "/entries-page");
                      },
                      child: const Text("See Entries"))
                ]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: (snapshot.data?.docs.length)!);
        }
      }),
    );

    Widget body = Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              context.read<AuthProvider>().signOut();
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [entriesStreamBuilder],
        ));

    return StreamBuilder(
      stream: userStream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const LoginPage();
        } else {
          print(snapshot.data!.uid);
          return body;
        }
        // if user is logged in, display the scaffold containing the streambuilder for the todos
      }),
    );
  }

  // Widget body(BuildContext context, Stream<QuerySnapshot> entriesStream) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         leading: TextButton(
  //           onPressed: () {
  //             context.read<AuthProvider>().signOut();
  //             Navigator.popUntil(context, ModalRoute.withName("/"));
  //           },
  //           child: const Icon(
  //             Icons.logout,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //       body: entriesStreamBuilder
  // body: Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Column(
  //     children: [
  //       Flexible(
  //           child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: (context
  //                   .read<UserInfoProvider>()
  //                   .hasEnteredEntryToday)
  //               ? [
  //                   Flexible(
  //                       child: Column(
  //                     children: [
  //                       Container(
  //                         margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
  //                         padding: const EdgeInsets.all(8),
  //                         width: MediaQuery.of(context).size.width,
  //                         decoration: BoxDecoration(
  //                           color: Colors.blue,
  //                           border: Border.all(
  //                               color: Colors.blueAccent, width: 2),
  //                           borderRadius:
  //                               const BorderRadius.all(Radius.circular(10)),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.black.withOpacity(0.3),
  //                               spreadRadius: 2,
  //                               blurRadius: 4,
  //                               offset: const Offset(0, 2),
  //                             ),
  //                           ],
  //                         ),
  //                         child: Text(
  //                           "Today's Health Entry",
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             fontSize: 24,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.white,
  //                             shadows: [
  //                               Shadow(
  //                                 color: Colors.lightBlueAccent
  //                                     .withOpacity(0.3),
  //                                 blurRadius: 2,
  //                                 offset: const Offset(0, 2),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
  //                         padding: const EdgeInsets.all(8),
  //                         child: Text(
  //                           context.watch<AppProvider>().getEntry(0).date,
  //                           textAlign: TextAlign.center,
  //                           style: const TextStyle(
  //                               fontSize: 12, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Container(
  //                           child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Flexible(
  //                             child: Container(
  //                               margin: const EdgeInsets.fromLTRB(
  //                                   20, 10, 10, 0),
  //                               padding: const EdgeInsets.all(10),
  //                               decoration: BoxDecoration(
  //                                   color: (context
  //                                           .watch<AppProvider>()
  //                                           .getEntry(0)
  //                                           .hasCloseContact)
  //                                       ? Colors.white
  //                                       : Colors.white10,
  //                                   border: Border.all(),
  //                                   borderRadius: const BorderRadius.all(
  //                                       Radius.circular(20))),
  //                               child: (context
  //                                       .watch<AppProvider>()
  //                                       .getEntry(0)
  //                                       .hasCloseContact)
  //                                   ? const Text(
  //                                       'CLOSE CONTACT',
  //                                       textAlign: TextAlign.center,
  //                                     )
  //                                   : const Text(
  //                                       'NO CONTACT',
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                             ),
  //                           ),
  //                           Flexible(
  //                             child: Container(
  //                               margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
  //                               padding: EdgeInsets.all(10),
  //                               decoration: BoxDecoration(
  //                                   color: (context
  //                                               .watch<AppProvider>()
  //                                               .getEntry(0)
  //                                               .status ==
  //                                           'Quarantined')
  //                                       ? Colors.red
  //                                       : (context
  //                                                   .watch<AppProvider>()
  //                                                   .getEntry(0)
  //                                                   .status ==
  //                                               'Under Monitoring')
  //                                           ? Colors.white
  //                                           : Colors.white10,
  //                                   border: Border.all(),
  //                                   borderRadius: const BorderRadius.all(
  //                                       Radius.circular(20))),
  //                               child: Text(
  //                                 context
  //                                     .watch<AppProvider>()
  //                                     .getEntry(0)
  //                                     .status
  //                                     .toUpperCase(),
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       )),
  //                       Container(
  //                         margin: const EdgeInsets.all(20),
  //                         padding: const EdgeInsets.all(10),
  //                         decoration: const BoxDecoration(
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(20))),
  //                         child: Column(
  //                           children: [
  //                             const ListTile(
  //                               tileColor: Colors.blue,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(8),
  //                                   topRight: Radius.circular(8),
  //                                   bottomLeft: Radius.zero,
  //                                   bottomRight: Radius.zero,
  //                                 ),
  //                               ),
  //                               title: Text("SYMPTOMS",
  //                                   textAlign: TextAlign.center),
  //                             ),
  //                             Container(
  //                                 // constraints: const BoxConstraints(
  //                                 //     maxHeight: 250),
  //                                 child: (context
  //                                             .watch<AppProvider>()
  //                                             .getEntry(0)
  //                                             .symptoms ==
  //                                         null)
  //                                     ? const Text("No Existing Symptoms")
  //                                     : GridView.builder(
  //                                         padding: EdgeInsets.all(0),
  //                                         shrinkWrap: true,
  //                                         // physics:
  //                                         //     NeverScrollableScrollPhysics(),
  //                                         gridDelegate:
  //                                             const SliverGridDelegateWithFixedCrossAxisCount(
  //                                                 crossAxisSpacing: 0,
  //                                                 crossAxisCount: 3,
  //                                                 childAspectRatio: 2),
  //                                         itemCount: context
  //                                             .watch<AppProvider>()
  //                                             .getProbSymptoms
  //                                             .length,
  //                                         itemBuilder: (context, index) {
  //                                           List<String> probableSymptoms =
  //                                               context
  //                                                   .watch<AppProvider>()
  //                                                   .getProbSymptoms;
  //                                           List<String>? symptoms = context
  //                                               .watch<AppProvider>()
  //                                               .getEntry(0)
  //                                               .symptoms;

  //                                           return ClipRRect(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(
  //                                                     8.0), // Add rounded corners
  //                                             child: Card(
  //                                               child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           8.0), // Match the border radius
  //                                                   border: Border.all(
  //                                                     color: (symptoms!.contains(
  //                                                             probableSymptoms[
  //                                                                 index]))
  //                                                         ? Colors.red
  //                                                         : Colors.green,
  //                                                     width: 1.0,
  //                                                   ),
  //                                                 ),
  //                                                 padding:
  //                                                     const EdgeInsets.all(
  //                                                         5),
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     probableSymptoms[
  //                                                         index],
  //                                                     textAlign:
  //                                                         TextAlign.center,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           );
  //                                         })),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   )),
  //                   const RecentEntries()
  //                 ]
  //               : [
  //                   Column(
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.all(30),
  //                         height: MediaQuery.of(context).size.height / 3,
  //                         child: Column(
  //                           mainAxisAlignment:
  //                               MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             Container(
  //                               width: double.infinity,
  //                               height:
  //                                   MediaQuery.of(context).size.height / 5,
  //                               padding: EdgeInsets.all(16.0),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.yellow,
  //                                 borderRadius: BorderRadius.circular(8.0),
  //                               ),
  //                               child: Align(
  //                                 alignment: Alignment.center,
  //                                 child: Row(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: const [
  //                                     Icon(
  //                                       Icons.warning,
  //                                       color: Colors.black,
  //                                       size: 24.0,
  //                                     ),
  //                                     SizedBox(width: 8.0),
  //                                     Text(
  //                                       'No entry yet',
  //                                       style: TextStyle(
  //                                         fontSize: 16.0,
  //                                         fontWeight: FontWeight.bold,
  //                                         color: Colors.black,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             ElevatedButton(
  //                               onPressed: () {
  //                                 // Navigate to entry page
  //                               },
  //                               style: ButtonStyle(
  //                                 backgroundColor:
  //                                     MaterialStateProperty.all<Color>(
  //                                         Colors.green),
  //                                 shape: MaterialStateProperty.all<
  //                                     RoundedRectangleBorder>(
  //                                   RoundedRectangleBorder(
  //                                     borderRadius:
  //                                         BorderRadius.circular(18.0),
  //                                   ),
  //                                 ),
  //                                 padding:
  //                                     MaterialStateProperty.all<EdgeInsets>(
  //                                   const EdgeInsets.symmetric(
  //                                       horizontal: 16.0, vertical: 12.0),
  //                                 ),
  //                               ),
  //                               child: Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: const [
  //                                   Icon(
  //                                     Icons.add_circle,
  //                                     color: Colors.white,
  //                                     size: 24.0,
  //                                   ),
  //                                   SizedBox(width: 8.0),
  //                                   Text(
  //                                     'Add Health Entry',
  //                                     style: TextStyle(
  //                                       fontSize: 16.0,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Colors.white,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       const RecentEntries()
  //                     ],
  //                   ),
  //                 ],
  //         ),
  //       )),
  //       // (context.watch<AppProvider>().getCurrentDate == entry.date)
  //     ],
  //   ),
  // ),
  // bottomNavigationBar: BottomNavigationBar(
  //     currentIndex: 1,
  //     items: const [
  //       BottomNavigationBarItem(
  //           icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Homepage'),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.edit),
  //         label: 'Edit an Entry',
  //       ),
  //     ],
  //     onTap: (index) => {
  //           if (index == 2) {Navigator.pushNamed(context, "/todays-entry")}
  //         }),
//         );
//   }
// }

// class RecentEntries extends StatelessWidget {
//   const RecentEntries({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // constraints: BoxConstraints(maxHeight: 100),
//       margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           const ListTile(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//                 bottomLeft: Radius.zero,
//                 bottomRight: Radius.zero,
//               ),
//             ),
//             tileColor: Colors.blue,
//             title: Text(
//               "Recent Entries",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             dense: true,
//           ),
//           ListView.builder(
//               // physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: context.watch<AppProvider>().getEntryCount,
//               itemBuilder: ((context, index) {
//                 Entry entry = context.watch<AppProvider>().getEntry(index);
//                 return ListTile(
//                   tileColor: Colors.grey[200],
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.blue,
//                     child: (entry.status == "Quarantined")
//                         ? Icon(Icons.sick, color: Colors.red)
//                         : ((entry.status == "Under Monitoring")
//                             ? Icon(Icons.mode_standby, color: Colors.orange)
//                             : Icon(Icons.emoji_emotions, color: Colors.green)),
//                   ),
//                   title: Text(
//                     entry.date,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   subtitle: Text(
//                     entry.status,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   trailing: IconButton(
//                     color: Colors.grey[400],
//                     icon: Icon(Icons.arrow_forward_ios),
//                     onPressed: () {
//                       //view the complete entry detail
//                     },
//                   ),
//                   shape:
//                       (index == context.watch<AppProvider>().getEntryCount - 1)
//                           ? RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                               topLeft: Radius.zero,
//                               topRight: Radius.zero,
//                               bottomLeft: Radius.circular(8),
//                               bottomRight: Radius.circular(8),
//                             ))
//                           : null,
//                 );
//               })),
//         ],
//       ),
//     );
//   }
// }
}
