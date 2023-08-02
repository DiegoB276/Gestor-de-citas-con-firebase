import 'package:citas_firebase/models/fierbase_controller.dart';
import 'package:citas_firebase/widgets/ad_banner.dart';
import 'package:citas_firebase/widgets/meetings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingSearchPage extends StatefulWidget {
  const MeetingSearchPage({super.key});

  @override
  State<MeetingSearchPage> createState() => _MeetingSearchPageState();
}

class _MeetingSearchPageState extends State<MeetingSearchPage> {
  late TextEditingController searchController;
  var query = FirebaseDatabase.instance.ref().child("Posts");
  late var resultTextField = '';

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(48, 204, 176, 1),
        title: Text(
          "Buscar Cita",
          style: GoogleFonts.arvo(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: "Número de Documento",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(135, 158, 237, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(135, 158, 237, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resultTextField = searchController.text;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Buscar",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 400,
                child: FirebaseAnimatedList(
                  query: query,
                  itemBuilder: (context, snapshot, animation, index) {
                    Map meet = snapshot.value as Map;
                    meet['key'] = snapshot.key;

                    if (meet['document'] == resultTextField) {
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
                          changeStatusPay(query, meet['key']);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BannerAd(),
    );
  }
}
