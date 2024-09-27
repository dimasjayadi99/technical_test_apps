import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_apps/data/model/employee_model.dart';
import 'package:technical_test_apps/presentation/bloc/employee_bloc.dart';
import 'package:technical_test_apps/presentation/widget/textfield_widget.dart';

class DetailPage extends StatefulWidget{

  final String uuid;

  const DetailPage({super.key, required this.uuid});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage>{

  EmployeeBloc? employeeDetailBloc;
  EmployeeModel? employee;
  String userId = "";
  String typeEmployee = "";

  // Text Editing Controller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController biographyController = TextEditingController();
  final TextEditingController teamController = TextEditingController();

  @override
  void initState() {
    employeeDetailBloc = EmployeeBloc();
    if(widget.uuid.isNotEmpty || widget.uuid != ""){
      userId = widget.uuid;
    }
    super.initState();
  }

  @override
  void dispose() {
    employeeDetailBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String capitalizeWords(String text) {
      return text.split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
    }
    return BlocProvider(
        create: (context) => employeeDetailBloc!..fetchById(userId),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Detail Page"),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<EmployeeBloc, EmployeeInitialState>(
                  builder: (context, state){
                    if(state is EmployeeLoadingState){
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: const Center(child: CircularProgressIndicator()));
                    }
                    else if(state is EmployeeLoadedState){
                      employee = state.data;
                      fullNameController.text = employee!.employee[0].fullName;
                      emailAddressController.text = employee!.employee[0].emailAddress;
                      phoneNumberController.text = employee!.employee[0].phoneNumber;
                      biographyController.text = employee!.employee[0].biography;
                      teamController.text = employee!.employee[0].team;
                      typeEmployee = employee!.employee[0].employeeType;
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                color: Colors.blue
                            ),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(100)),
                                child: Image.network(employee!.employee[0].photoUrlSmall, width: 100, height: 100, fit: BoxFit.cover)),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: typeEmployee == "FULL_TIME"
                                  ? Colors.blue
                                  : typeEmployee == "PART_TIME"
                                  ? Colors.green
                                  : Colors.orange,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                            child: Text(
                              capitalizeWords(typeEmployee.replaceAll('_', ' ')), // Capitalize each word
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(label: "Full Name", controller: fullNameController),
                          const SizedBox(height: 16),
                          CustomTextField(label: "Email Address", controller: emailAddressController),
                          const SizedBox(height: 16),
                          CustomTextField(label: "Phone Number", controller: phoneNumberController),
                          const SizedBox(height: 16),
                          CustomTextField(label: "Biography", controller: biographyController),
                          const SizedBox(height: 16),
                          CustomTextField(label: "Team", controller: teamController),
                        ],
                      );
                    }
                    else if(state is EmployeeFailedState){
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: const Center(child: Text("Gagal ambil data")));
                    }
                    else{
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}