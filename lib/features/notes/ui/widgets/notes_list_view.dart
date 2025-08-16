import 'package:flutter/material.dart';
import 'package:note/features/notes/logic/notes_provider.dart';
import 'package:note/features/notes/ui/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => NoteTile(index: index),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: notesProvider.notes.length,
        );
      },
    );
  }
}
