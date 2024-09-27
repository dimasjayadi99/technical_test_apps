import 'package:flutter/material.dart';
import 'package:technical_test_apps/data/model/employee_model.dart';

class CardEmployee extends StatelessWidget{

  final EmployeeModel? employeeModel;
  final int index;

  const CardEmployee({super.key, required this.employeeModel, required this.index});

  @override
  Widget build(BuildContext context) {

    String capitalizeWords(String text) {
      return text.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.network(employeeModel!.employee[index].photoUrlSmall, width: 60, height: 60, fit: BoxFit.cover,)),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employeeModel!.employee[index].fullName, style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  const SizedBox(width: 5),
                  Text(employeeModel!.employee[index].phoneNumber),
                ],
              ),
              const SizedBox(height: 5),
              Text(employeeModel!.employee[index].emailAddress, style: const TextStyle(color: Colors.grey),),
            ],
          ),
          
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              color: employeeModel!.employee[index].employeeType == "FULL_TIME"
                  ? Colors.blue
                  : employeeModel!.employee[index].employeeType == "PART_TIME"
                  ? Colors.green
                  : Colors.orange,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: Text(
              capitalizeWords(employeeModel!.employee[index].employeeType.replaceAll('_', ' ')), // Capitalize each word
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          )

        ],
      ),
    );
  }

}