import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:note/core/widgets/custom_button.dart';
import 'package:note/features/add_note/logic/add_note_provider.dart';
import 'package:note/features/add_note/ui/widgets/add_note_folders.dart';
import 'package:note/features/notes/models/note_model.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  final NoteModel? noteModel;
  final int? index;
  const AddNoteScreen({super.key, this.noteModel, this.index});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNoteProvider()
        ..init(noteModel)
        ..getAllFolders(),
      child: Builder(
        builder: (context) {
          final provider = context.read<AddNoteProvider>();
          return Scaffold(
            appBar: AppBar(title: const Text('Add Note')),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: provider.formKey,
                        child: Column(
                          spacing: 16,
                          children: [
                            TextFormField(
                              controller: provider.titleController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 208, 80, 80),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                labelText: 'Enter note title',
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid title';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              controller: provider.bodyController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 208, 80, 80),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                labelText: 'Enter note description',
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid title';
                                }
                                return null;
                              },
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                            ),
                            Consumer<AddNoteProvider>(
                              builder: (context, addNoteProvider, child) {
                                return Row(
                                  children: List.generate(
                                    addNoteProvider.colors.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          addNoteProvider.changeColor(index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              addNoteProvider.colors[index],
                                          child:
                                              addNoteProvider.selectedColor ==
                                                      index
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const AddNoteFolders(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    text: noteModel != null ? 'Update Note' : 'Add Note',
                    onPressed: () {
                      if (noteModel != null) {
                        provider.updateNote(noteModel!, index!, context);
                      } else {
                        provider.addNote(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
