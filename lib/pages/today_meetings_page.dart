import 'package:citas_firebase/models/fierbase_controller.dart';
import 'package:citas_firebase/widgets/ad_banner.dart';
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
              Map meet = snapshot.value as Map;
              meet['key'] = snapshot.key;
              if (meet['date'] == dateNow) {
                return ItemMeetingDone(
                  idP: meet['id'],
                  nameP: meet['name'],
                  docP: meet['document'],
                  dateP: meet['date'],
                  timeP: meet['hour'],
                  typeP: meet['type_doc'],
                  cellphone: meet['phone'],
                  priceP: meet['price'],
                  payStatus: meet['status_pay'],
                  changeStatusPayMeet: (p0) {
                    changeStatusPay(query,meet['key']);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
       bottomNavigationBar: BannerAd(),
    );
  }

  
}

//-------------------------------------------------------------------------------



