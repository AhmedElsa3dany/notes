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
    final note = provider.notes[index];

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
      child: AspectRatio(
        aspectRatio: 480 / 200,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                // الشريط الملون على الشمال
                Container(
                  width: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(note.color),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                // محتوى النوت
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // السطر الأول: Checkbox + Title + Date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox (نفس الفنكشن)
                            SizedBox(
                              width: 36,
                              child: Center(
                                child: Checkbox(
                                  value: note.isCompleted,
                                  onChanged: (value) {
                                    provider.toggleNoteCompletion(index);
                                  },
                                ),
                              ),
                            ),

                            // العنوان
                            Expanded(
                              child: Text(
                                note.title,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // التاريخ
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                note.createdAt.toString().split(' ')[0],
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // النص الفرعي (body)
                        Expanded(
                          child: Text(
                            note.body,
                            style: TextStyle(color: Colors.grey[800]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // السطر الأخير: فولدر (لو موجود) + زر الحذف
                        Row(
                          children: [
                            if (note.folder != null) ...[
                              Icon(
                                Icons.folder,
                                color: Color(note.folder!.color),
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                note.folder!.label,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                            ] else
                              const Spacer(),

                            // زر الحذف بنفس الفنكشن
                            IconButton(
                              onPressed: () {
                                provider.deleteNote(index);
                              },
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
