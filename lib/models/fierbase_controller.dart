import 'package:firebase_database/firebase_database.dart';

//Guardar el post en Firebase Database
Future<bool> saveToDatabase(String name, String typeDoc, String document,
    String phone, String date, String hour, int price, int idMeet, String firstDate, String firstHour, String statusPay) async {
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
    'first_hour': firstHour,
    'status_pay': statusPay
  };

  try {
    ref.child("Posts").push().set(data);
    return true;
  } catch (e) {
    e.toString();
    return false;
  }
}

void changeStatusPay(var query ,String key) {
    DatabaseReference meetRef = query.child(key);
    meetRef.update({'status_pay': 'Si'}).then((_) {
      print("Estado de pago actualizado correctamente");
    }).catchError((error) {
      print("Error al actualizar el estado de pago: $error");
    });
  }

