import 'package:flutter/material.dart';

import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? noteToEdit;

  const AddNoteScreen({Key? key, this.noteToEdit}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _titleError = '';

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      _titleController = TextEditingController(text: widget.noteToEdit!.title);
      _descriptionController = TextEditingController(
        text: widget.noteToEdit!.description,
      );
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _titleError = 'Title is required';
      });
      return;
    }

    final note = Note(
      id: widget.noteToEdit?.id ?? DateTime.now().toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    Navigator.pop(context, note);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.noteToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: const OutlineInputBorder(),
                errorText: _titleError.isEmpty ? null : _titleError,
              ),
              onChanged: (_) {
                if (_titleError.isNotEmpty) {
                  setState(() {
                    _titleError = '';
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(isEditing ? 'Update Note' : 'Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
