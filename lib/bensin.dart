import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'components.dart';
import 'constant.dart';

class Bensin extends StatefulWidget {
  bool isChange;
  dynamic bluetoothData;
  Function? bluetoothCallback;
  Bensin(
      {required this.isChange,
      this.bluetoothData,
      this.bluetoothCallback,
      super.key});

  @override
  State<Bensin> createState() => _BensinState();
}

class _BensinState extends State<Bensin> {
  final _formKeyBensin = GlobalKey<FormState>();
  final queue = TextEditingController();
  final noTrans = TextEditingController();
  final biosolar = TextEditingController();
  final pertalite = TextEditingController();
  final spbuName = TextEditingController();
  final spbuAddress = TextEditingController();
  final spbuPhone = TextEditingController();
  final shift = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();
  final pulauPompa = TextEditingController();
  final productName = TextEditingController();
  final price = TextEditingController();
  final volume = TextEditingController();
  Map valueForm = {};
  double sum = 0;
  bool isPrint = false;

  int initQueue = 3412213;

  DateTime now = DateTime.now();

  String? monthString;
  String? yearString;

  void _countTotalPrice() {
    String replaceString = replacedString(valueForm["price"]);
    String replaceComma = replacedComma(replaceString);
    String replaceCommaWithDots = replacedCommaWithDots(replaceComma);
    var volume = valueForm["volume"] == null ? "0.0" : valueForm["volume"];
    var totalHarga = valueForm["price"] == null ? "0.0" : replaceCommaWithDots;
    sum = double.parse(volume) * double.parse(totalHarga);
    setState(() {});
  }

  void initState() {
    super.initState();
    monthString = DateFormat.MMMM().format(now).toString();
    yearString = now.year.toString();
    // _countTotalPrice();
  }

  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Bensin oldWidget) {
    if (oldWidget.bluetoothData == this.widget.bluetoothData) return;
    widget.bluetoothCallback!(widget.bluetoothData);
    super.didUpdateWidget(oldWidget);
  }

  var maskPhone = new MaskTextInputFormatter(
      mask: '###-#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskDate = new MaskTextInputFormatter(
      mask: '##-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskTime = new MaskTextInputFormatter(
      mask: '##:##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var floating4Number = new MaskTextInputFormatter(
      mask: '##.##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var digitOnly = FilteringTextInputFormatter.digitsOnly;

  var maskPrice = CurrencyTextInputFormatter(
    symbol: 'Rp ',
    enableNegative: true,
  );

  // print(maskPrice.getUnformattedValue('test'));

  Widget FormBensin() => Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No Antrian'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan No Antrian';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[digitOnly],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: queue,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No Trans'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Nama Spbu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[digitOnly],
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: noTrans,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga Biosolar'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan niali biosolar';
                    }
                    return null;
                  },
                  inputFormatters: [
                    maskPrice,
                  ],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: biosolar,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga Pertalite'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan nilai pertalite';
                    }
                    return null;
                  },
                  inputFormatters: [
                    maskPrice,
                  ],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: pertalite,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Spbu'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Nama Spbu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: spbuName,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alamat Spbu'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Alamat Spbu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: spbuAddress,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No Telp Spbu*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan No Telp Spbu*';
                    }
                    return null;
                  },
                  inputFormatters: [maskPhone],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: spbuPhone,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shift*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Shift';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: shift,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tanggal*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Tanggal';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[maskDate],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: date,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jam*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Jam';
                    }
                    return null;
                  },
                  inputFormatters: [maskTime],
                  decoration: InputDecoration(
                      hoverColor: Colors.grey, border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: time,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pulau/Pompa'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: pulauPompa,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Produk*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Volume';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: productName,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga*'),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Masukkan harga';
                      }
                      return null;
                    },
                    inputFormatters: [
                      maskPrice,
                    ],
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(
                        color: widget.isChange ? Colors.white : Colors.black),
                    controller: price,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Volume*'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan volume';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter.allow()
                    floating4Number
                  ],
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: volume,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      );
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // if (widget.bluetoothData != null) {
    //   widget.bluetoothCallback!(widget.bluetoothData);
    // }
    return Container(
        height: height,
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                valueForm = await showDialog<dynamic>(
                  barrierDismissible: false,
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) => Dialog.fullscreen(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKeyBensin,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FormBensin(),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Map<String, dynamic> formData = {
                                        'price': '0.0',
                                        'volume': '0.0'
                                      };
                                      Navigator.pop(context, formData);
                                    },
                                    child: const Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (_formKeyBensin.currentState!
                                          .validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Processing Data')),
                                        );
                                        Map<String, dynamic> formData = {
                                          'queue': queue.text.toUpperCase(),
                                          'noTrans': noTrans.text.toUpperCase(),
                                          'biosolar':
                                              biosolar.text.toUpperCase(),
                                          'pertalite':
                                              pertalite.text.toUpperCase(),
                                          'spbuName':
                                              spbuName.text.toUpperCase(),
                                          'spbuAddress':
                                              spbuAddress.text.toUpperCase(),
                                          'spbuPhone':
                                              spbuPhone.text.toUpperCase(),
                                          'shift': shift.text.toUpperCase(),
                                          'date': date.text.toUpperCase(),
                                          'time': time.text.toUpperCase(),
                                          'pulauPompa':
                                              pulauPompa.text.toUpperCase(),
                                          'productName':
                                              productName.text.toUpperCase(),
                                          'price': price.text.toUpperCase(),
                                          'volume': volume.text.toUpperCase()
                                        };

                                        isPrint = true;
                                        setState(() {});

                                        Navigator.pop(context, formData);
                                      }
                                    },
                                    child: const Text('Send'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                // print(valueForm);
                _countTotalPrice();
                setState(() {});
              },
              child: const Text('Buat Nilai'),
            ),
            Container(
              child: SizedBox(
                width: 200,
                child: widget.isChange
                    ? Image.asset(
                        'assets/logo/pertamina-white.png',
                      )
                    : Image.asset(
                        'assets/logo/pertamina.png',
                      ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text(
                        '${valueForm["queue"] == null ? '-' : valueForm["queue"]}'),
                  ),
                  Container(
                    child: Text(
                        '${valueForm["spbuName"] == null ? '-' : valueForm["spbuName"]}'),
                  ),
                  Container(
                    child: Text(
                        '${valueForm["spbuAddress"] == null ? '-' : valueForm["spbuAddress"]}'),
                  ),
                  Container(
                    child: Text(
                        'Telp ${valueForm["spbuPhone"] == null ? '-' : valueForm["spbuPhone"]}'),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .1555,
                          child: Text('Shift'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 21),
                        Container(
                          child: Text(
                              '${valueForm["shift"] == null ? '-' : valueForm["shift"]}'),
                        ),
                        SizedBox(width: 21),
                        Container(
                          child: Text('No. Trans'),
                        ),
                        SizedBox(width: 21),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Text(
                              '${valueForm["noTrans"] == null ? '-' : valueForm["noTrans"]}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .1555,
                          child: Text('Waktu'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              '${valueForm["date"] == null ? '-' : valueForm["date"]}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              '${valueForm["volume"] == null ? '-' : valueForm["time"]}'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: width * .7,
                      child: MySeparator(
                          height: 1,
                          color:
                              widget.isChange ? Colors.white : Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Pulau/Pompa'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              '${valueForm["pulauPompa"] == null ? '-' : valueForm["pulauPompa"]}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Nama Produk'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              '${valueForm["productName"] == null ? '-' : valueForm["productName"]}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Harga/Liter'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              'Rp ${valueForm["price"] == null ? '-' : replacedString(valueForm["price"].toString())}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Volume'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              '(L) ${valueForm["volume"] == null ? '-' : valueForm["volume"]}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Total Harga'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text(
                              'Rp ${sum == 0 ? '-' : mappingMoney(sum.toString())}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .2555,
                          child: Text('Operator'),
                        ),
                        Container(
                          child: Text(':'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: Text('PENGAWAS'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .7,
                    child: Container(
                      child: Text('CASH'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: width * .7,
                    child: Container(
                      child: Text(
                          '${sum == 0 ? '-' : mappingMoney(sum.toString().padLeft(2, "0"))}'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: width * .7,
                      child: MySeparator(
                          height: 1,
                          color:
                              widget.isChange ? Colors.white : Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                        'SUBSIDI BULAN ${monthString!.toUpperCase()} ${yearString!.toUpperCase()}'),
                  ),
                  Container(
                    child: Text(
                        'BIOSOLAR Rp ${valueForm["biosolar"] == null ? '-' : mappingMoney(removeMoneyComma(valueForm["biosolar"]))}/LITER DAN'),
                  ),
                  Container(
                    child: Text(
                        'PERTALITE Rp ${valueForm["pertalite"] == null ? '-' : mappingMoney(removeMoneyComma(valueForm["pertalite"]))}/LITER'),
                  ),
                  Container(
                    child: Text('MARI GUNAKAN PERTAMAX SERIES DAN'),
                  ),
                  Container(
                    child: Text('DEXSERIES,'),
                  ),
                  Container(
                    child: Text('SUBSIDI HANYA UNTUK YANG BERHAK'),
                  ),
                  Container(
                    child: Text('MENERIMANYA. * TERIMA KASIH'),
                  ),
                  SizedBox(height: 5),
                  widget.bluetoothData != null && isPrint
                      ? TextButton(
                          child: Text('PRINT'),
                          onPressed: () async {
                            Map<String, dynamic> config = Map();

                            List<LineText> list = [];

                            ByteData data = await rootBundle
                                .load("assets/logo/pertamina.jpg");
                            List<int> imageBytes = data.buffer.asUint8List(
                                data.offsetInBytes, data.lengthInBytes);
                            String base64Image = base64Encode(imageBytes);
                            list.add(LineText(
                                type: LineText.TYPE_IMAGE,
                                content: base64Image,
                                width: 300,
                                height: 90,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            // list.add(LineText(linefeed: 1));

                            // list.add(LineText(
                            //     type: LineText.TYPE_TEXT,
                            //     content: 'PERTAMINA',
                            //     weight: 1,
                            //     align: LineText.ALIGN_CENTER,
                            //     fontZoom: 1,
                            //     linefeed: 1));
                            // list.add(LineText(linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["queue"]}',
                                weight: 0,
                                fontZoom: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["spbuName"]}',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["spbuAddress"]}',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'TELP. ${valueForm["spbuPhone"]}',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            //*** no shift */

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Shift',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: ':',
                                align: LineText.ALIGN_LEFT,
                                x: 100,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["shift"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 120,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'No.Trans',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: ':',
                                align: LineText.ALIGN_LEFT,
                                x: 260,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["noTrans"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 280,
                                relativeX: 0,
                                linefeed: 1));

                            /*** end no shift */

                            /*** time */
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Waktu',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: ':',
                                align: LineText.ALIGN_LEFT,
                                x: 100,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["date"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 120,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["time"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 250,
                                relativeX: 0,
                                linefeed: 1));

                            /*** end time */

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '.................................',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Pulau/Pompa:',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["pulauPompa"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Nama Produk:',
                                align: LineText.ALIGN_LEFT,
                                x: 500,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["productName"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Harga/Liter:',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '${valueForm["price"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Volume',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: ':',
                                align: LineText.ALIGN_LEFT,
                                x: 132,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '(L) ${valueForm["volume"]}',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Total Harga:',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Rp. ${mappingMoney(sum.toString())}',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Operator',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: ':',
                                align: LineText.ALIGN_LEFT,
                                x: 132,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'PENGAWAS',
                                align: LineText.ALIGN_LEFT,
                                x: 150,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'CASH',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    '${mappingMoney(sum.toString().padLeft(2, "0"))}',
                                align: LineText.ALIGN_LEFT,
                                x: 250,
                                relativeX: 0,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '.................................',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    'SUBSIDI BULAN ${monthString!.toUpperCase()} ${yearString!.toUpperCase()}',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    'BIOSOLAR RP. ${mappingMoney(removeMoneyComma(valueForm["biosolar"]))}/LITER DAN',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    'PERTALITE RP ${mappingMoney(removeMoneyComma(valueForm["pertalite"]))}/LITER',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'MARI GUNAKAN PERTAMAX SERIES DAN',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'DEX SERIES,',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'SUBSIDI HANYA UNTUK YANG BERHAK',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'MENERIMA.* TERIMAKASIH',
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));

                            // ByteData data = await rootBundle
                            //     .load("assets/logo/pertamina.png");
                            // List<int> imageBytes = data.buffer.asUint8List(
                            //     data.offsetInBytes, data.lengthInBytes);
                            // String base64Image = base64Encode(imageBytes);
                            // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

                            await widget.bluetoothData['bluetoothPrint']
                                .printReceipt(config, list);
                          },
                        )
                      : Container()
                ],
              ),
            )
          ],
        ));
  }
}
