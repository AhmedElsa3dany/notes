import 'package:flutter/material.dart';
import 'package:note/features/add_folder/logic/add_folder_provider.dart';
import 'package:provider/provider.dart';

class AddFolderForm extends StatelessWidget {
  const AddFolderForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddFolderProvider>(
      builder: (context, folderProvider, child) {
        return Form(
          key: folderProvider.formKey,
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                controller: folderProvider.labelController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Enter folder label',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid label';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              Row(
                children: List.generate(
                  folderProvider.colors.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: GestureDetector(
                      onTap: () {
                        folderProvider.changeColor(index);
                      },
                      child: CircleAvatar(
                        backgroundColor: folderProvider.colors[index],
                        child: folderProvider.selectedColor == index
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
