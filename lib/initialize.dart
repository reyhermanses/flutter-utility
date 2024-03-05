import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utility/bensin.dart';
import 'package:utility/constant.dart';
import 'package:utility/hotel.dart';
import 'package:utility/print.dart';
import 'package:utility/transportasi.dart';

class Initialize extends StatefulWidget {
  const Initialize({super.key});

  @override
  State<Initialize> createState() => _InitializeState();
}

enum selected { HOME, HOTEL, BENSIN, TRANSPORT }

class _InitializeState extends State<Initialize> {
  ThemeData _themeData = ThemeData(brightness: Brightness.light);
  dynamic bluetoothData;
  bool _isChange = false;
  selected _selected = selected.HOME;
  dynamic routes;

  void _changeTheme() {
    _isChange = !_isChange;
    setState(() {});
  }

  void _setRoutes(route) {
    routes = route;
    setState(() {});
  }

  void initState() {
    super.initState();
    routes = PrintBluetoothOi(
      bluetoothCallback: (val) {
        bluetoothData = val;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isChange
          ? ThemeData(
              useMaterial3: true,

              // Define the default brightness and colors.
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                // TRY THIS: Change to "Brightness.light"
                //           and see that all colors change
                //           to better contrast a light background.
                brightness: Brightness.dark,
              ),

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                displayLarge: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
                // TRY THIS: Change one of the GoogleFonts
                //           to "lato", "poppins", or "lora".
                //           The title uses "titleLarge"
                //           and the middle text uses "bodyMedium".
                titleLarge: GoogleFonts.oswald(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
                bodyMedium: GoogleFonts.merriweather(),
                displaySmall: GoogleFonts.pacifico(),
              ),
            )
          : ThemeData(
              useMaterial3: true,

              // iconTheme: IconTheme(data: data, child: child),

              // Define the default brightness and colors.
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                // TRY THIS: Change to "Brightness.light"
                //           and see that all colors change
                //           to better contrast a light background.
                brightness: Brightness.light,
              ),

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                displayLarge: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
                // TRY THIS: Change one of the GoogleFonts
                //           to "lato", "poppins", or "lora".
                //           The title uses "titleLarge"
                //           and the middle text uses "bodyMedium".
                titleLarge: GoogleFonts.oswald(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
                bodyMedium: GoogleFonts.merriweather(),
                displaySmall: GoogleFonts.pacifico(),
              ),
            ),
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Utilitiy',
            ),
            actions: <Widget>[
              IconButton(
                icon: IconTheme(
                  data: new IconThemeData(
                      color: _isChange
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary),
                  child: _isChange
                      ? Icon(Icons.wb_sunny_outlined)
                      : Icon(Icons.mode_night_outlined),
                ),
                onPressed: () => _changeTheme(),
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .9,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      top: 25,
                      left: 15,
                      right: 15,
                      child: Container(
                        padding: EdgeInsets.all(padding_all),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: _isChange
                              ? Color.fromARGB(255, 85, 83, 83)
                              : Theme.of(context).colorScheme.background,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                _setRoutes(PrintBluetoothOi(
                                  bluetoothCallback: (val) {
                                    bluetoothData = val;
                                  },
                                ));
                              },
                              child: Text('HOME'),
                            ),
                            TextButton(
                              onPressed: () {
                                _setRoutes(Hotel());
                              },
                              child: Text('HOTEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                print(_isChange);
                                _setRoutes(Bensin(
                                  isChange: _isChange,
                                  bluetoothData: bluetoothData,
                                  bluetoothCallback: (val) {
                                    bluetoothData = val;
                                    setState(() {});
                                  },
                                ));
                              },
                              child: Text('BENSIN'),
                            ),
                            TextButton(
                              onPressed: () async {
                                _setRoutes(Transportasi(
                                  isChange: _isChange,
                                  bluetoothData: bluetoothData,
                                  bluetoothCallback: (val) {
                                    bluetoothData = val;
                                    setState(() {});
                                  },
                                ));
                              },
                              child: Text('TRANSPORTASI'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: routes),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
