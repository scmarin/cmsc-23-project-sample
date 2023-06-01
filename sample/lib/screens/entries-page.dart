import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sample/providers/auth_provider.dart';
import 'package:sample/providers/entries_provider.dart';

class EntriesPage extends StatefulWidget {
  const EntriesPage({super.key});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  // late Stream<QuerySnapshot> entryTodayStream;
  // @override
  // void initState() {
  //   super.initState();
  //   entryTodayStream = context.watch<EntriesProvider>().entryTodayStream;
  // }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> entryTodayStream =
        context.watch<EntriesProvider>().entryTodayStream;

    StreamBuilder<QuerySnapshot> entryTodayBuilder = StreamBuilder(
      stream: entryTodayStream,
      builder: (context, snapshot) {
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
                ]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: (snapshot.data?.docs.length)!);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Today's Entry")),
      body: Column(
        children: [entryTodayBuilder],
      ),
    );
  }
}
