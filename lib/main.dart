// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'Localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(color: Colors.lightBlue, home: LocalisationPage());
  }
}
