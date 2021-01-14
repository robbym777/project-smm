import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_service.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:bloc/bloc.dart';

class EmployeeBlocService extends Bloc<BlocEvent, BlocState>{
  final employeeService = EmployeeService();

  @override
  BlocState get initialState => Waiting();

  @override
  Stream<BlocState>mapEventToState(BlocEvent event) async* {

    if(event is SetEmployeeProfile) {
      try{
        final result = await employeeService.setEmployeeData();
        yield Success(data: result);
      }catch(e){
        print(e);
        yield Failed(data: e);
      }
    }

    if(event is GetListEmployee) {
      try{
        final result = await employeeService.getListEmployeeProfile();
        yield ListEmployeeSuccess(data: result);
      }catch(e){
        yield ListEmployeeFailed(data: e);
      }
    }

    if(event is CheckingDatabase) {
      try{
        final result = await employeeService.checkingDatabase();
        yield Success(data: result);
      } catch(e){
        yield Failed(data: e);
      }
    }

    if(event is SubmitAttendance) {
      try{
        final result = await employeeService.submitAttendance(event.employeeId, event.location, event.status);
        if (result == 'submitted') {
          yield SubmitSuccess(data: result);
        } else {
          yield SubmitToLocal(data: result);
        }
      } catch(e){
        yield SubmitFailed(data: e);
      }
    }

    if(event is SubmitCardAttendance) {
      try{
        final result = await employeeService.submitCardAttendance(event.listEmployee, event.status);
        if (result == 'submitted') {
          yield SubmitSuccess(data: result);
        } else {
          yield SubmitToLocal(data: result);
        }
      } catch(e){
        yield SubmitFailed(data: e);
      }
    }

    if(event is EmployeeQRAttendance) {
      try{
        final result = await employeeService.qrAttendance(event.scanner, event.id);
        yield ScanSuccess(data: result['employee'], status: result['status']);
      } catch (e){
        print(e);
        yield ScanFailed(data: e);
      }
    }

    if(event is EmployeeCardAttendance) {
      try{
        final result = await employeeService.cardAttendance(event.scanner, event.id);
        yield CardScanSuccess(data: result['employee'], status: result['status'], location: result['location']);
      } catch (e){
        print(e);
        yield CardScanFailed(data: e);
      }
    }

    if(event is ListAttendance) {
      try{
        final result = await employeeService.getListAttendance(event.date);
        if (result == null) {
          yield ListIsNull(data: result);
        } else {
          yield GetListSuccess(data: result);
        }
      }catch(e){
        print(e);
        yield NoConnection(data: e);
      }
    }

    if(event is SubmitPendingAttendance) {
      try{
        final result = await employeeService.submitAllPendingAttendance();
        yield SubmitPendingSuccess(data: result);
      }catch(e){
        print(e);
        yield SubmitPendingFailed(data: e);
      }
    }

    if(event is CheckUpdateEmployee) {
      try {
        final result = await employeeService.checkUpdate();
        yield UpdateMessage(status: result['status'], isUpdate: result['update']);
      } catch (err) {
        yield NoConnection(data: err);
      }
    }

    if(event is UpdateEmployee) {
      try {
        final result = await employeeService.updateEmployeeData();
        yield UpdateSuccess(message: result);
      } catch (err) {
        yield UpdateFailed(message: err);
      }
    }

    if(event is SetLocation) {
      try {
        final result = await employeeService.setLocation();
        yield LocationApplied(data: result);
      } catch (err) {
        yield FailedSetLocation(data: err);
      }
    }

    if(event is GetLocation) {
      try {
        final result = await employeeService.getLocation();
        yield SuccessLocation(data: result);
      } catch (err) {
        yield FailedLocation(data: err);
      }
    }
  }
}