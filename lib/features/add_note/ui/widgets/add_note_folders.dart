import 'package:flutter/material.dart';
import 'package:note/features/add_note/logic/add_note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteFolders extends StatelessWidget {
  const AddNoteFolders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNoteProvider>(
      builder: (context, addNoteProvider, child) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              addNoteProvider.changeFolder(addNoteProvider.folders[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(addNoteProvider.folders[index].color),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      addNoteProvider.folders[index].label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (addNoteProvider.selectedFolder ==
                      addNoteProvider.folders[index])
                    const Icon(Icons.check, color: Colors.white),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: addNoteProvider.folders.length,
        );
      },
    );
  }
}
