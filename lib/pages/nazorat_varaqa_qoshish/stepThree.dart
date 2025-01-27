import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class StepThree extends StatefulWidget {
  final VoidCallback onPrevious;

  const StepThree({Key? key, required this.onPrevious}) : super(key: key);

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late quill.QuillController _quillController;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _quillController = quill.QuillController.basic();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveData() {
    final jsonData = _quillController.document.toDelta().toJson();
   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ma’lumot saqlandi: $jsonData')),
    );
    print('Сохранённые данные: $jsonData');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mazmuni haqida ma’lumot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Nazorat varaqasining nima haqida ekanligini to’liqroq yoritib berish uchun yoziladi.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  quill.QuillToolbar.simple(
                    controller: _quillController,
                  ),
                  Expanded(
                    child: quill.QuillEditor(
                      controller: _quillController,
                      scrollController: _scrollController,
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: widget.onPrevious,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 5),
                    Text('Nazorat haqida ma’lumot'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Row(
                  children: const [
                    Text('Ma’lumotni saqlash'),
                    SizedBox(width: 5),
                    Icon(Icons.save),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
