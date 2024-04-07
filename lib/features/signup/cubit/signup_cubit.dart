import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:topsale/config/routes/app_routes.dart';
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
  login(BuildContext context,
      {required String phoneOrMail, required String password, required String db}) async {
    emit(LoadingSignupState());
    AppWidget.createProgressDialog(context, 'انتظر');
    final response = await api.authWithSession(phoneOrMail, password,db);
    response.fold((l) {
      print('gggggggg');
      Navigator.pop(context);
      errorGetBar("login failed");
      emit(FailureSignupState());
    }, (r) {
      print('gggggggggggggggg');
      if (r.result != null) {
        authModel = r;
        //    String sessionId =
        //     await getSessionId(phone: phoneOrMail, password: password);
        // await Preferences.instance.setSessionId(sessionId);

        emit(SuccessSignupState());
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
