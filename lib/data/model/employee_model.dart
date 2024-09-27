class EmployeeModel {
  final List<Employee> employee;

  EmployeeModel({required this.employee});

  Map<String, dynamic> toMap() {
    return {
      'employees' : employee.map((element) => element.toMap()).toList()
    };
  }

  factory EmployeeModel.fromMap(Map<String,dynamic> map){
    return EmployeeModel(
        employee: List<Employee>.from(
          map['employees']?.map((employeeMap) => Employee.fromMap(employeeMap)) ?? [],
        )
    );
  }

}

class Employee {
  final String uuid;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;
  final String biography;
  final String photoUrlSmall;
  final String photoUrlLarge;
  final String team;
  final String employeeType;

  Employee({
    required this.uuid,
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.biography,
    required this.photoUrlSmall,
    required this.photoUrlLarge,
    required this.team,
    required this.employeeType,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid' : uuid,
      'full_name' : fullName,
      'phone_number' : phoneNumber,
      'email_address' : emailAddress,
      'biography' : biography,
      'photo_url_small' : photoUrlSmall,
      'photo_url_large' : photoUrlLarge,
      'team' : team,
      'employee_type' : employeeType,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map){
    return Employee(
        uuid: map['uuid'] ?? '',
        fullName: map['full_name'] ?? '',
        phoneNumber: map['phone_number'] ?? '',
        emailAddress: map['email_address'] ?? '',
        biography: map['biography'] ?? '',
        photoUrlSmall: map['photo_url_small'] ?? '',
        photoUrlLarge: map['photo_url_large'] ?? '',
        team: map['team'] ?? '',
        employeeType: map['employee_type'] ?? '',
    );
  }
}