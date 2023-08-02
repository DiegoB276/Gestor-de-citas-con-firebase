import 'package:citas_firebase/models/fierbase_controller.dart';
import 'package:citas_firebase/widgets/meetings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchByDatePage extends StatefulWidget {
  const SearchByDatePage({super.key});

  @override
  State<SearchByDatePage> createState() => _SearchByDatePageState();
}

class _SearchByDatePageState extends State<SearchByDatePage> {
  var query = FirebaseDatabase.instance.ref().child("Posts");

  late String date = '';
  late String resultDate = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(48, 204, 176, 1),
        title: Text(
          "Buscar por Fecha",
          style: GoogleFonts.arvo(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000),
                  );
                  setState(() {
                    date =
                        "${pickedDate!.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(135, 158, 237, 1),
                      ),
                      top: BorderSide(
                        color: Color.fromRGBO(135, 158, 237, 1),
                      ),
                      right: BorderSide(
                        color: Color.fromRGBO(135, 158, 237, 1),
                      ),
                      left: BorderSide(
                        color: Color.fromRGBO(135, 158, 237, 1),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      date.isEmpty ? 'Ingresa la Fecha' : date,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    resultDate = date;
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

                    if (meet['date'] == resultDate) {
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
    );
  }
}
