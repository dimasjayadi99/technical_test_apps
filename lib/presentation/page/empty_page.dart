import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_apps/data/model/employee_model.dart';
import 'package:technical_test_apps/presentation/bloc/empty_employee_bloc.dart';
import 'package:technical_test_apps/presentation/page/detail_page.dart';
import 'package:technical_test_apps/presentation/widget/card_employee_widget.dart';
import 'package:technical_test_apps/presentation/widget/shimmer_widget.dart';

class EmptyPage extends StatefulWidget{
  const EmptyPage({super.key});

  @override
  EmptyPageState createState() => EmptyPageState();
}

class EmptyPageState extends State<EmptyPage>{

  EmptyEmployeeBloc? employeeBloc;
  EmployeeModel? employeeModel;

  @override
  void initState() {
    employeeBloc = EmptyEmployeeBloc();
    super.initState();
  }

  @override
  void dispose() {
    employeeBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => employeeBloc!..fetchList(),
      child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("List Karyawan", style: TextStyle(color: Colors.white),),
            actions: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                    onTap: (){
                      employeeBloc!.fetchList();
                    },
                    child: const Icon(Icons.refresh, color: Colors.white,)),
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              employeeBloc!.fetchList();
            },
            child: SafeArea(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: BlocBuilder<EmptyEmployeeBloc, EmptyEmployeeInitialState>(
                        builder: (context, state){
                          if(state is EmptyEmployeeLoadingState){
                            return const ShimmerWidget();
                          }
                          else if(state is EmptyEmployeeLoadedState){
                            employeeModel = state.data;
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(uuid: employeeModel!.employee[index].uuid,)));
                                      },
                                      child: CardEmployee(employeeModel: employeeModel, index: index));
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 10),
                                itemCount: employeeModel!.employee.length
                            );
                          }
                          else if(state is EmptyEmployeeFailedState){
                            return Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/ilustration.png", width: 200, height: 200,),
                                const Text("Data tidak ditemukan"),
                              ],
                            ));
                          }
                          else{
                            return Container();
                          }
                        },
                      )
                  )
              ),
            ),
          )
      ),
    );
  }
}