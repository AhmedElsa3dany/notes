import 'package:flutter/material.dart';
import 'package:note/features/notes/logic/notes_provider.dart';
import 'package:note/features/notes/ui/notes_screen.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => NotesProvider()..getAllNotes(),
            child: NotesScreen(),
          ),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notes_outlined, color: Colors.blue, size: 100),
          Text(
            "Note App",
            style: TextStyle(
              fontSize: 40,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ));
  }
}
