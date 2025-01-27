import 'package:flutter/material.dart';

class StepTwoProvider with ChangeNotifier {
  String documentNumber = '';
  String documentName = '';
  String docNumber = '';
  int? docTypeId1;
  int? docTypeId2;
  String assignmentTime = '';
  String registrationNumber = '';
  String acceptanceDate = '';
  String taskDeadline = '';
  String executionDate = '';

  void updateField(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'documentNumber':
        documentNumber = value;
        break;
      case 'documentName':
        documentName = value;
        break;
      case 'docNumber':
        docNumber = value;
        break;
      case 'docTypeId1':
        docTypeId1 = value;
        break;
      case 'docTypeId2':
        docTypeId2 = value;
        break;
      case 'assignmentTime':
        assignmentTime = value;
        break;
      case 'registrationNumber':
        registrationNumber = value;
        break;
      case 'acceptanceDate':
        acceptanceDate = value;
        break;
      case 'taskDeadline':
        taskDeadline = value;
        break;
      case 'executionDate':
        executionDate = value;
        break;
    }
    print('Обновлено поле: $fieldName, значение: $value');
    notifyListeners();
  }

  void resetFields() {
    documentNumber = '';
    documentName = '';
    docNumber = '';
    docTypeId1 = null;
    docTypeId2 = null;
    assignmentTime = '';
    registrationNumber = '';
    acceptanceDate = '';
    taskDeadline = '';
    executionDate = '';
    notifyListeners();
  }
}
