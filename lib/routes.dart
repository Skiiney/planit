import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

final routes = {
  '/login':         (BuildContext context) => new Login(),
  '/home':         (BuildContext context) => new Home(),
  '/' :           (BuildContext context) => new Login(),
};