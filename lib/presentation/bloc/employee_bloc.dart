import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_apps/data/model/employee_model.dart';
import 'package:technical_test_apps/service/api_service.dart';

class EmployeeInitialState{}

class EmployeeLoadingState extends EmployeeInitialState{}

class EmployeeLoadedState extends EmployeeInitialState{
  final EmployeeModel data;
  EmployeeLoadedState({required this.data});
}

class EmployeeFailedState extends EmployeeInitialState{}

class EmployeeBloc extends Cubit<EmployeeInitialState>{
  EmployeeBloc() : super(EmployeeInitialState());

  // fetch list
  void fetchList() async {
    emit(EmployeeLoadingState());
    final data = await ApiService().fetchList();
    try{
      if(data.employee.isNotEmpty){
        emit(EmployeeLoadedState(data: data));
      }else{
        emit(EmployeeFailedState());
      }
    }catch(error){
      throw Exception("Error Message : $error");
    }
  }

  // fetch by uuid
  void fetchById(String uuid) async {
    emit(EmployeeLoadingState());
    final data = await ApiService().fetchById(uuid);
    try{
      if(data.employee.isNotEmpty){
        emit(EmployeeLoadedState(data: data));
        if(data.employee[0].uuid == ""){
          emit(EmployeeFailedState());
        }
      }else{
        emit(EmployeeFailedState());
      }
    }catch(error){
      throw Exception("Error Message : $error");
    }
  }

}