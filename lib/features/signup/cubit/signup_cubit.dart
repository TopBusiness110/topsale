import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/api/end_points.dart';
import 'package:topsale/core/models/login_model.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/core/utils/appwidget.dart';
import 'package:topsale/core/utils/dialogs.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.api) : super(SignupInitial());
  ServiceApi api;

  AuthModel? authModel;
  signup(
    BuildContext context, {
    required String phoneOrMail,
    required String password,
    required String db,
    required String name,
    required String odooLink,
  }) async {
    emit(LoadingSignupState());
    AppWidget.createProgressDialog(context, 'انتظر');
    final response = await api.authWithDB(
        phoneOrMail: phoneOrMail,
        password: password,
        db: db,
        name: name,
        odooLink: odooLink);
    response.fold((l) {
      print('gggggggg');
      Navigator.pop(context);
      errorGetBar("login failed");
      emit(FailureSignupState());
    }, (r) async {
      print('gggggggggggggggg');
      if (r.result != null) {
        authModel = r;
    String sessionId =
            await api.getSessionId(phone: phoneOrMail, password: password,);
        print('lllllllll $sessionId');
        emit(SuccessSignupState());
        await Preferences.instance.setSessionId(sessionId);
             await Preferences.instance.setUserName(phoneOrMail);
        await Preferences.instance.setUserPass(password);
        await Preferences.instance.setDataBaseName(db);
        EndPoints.baseUrl = "https://$db";
        EndPoints.db = db;
      
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
