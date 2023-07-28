import 'dart:math' as mt;

int generateCodeRandom() {
  return mt.Random().nextInt(9999999) + 1000000;
}
