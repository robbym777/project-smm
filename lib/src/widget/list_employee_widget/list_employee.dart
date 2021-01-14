import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<EmployeeBlocService>().add(GetListEmployee());
    return BlocBuilder(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      builder: (context, blocService){
        if (blocService is ListEmployeeSuccess){
          print(blocService.data);
          return RefreshIndicator(
            onRefresh: (){context.bloc<EmployeeBlocService>().add(GetListEmployee());},
            color: Colors.blue,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey,
              child: ListView(
                children: blocService.data.map<Widget>((data){

                  EmployeeModel employeeList = EmployeeModel(
                      personalInfo: PersonalInfo.fromJson(data['personalInfo']),
                      contactInfo: ContactInfo.fromJson(data['contactInfo']),
                      workInfo: WorkInfo.fromJson(data['workInfo'])
                  );

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image(
                              image: employeeList.personalInfo.photo != null
                                  ? NetworkImage(employeeList.personalInfo.photo)
                                  : AssetImage('assets/img/icons/icon-profile.png'),
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)
                                    )
                                  ),
                                  child: Text(employeeList.personalInfo.name,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Jenis kelamin ', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(employeeList.personalInfo.gender??''),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Tanggal lahir ', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(employeeList.personalInfo.birthDate??''),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Golongan darah ', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(employeeList.personalInfo.bloodType??''),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('No. Telepon ', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(employeeList.contactInfo.phoneNumber??''),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Departemen ', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(employeeList.workInfo.dept??''),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Jabatan ', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(employeeList.workInfo.title??''),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
        if (blocService is ListEmployeeFailed) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Tidak ada koneksi'),
            ),
          );
        }
        return Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              Center(child: Text('Loading data...'))
            ],
          ),
        );
      },
    );
  }
}
