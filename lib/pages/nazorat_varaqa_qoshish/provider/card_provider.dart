import 'package:flutter/material.dart';

class ControlCardProvider extends ChangeNotifier {
  List<int> selectedDepartments = [];
  List<int> selectedResponsiblePersons = [];
  List<int> selectedSubordinates = [];


  void updateSelectedData(Map<String, dynamic> data) {
    selectedDepartments = List<int>.from(data['departments']);
    selectedResponsiblePersons = List<int>.from(data['responsiblePersons']);
    selectedSubordinates = List<int>.from(data['subordinates']);
    notifyListeners();
  }

  void clearAll() {
    selectedDepartments.clear();
    selectedResponsiblePersons.clear();
    selectedSubordinates.clear();
    notifyListeners();
  }

  Map<String, dynamic> getSelectedData() {
    return {
      'departments': selectedDepartments,
      'responsiblePersons': selectedResponsiblePersons,
      'subordinates': selectedSubordinates,
    };
  }
}
