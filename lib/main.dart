import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribit_bank/MyApp.dart';

void main() {
  runApp(Provider(create: (_) {}, child: const MyApp()));
}
