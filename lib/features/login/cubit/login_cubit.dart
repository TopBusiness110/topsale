import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/login_model.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/core/utils/appwidget.dart';
import 'package:topsale/core/utils/dialogs.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());
  ServiceApi api;
  AuthModel? authModel;

  login(BuildContext context,
      {required String phoneOrMail,
      required String db,
      required String password,

      bool iSVisitor = false}) async {
    emit(LoadingLoginState());
    AppWidget.createProgressDialog(context, 'انتظر');
    final response = await api.auth(phoneOrMail, password,db);
    response.fold((l) {
      print('gggggggg');
      Navigator.pop(context);
      errorGetBar("login failed");
      emit(FailureLoginState());
    }, (r) async {
      print('gggggggggggggggg');
      if (r.result != null) {
        authModel = r;
        String sessionId =
            await api.getSessionId(phone: phoneOrMail, password: password);
        print('lllllllll $sessionId');
        emit(SuccessLoginState());
        await Preferences.instance.setSessionId(sessionId);

        if (!iSVisitor) {

          await Preferences.instance.setUserName(phoneOrMail);
        await Preferences.instance.setUserPass(password);
        }
        
        Navigator.pop(context);
        Preferences.instance.setUser2(r);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeRoute, (route) => false);
      } else {
        errorGetBar("حدث خطأ ما");
        Navigator.pop(context);
      }
    });
  }
}
