import 'package:flutter/material.dart';
import 'package:treeview/features/home_page/presentation/pages/home_page.dart';

import 'features/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractian TreeView',
      theme: CustomTheme.customTheme,
      home: const HomePage(),
    );
  }
}
