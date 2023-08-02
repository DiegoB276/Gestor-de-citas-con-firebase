import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ItemMeetingDone extends StatelessWidget {
  ItemMeetingDone({
    super.key,
    required this.idP,
    required this.nameP,
    required this.docP,
    required this.dateP,
    required this.timeP,
    required this.typeP,
    required this.cellphone,
    required this.priceP,
    required this.payStatus,
    required this.changeStatusPayMeet,
  });

  final int? idP;
  final String? nameP;
  final String? docP;
  final String? dateP;
  final String? timeP;
  final String? typeP;
  final String? cellphone;
  final int? priceP;
  late String? payStatus;
  Function(BuildContext?) changeStatusPayMeet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: changeStatusPayMeet,
              icon: Icons.monetization_on_outlined,
              backgroundColor: const Color.fromARGB(255, 94, 141, 131),
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          height: 145,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 204, 212, 210),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nameP!,
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Código: " "$idP",
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$typeP" ":" " ${int.parse(docP.toString())}",
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tel: ${int.parse(cellphone.toString())}",
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade900),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 186, 194, 196),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Precio: \$" "$priceP",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateP!,
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      timeP!,
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text('Pagado: $payStatus',
                      style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
