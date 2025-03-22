import 'package:flutter/material.dart';
import 'app/injections/injection_container.dart';
import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupProviders(); 
  runApp(const AppWidget());
}