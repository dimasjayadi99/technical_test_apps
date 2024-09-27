import 'dart:convert';

import 'package:technical_test_apps/data/model/employee_model.dart';
import 'package:technical_test_apps/service/api_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = ApiConfig.baseUrl;

  // fetch list employee
  Future<EmployeeModel> fetchList() async {
    final url = "$baseUrl/employees.json";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return EmployeeModel.fromMap(data);
    }else{
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  }

  // fetch data by uuid
  Future<EmployeeModel> fetchById(String uuid) async {
    final url = "$baseUrl/employees.json";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final employeesList = data['employees'] as List<dynamic>?;
      if (employeesList != null) {
        final employeeData = employeesList.firstWhere(
              (element) => element['uuid'] == uuid,
          orElse: () => null,
        );

        if (employeeData != null) {
          return EmployeeModel.fromMap({'employees': [employeeData]});
        } else {
          throw Exception('Employee with UUID $uuid not found');
        }
      } else {
        throw Exception('Failed to parse employee list');
      }
    } else {
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  }

  // fetch list employee
  Future<EmployeeModel> fetchEmptyList() async {
    final url = "$baseUrl/employees_empty.json";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return EmployeeModel.fromMap(data);
    }else{
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  }

}