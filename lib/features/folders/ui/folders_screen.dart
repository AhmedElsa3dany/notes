import 'package:flutter/material.dart';
import 'package:note/features/add_folder/ui/add_folder_screen.dart';
import 'package:note/features/folders/logic/folders_provider.dart';
import 'package:note/features/folders/ui/widgets/folders_list_view.dart';

import 'package:provider/provider.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoldersProvider()..getAllFolders(),
      child: Scaffold(
        appBar: AppBar(title: Text('Folders')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddFolderScreen()),
            );
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: FoldersListView(),
      ),
    );
  }
}
