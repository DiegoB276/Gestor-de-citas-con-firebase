import 'package:firebase_database/firebase_database.dart';

//Guardar el post en Firebase Database
Future<bool> saveToDatabase(String name, String typeDoc, String document,
    int phone, String date, String hour, int price, int idMeet, String firstDate, String firstHour) async {
  /*
  Aquí vamos a guardar:
  - Nombre del evento,
  - Fecha del evento.
  - Hora del evento.
  - Lugar del evento.
  - Descripción del evento.
  - Imagen del evento.
   */

  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var data = {
    'id': idMeet,
    'name': name,
    'type_doc': typeDoc,
    'document': document,
    'phone': phone,
    'date': date,
    'hour': hour,
    'price': price,
    'first_date': firstDate,
    'first_hour': firstHour
  };

  try {
    ref.child("Posts").push().set(data);
    return true;
  } catch (e) {
    e.toString();
    return false;
  }
}

