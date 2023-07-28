import 'package:citas_firebase/widgets/meetings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayMeetingsPage extends StatefulWidget {
  const TodayMeetingsPage({
    super.key,
  });

  @override
  State<TodayMeetingsPage> createState() => _TodayMeetingsPageState();
}

class _TodayMeetingsPageState extends State<TodayMeetingsPage> {
  var query = FirebaseDatabase.instance.ref().child("Posts");

  @override
  Widget build(BuildContext context) {
    bool widthScreen = MediaQuery.of(context).size.width < 680;
    String dateNow =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(48, 204, 176, 1),
        title: Text(
          "Citas Agendadas",
          style: GoogleFonts.arvo(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: widthScreen
            ? const EdgeInsets.symmetric(horizontal: 10)
            : const EdgeInsets.symmetric(horizontal: 180),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 70),
          child: FirebaseAnimatedList(
            query: query,
            itemBuilder: (context, snapshot, animation, index) {
              Map event = snapshot.value as Map;
              event['key'] = snapshot.key;
              if (event['date'] == dateNow) {
                return ItemMeetingDone(
                  idP: event['id'],
                  nameP: event['name'],
                  docP: event['document'],
                  dateP: event['date'],
                  timeP: event['hour'],
                  typeP: event['type_doc'],
                  priceP: event['price'],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------



