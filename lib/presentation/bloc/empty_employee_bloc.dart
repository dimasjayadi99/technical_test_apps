import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_apps/data/model/employee_model.dart';
import 'package:technical_test_apps/service/api_service.dart';

class EmptyEmployeeInitialState{}

class EmptyEmployeeLoadingState extends EmptyEmployeeInitialState{}

class EmptyEmployeeLoadedState extends EmptyEmployeeInitialState{
  final EmployeeModel data;
  EmptyEmployeeLoadedState({required this.data});
}

class EmptyEmployeeFailedState extends EmptyEmployeeInitialState{}

class EmptyEmployeeBloc extends Cubit<EmptyEmployeeInitialState>{
  EmptyEmployeeBloc() : super(EmptyEmployeeInitialState());

  // fetch list
  void fetchList() async {
    emit(EmptyEmployeeLoadingState());
    final data = await ApiService().fetchEmptyList();
    try{
      if(data.employee.isNotEmpty){
        emit(EmptyEmployeeLoadedState(data: data));
      }else{
        emit(EmptyEmployeeFailedState());
      }
    }catch(error){
      throw Exception("Error Message : $error");
    }
  }
}