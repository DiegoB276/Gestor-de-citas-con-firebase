import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:citas_firebase/models/connection.dart';
import 'package:citas_firebase/models/constants_and_variables.dart';
import 'package:citas_firebase/models/fierbase_controller.dart';
import 'package:citas_firebase/widgets/ad_banner.dart';
import 'package:citas_firebase/widgets/my_drawer.dart';
import 'package:citas_firebase/widgets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/generate_code.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final user = FirebaseAuth.instance.currentUser;
  int code = generateCodeRandom();
  double? indicatorValue;
  Timer? timer;
  var dateDay = DateTime.now().day;
  var dateMonth = DateTime.now().month;
  var dateYear = DateTime.now().year;
  late String typeDoc = '';
  late String statusPay = '';
  late String date = '';
  late String time = '';
  late String dateAuxP = '';
  late AdmobInterstitial adIntersticial;

  late TextEditingController nameController;
  late TextEditingController documentController;
  late TextEditingController phoneController;
  late TextEditingController priceController;
  List<String> listaDeOpciones = ["CC", "TI", "Contraseña"];
  List<String> listStatusPayMeet = ['No', 'Si'];

  //Retorna un TimeOfDay y lo formatea segun el contexto en el que se encuentre.
  String timeP(BuildContext context) {
    return TimeOfDay.now().format(context);
  }

  updateSeconds() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          indicatorValue = DateTime.now().second / 60;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    documentController = TextEditingController();
    phoneController = TextEditingController();
    priceController = TextEditingController();
    indicatorValue = DateTime.now().second / 60;

    updateSeconds();

    adIntersticial = AdmobInterstitial(
      adUnitId: adInterstitialAndroidId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          adIntersticial.load();
        }
      },
    );
    adIntersticial.load();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool widthScreen = MediaQuery.of(context).size.width < 680;
    String dateP = "$dateDay/$dateMonth/$dateYear";
    setState(() {
      dateAuxP = dateP;
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 251, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(48, 204, 176, 1),
        title: const Text('Bienvenido'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: widthScreen
              ? const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
              : const EdgeInsets.symmetric(horizontal: 130, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Datos de Usuario",
                style: GoogleFonts.lexendDeca(fontSize: 35),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Nombre Completo",
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: widthScreen
                        ? MediaQuery.of(context).size.width * 0.40
                        : MediaQuery.of(context).size.width * 0.30,
                    child: DropdownButtonFormField(
                      hint: const Text("Documento"),
                      decoration: InputDecoration(
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
                      items: listaDeOpciones.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? value) {
                        typeDoc = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: widthScreen
                        ? MediaQuery.of(context).size.width * 0.40
                        : MediaQuery.of(context).size.width * 0.30,
                    child: TextFormField(
                      controller: documentController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 17),
                        labelText: "Num. Documento",
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widthScreen
                        ? MediaQuery.of(context).size.width * 0.40
                        : MediaQuery.of(context).size.width * 0.30,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 17),
                        labelText: "Celular",
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
                      width: widthScreen
                          ? MediaQuery.of(context).size.width * 0.40
                          : MediaQuery.of(context).size.width * 0.30,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 253, 251, 255),
                        borderRadius: BorderRadius.circular(7),
                        border: const Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(135, 158, 237, 1)),
                          top: BorderSide(
                              color: Color.fromRGBO(135, 158, 237, 1)),
                          right: BorderSide(
                              color: Color.fromRGBO(135, 158, 237, 1)),
                          left: BorderSide(
                              color: Color.fromRGBO(135, 158, 237, 1)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          date.isEmpty ? 'Fecha Cita' : date,
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? timePicked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (timePicked != null) {
                        time =
                            // ignore: use_build_context_synchronously
                            timePicked.format(context).toString();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 253, 251, 255),
                        borderRadius: BorderRadius.circular(7),
                        border: const Border(
                          bottom:
                              BorderSide(color: Color.fromRGBO(135, 158, 237, 1)),
                          top: BorderSide(color: Color.fromRGBO(135, 158, 237, 1)),
                          right:
                              BorderSide(color: Color.fromRGBO(135, 158, 237, 1)),
                          left: BorderSide(color: Color.fromRGBO(135, 158, 237, 1)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          time.isEmpty ? 'Hora Cita' : time,
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: widthScreen
                        ? MediaQuery.of(context).size.width * 0.40
                        : MediaQuery.of(context).size.width * 0.30,
                    child: DropdownButtonFormField(
                      hint: const Text("¿Pagado?"),
                      decoration: InputDecoration(
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
                      items: listStatusPayMeet.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? value) {
                        statusPay = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Datos de Factura",
                style: GoogleFonts.lexendDeca(fontSize: 35),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  const Text(
                    "Codigo de Cita",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        code.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const Text(
                    "Fecha de Agendamiento",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        dateP,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const Text(
                    "Hora de Agendamiento",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        timeP(context),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const Text(
                    "Valor a Pagar",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 17),
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
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              //--------------------------HERE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (counterAd == 2) {
                          LaunchAdToFiveTouch();
                        } else {
                          submitAddEvent();
                        }
                      },
                      child: Container(
                        height: 60,
                        width: widthScreen
                            ? MediaQuery.of(context).size.width * 0.40
                            : MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Agendar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        cancelMeet(context);
                      },
                      child: Container(
                        height: 60,
                        width: widthScreen
                            ? MediaQuery.of(context).size.width * 0.40
                            : MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(157, 255, 237, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BannerAd(),
    );
  }

  bool validateCamps() {
    if (nameController.text.isEmpty ||
        typeDoc == '' ||
        documentController.text.isEmpty ||
        phoneController.text.isEmpty ||
        date == '' ||
        time == '' ||
        priceController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadData() async {
    var dataWasUpload = await saveToDatabase(
      nameController.text,
      typeDoc,
      documentController.text,
      phoneController.text,
      date,
      time,
      int.parse(priceController.text),
      code,
      dateAuxP,
      timeP(context),
      statusPay,
    );

    if (dataWasUpload) {
      return true;
    } else {
      return false;
    }
  }

  void submitAddEvent() async {
    if(await validateConnection()){
      if (validateCamps() == false) {
      Future.delayed(const Duration(milliseconds: 200)).then(
        (value) {
          launchSnackBar(
            context,
            'Cita añadida correctamente',
            const Color.fromARGB(255, 25, 97, 62),
          );
        },
      );

      Future.delayed(const Duration(seconds: 5)).then(
        (value) {
          clearCamps();
        },
      );
    } else {
      launchSnackBar(context, 'Hay Campos Vacios', Colors.brown);
    }
    }else{
      launchSnackBar(context, 'Sin conexión a internet', Colors.brown);
    }
    
  }

  Future<void> LaunchAdToFiveTouch() async {
    final isLoaded = await adIntersticial.isLoaded;
    if (isLoaded ?? false) {
      adIntersticial.show();
      setState(() {
        counterAd = 0;
      });
    } else {
      print('Ad Loading...');
    }
  }

  void clearCamps() async {
    var isCampsUpload = await uploadData();
    if (isCampsUpload) {
      setState(() {
        nameController.clear();
        typeDoc = '';
        documentController.clear();
        phoneController.clear();
        date = '';
        time = '';
        priceController.clear();
        code = generateCodeRandom();
        counterAd++;
      });
    } else {
      clearCamps();
    }
  }

  void cancelMeet(BuildContext context) {
    launchSnackBar(
        context, "Cita Cancelada", const Color.fromARGB(255, 134, 53, 42));

    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        nameController.clear();
        documentController.clear();
        phoneController.clear();
        priceController.clear();
        date = '';
        time = '';
        code = generateCodeRandom();
      },
    );
  }
}
