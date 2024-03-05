import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'components.dart';

class Transportasi extends StatefulWidget {
  bool isChange;
  dynamic bluetoothData;
  Function? bluetoothCallback;
  Transportasi(
      {required this.isChange,
      this.bluetoothData,
      this.bluetoothCallback,
      super.key});

  @override
  State<Transportasi> createState() => _TransportasiState();
}

class _TransportasiState extends State<Transportasi> {
  final _formTransport = GlobalKey<FormState>();
  final _taxiNo = TextEditingController();
  final _date = TextEditingController();
  final _time = TextEditingController();
  final _distance = TextEditingController();
  final _textFare = TextEditingController();
  bool isPrint = false;
  Map valueForm = {};

  var digitOnly = FilteringTextInputFormatter.digitsOnly;
  var maskDate = new MaskTextInputFormatter(
      mask: '##-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var floating4Number = new MaskTextInputFormatter(
      mask: '##.##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskPrice = CurrencyTextInputFormatter(
    symbol: 'Rp ',
    enableNegative: true,
  );

  Widget formTransport() => Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No Taxi'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan No Taxi';
                    }
                    return null;
                  },
                  // keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[digitOnly],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: _taxiNo,
                ),
              ),
              SizedBox(height: 10),
              Text('Tanggal'),
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[maskDate],
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'DD-MM-YYYY'),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: _date,
                ),
              ),
              SizedBox(height: 10),
              Text('Waktu'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Waktu';
                    }
                    return null;
                  },
                  // keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[digitOnly],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: _time,
                ),
              ),
              SizedBox(height: 10),
              Text('Jarak (Km)'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Jarak';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[floating4Number],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: _distance,
                ),
              ),
              SizedBox(height: 10),
              Text('Harga'),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Masukkan Harga';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    maskPrice,
                  ],
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                      color: widget.isChange ? Colors.white : Colors.black),
                  controller: _textFare,
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
    return Container(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: SingleChildScrollView(
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
                                  key: _formTransport,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      formTransport(),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              if (_formTransport.currentState!
                                                  .validate()) {
                                                // If the form is valid, display a snackbar. In the real world,
                                                // you'd often call a server or save the information in a database.
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Processing Data')),
                                                );
                                                Map<String, dynamic> formData =
                                                    {
                                                  'taxiNo': _taxiNo.text
                                                      .toUpperCase(),
                                                  'date':
                                                      _date.text.toUpperCase(),
                                                  'time':
                                                      _time.text.toUpperCase(),
                                                  'distance': _distance.text
                                                      .toUpperCase(),
                                                  'textFare': _textFare.text
                                                      .toUpperCase(),
                                                };

                                                isPrint = true;
                                                setState(() {});

                                                Navigator.pop(
                                                    context, formData);
                                              }
                                            },
                                            child: const Text('Send'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                },
                child: Text('Buat Nilai'),
              ),
              Container(
                  width: 200, child: Image.asset('assets/logo/bluebird.png')),
              SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .2,
                            child: Text('Taxi No.'),
                          ),
                          Container(
                            child: Text(':'),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${valueForm['taxiNo'] == null ? '-' : valueForm['taxiNo']}'),
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
                            width: width * .2,
                            child: Text('Date'),
                          ),
                          Container(
                            child: Text(':'),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${valueForm['date'] == null ? '-' : valueForm['date']}'),
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
                            width: width * .2,
                            child: Text('Time'),
                          ),
                          Container(
                            child: Text(':'),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${valueForm['time'] == null ? '-' : valueForm['time']}'),
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
                            width: width * .2,
                            child: Text('Distance'),
                          ),
                          Container(
                            child: Text(':'),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${valueForm['distance'] == null ? '-' : valueForm['distance']} Km'),
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
                            width: width * .2,
                            child: Text('Text Fare'),
                          ),
                          Container(
                            child: Text(':'),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${valueForm['textFare'] == null ? '-' : valueForm['textFare']}'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              widget.bluetoothData != null && isPrint
                  ? TextButton(
                      child: Text('PRINT'),
                      onPressed: () async {
                        Map<String, dynamic> config = Map();

                        List<LineText> list = [];

                        ByteData data =
                            await rootBundle.load("assets/logo/bluebird.jpg");
                        List<int> imageBytes = data.buffer.asUint8List(
                            data.offsetInBytes, data.lengthInBytes);
                        String base64Image = base64Encode(imageBytes);
                        list.add(LineText(
                            type: LineText.TYPE_IMAGE,
                            content: base64Image,
                            width: 300,
                            height: 76,
                            align: LineText.ALIGN_CENTER,
                            linefeed: 1));

                        list.add(LineText(linefeed: 1));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: 'Taxi No',
                            align: LineText.ALIGN_LEFT,
                            x: 0,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: ':',
                            align: LineText.ALIGN_LEFT,
                            x: 124,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: '${valueForm["taxiNo"]}',
                            align: LineText.ALIGN_LEFT,
                            x: 200,
                            relativeX: 0,
                            linefeed: 1));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: 'Date',
                            align: LineText.ALIGN_LEFT,
                            x: 0,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: ':',
                            align: LineText.ALIGN_LEFT,
                            x: 124,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: '${valueForm["date"]}',
                            align: LineText.ALIGN_LEFT,
                            x: 260,
                            relativeX: 0,
                            linefeed: 1));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: 'Time',
                            align: LineText.ALIGN_LEFT,
                            x: 0,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: ':',
                            align: LineText.ALIGN_LEFT,
                            x: 124,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: '${valueForm["time"]}',
                            align: LineText.ALIGN_LEFT,
                            x: 225,
                            relativeX: 0,
                            linefeed: 1));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: 'Distance',
                            align: LineText.ALIGN_LEFT,
                            x: 0,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: ':',
                            align: LineText.ALIGN_LEFT,
                            x: 119,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: '${valueForm["distance"]} Km',
                            align: LineText.ALIGN_RIGHT,
                            x: 320,
                            relativeX: 0,
                            linefeed: 1));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: 'Text Fare',
                            align: LineText.ALIGN_LEFT,
                            x: 0,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content: ': RP',
                            align: LineText.ALIGN_LEFT,
                            x: 120,
                            relativeX: 0,
                            linefeed: 0));

                        list.add(LineText(
                            type: LineText.TYPE_TEXT,
                            content:
                                '${valueForm["textFare"].replaceAll('RP', '')}',
                            align: LineText.ALIGN_RIGHT,
                            x: 250,
                            relativeX: 0,
                            linefeed: 0));

                        await widget.bluetoothData['bluetoothPrint']
                            .printReceipt(config, list);
                      },
                    )
                  : Container()
            ],
          ),
        ));
  }
}
