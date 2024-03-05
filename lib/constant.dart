import 'package:intl/intl.dart';

double padding_vertical = 15;
double padding_horizontal = 15;
double padding_all = 15;

NumberFormat currencyFormatter =
    NumberFormat.currency(symbol: 'Rp ', decimalDigits: 0);

String unformatCurrency(String formattedCurrency) {
  String replaceDots = replacedDots(formattedCurrency);

  String replaceString = replacedString(replaceDots);

  String replaceCommaWithDots = replacedCommaWithDots(replaceString);

  return replaceCommaWithDots.toString();
}

String removeMoneyComma(value) {
  String replaceString = replacedString(value);

  String replaceComma = replacedComma(replaceString);

  String replaceCommaWithDots = replacedCommaWithDots(replaceComma);

  return replaceCommaWithDots;
}

String mappingMoney(String value) {
  String mapMoney = '0';

  // String price = '25001230.34';

  List splitDots = splittedDots(value);

  String removeDots = removedDots(value);

  String replaceDots = replacedDots(removeDots);

  switch (replaceDots.length) {
    case 1:
      {
        mapMoney = value;
      }
      break;
    case 2:
      {
        mapMoney = value;
      }
      break;
    case 3:
      {
        mapMoney = value;
      }
      break;
    case 4:
      {
        List<String> juataan = [];
        for (int i = 0; i < replaceDots.length; i++) {
//         print(replaceDots[i]);
          if (i == 0) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else {
            juataan.add(replaceDots[i]);
          }
        }
        mapMoney = juataan.join('');
      }
      break;
    case 5:
      {
        List<String> juataan = [];
        for (int i = 0; i < replaceDots.length; i++) {
//         print(replaceDots[i]);
          if (i == 1) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else {
            juataan.add(replaceDots[i]);
          }
        }
        mapMoney = juataan.join('');
      }
      break;
    case 6:
      {
        List<String> juataan = [];
        for (int i = 0; i < replaceDots.length; i++) {
          if (i == 2) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else {
            juataan.add(replaceDots[i]);
          }
        }
        mapMoney = juataan.join('');
      }
      break;
    case 7:
      {
        double round = replaceDots.length / 2;
        List<String> juataan = [];
        for (int i = 0; i < replaceDots.length; i++) {
          if (i == 0) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else if (i == round.round() - 1) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else {
            juataan.add(replaceDots[i]);
          }
        }
        mapMoney = juataan.join('');
      }
    case 8:
      {
        double round = replaceDots.length / 2;
        List<String> juataan = [];
        for (int i = 0; i < replaceDots.length; i++) {
          if (i == 1) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else if (i == round.round()) {
            juataan.add(replaceDots[i]);
            juataan.add(',');
          } else {
            juataan.add(replaceDots[i]);
          }
        }
        mapMoney = juataan.join('');
      }
  }

  return mapMoney + '.' + splitDots[1];
}

String removedCommas(val) {
  var removed = val.split(',');
  return removed[0].toString();
}

String removedDots(val) {
  var removed = val.split('.');
  return removed[0].toString();
}

String replacedDots(val) {
  var replaced = val.replaceAll(".", "");
  return replaced;
}

String replacedComma(val) {
  var replaced = val.replaceAll(",", "");
  return replaced;
}

String replacedString(val) {
  var replaced = val.replaceAll("RP ", "");
  return replaced;
}

String splittedCommas(val) {
  var split = val.split(",");
  return split;
}

String replacedCommaWithDots(val) {
  var replaced = val.replaceAll(",", ".");
  return replaced;
}

List splittedDots(val) {
  var split = val.split(".");
  return split;
}
