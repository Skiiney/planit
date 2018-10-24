import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'initial.dart';

final routes = {
  '/init':           (BuildContext context) => new Initial(),
  '/login':         (BuildContext context) => new Login(),
  '/home':         (BuildContext context) => new Home(),
  '/' :           (BuildContext context) => new Initial(),
};