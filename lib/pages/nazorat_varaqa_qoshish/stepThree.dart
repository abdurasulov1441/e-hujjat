import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/card_provider.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/step_two_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  final VoidCallback onPrevious;

  const StepThree({Key? key, required this.onPrevious}) : super(key: key);

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  Future<void> CreateDocument() async {
    final _controlCardProvider =
        Provider.of<ControlCardProvider>(context, listen: false);
    final _stepTwoProvider =
        Provider.of<StepTwoProvider>(context, listen: false);

    try {
      final response = await requestHelper.postWithAuth(
          '/api/controls/add-control-card',
          {
            "number": _stepTwoProvider.docNumber,
            "responsible_person_id":
                _controlCardProvider.selectedResponsiblePersons.join(","),
            "responsible_id":
                _controlCardProvider.selectedSubordinates.join(","),
            "naming": _stepTwoProvider.documentName,
            "doc_num": _stepTwoProvider.docNumber,
            "doc_num_type_id": _stepTwoProvider.docTypeId1,
            "assignment_time": _stepTwoProvider.assignmentTime,
            "doc_reg_num": _stepTwoProvider.registrationNumber,
            "doc_reg_type_id": _stepTwoProvider.docTypeId2,
            "date_received": _stepTwoProvider.acceptanceDate,
            "info": _quillController.document.toDelta().toJson(),
            "info_text": _quillController.document.toPlainText().toString(),
            "deadline": _stepTwoProvider.taskDeadline,
          },
          log: true);
      print(_quillController.document.toDelta().toJson());
    } catch (e) {}
  }

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
    CreateDocument();
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
                onPressed: CreateDocument,
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
