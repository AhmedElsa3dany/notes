import 'package:flutter/material.dart';
import 'package:note/features/folders/logic/folders_provider.dart';
import 'package:provider/provider.dart';

class FoldersListView extends StatelessWidget {
  const FoldersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoldersProvider>(
      builder: (context, foldersProvider, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              // هنا ممكن تفتح صفحة إضافة/تعديل نوت وتعمل refresh بعد الرجوع
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         AddNoteScreen(noteModel: foldersProvider.notes[index], index: index),
              //   ),
              // );
              // if (result != null && result) {
              //   foldersProvider.getAllNotes();
              // }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(foldersProvider.folders[index].color),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      foldersProvider.folders[index].label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      foldersProvider.deleteFolder(index);
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: foldersProvider.folders.length,
        );
      },
    );
  }
}
