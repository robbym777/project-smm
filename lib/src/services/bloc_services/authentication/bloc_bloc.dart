import 'dart:math';

import 'package:attendance_application/src/services/bloc_services/authentication/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_service.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthBlocService extends Bloc<BlocEvent, BlocState>{
  final authService = AuthService();

  @override
  BlocState get initialState => Waiting();

  @override
  Stream<BlocState>mapEventToState(BlocEvent event) async* {
    if(event is Authentication){
      try{
        final result = await authService.authentication();
        yield Success(data: result);
      }catch(e){
        if (e == 'Sign_in_canceled') {
          yield Waiting();
        } else if (e.runtimeType == DioError){
          yield Invalid(data: e);
        } else {
          yield Failed(data: e);
        }
      }
    }

    if(event is CheckAuthentication){
      try{
        final result = await authService.checkAuthentication();
        yield Authenticated(data: result);
      }catch(e){
        yield NoAuthentication(data: e);
      }
    }
  }
}