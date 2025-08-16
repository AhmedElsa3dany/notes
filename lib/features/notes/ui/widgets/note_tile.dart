import 'package:flutter/material.dart';
import 'package:note/features/add_note/ui/add_note_screen.dart';
import 'package:note/features/notes/logic/notes_provider.dart';

import 'package:provider/provider.dart';

class NoteTile extends StatelessWidget {
  final int index;
  const NoteTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NotesProvider>();
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddNoteScreen(noteModel: provider.notes[index], index: index),
          ),
        );
        if (result != null && result) {
          provider.getAllNotes();
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(provider.notes[index].color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Checkbox(
              value: provider.notes[index].isCompleted,
              onChanged: (value) {
                provider.toggleNoteCompletion(index);
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          provider.notes[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        provider.notes[index].createdAt.toString().split(
                              ' ',
                            )[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.notes[index].body,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          provider.deleteNote(index);
                        },
                        icon: Icon(Icons.delete, color: Colors.white),
                      ),
                    ],
                  ),
                  if (provider.notes[index].folder != null)
                    Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.folder,
                          color: Color(provider.notes[index].folder!.color),
                        ),
                        Text(
                          provider.notes[index].folder!.label,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
