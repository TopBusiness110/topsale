
import 'package:flutter/material.dart';
import 'package:topsale/core/models/selected_products.dart';
import 'package:topsale/features/%20receipt/screens/receipt_screen.dart';
import 'package:topsale/features/catch_receipt/screens/catch_receipt_screen.dart';
import 'package:topsale/features/create_sales_order/screens/create_sales_order.dart';
import 'package:topsale/features/customer_payments/screens/customer_payments_screen.dart';
import 'package:topsale/features/forgot_password/screens/forgot_password1.dart';
import 'package:topsale/features/forgot_password/screens/forgot_password2.dart';
import 'package:topsale/features/login/screens/login.dart';
import 'package:topsale/features/new_product/screens/new_product_screen.dart';
import 'package:topsale/features/onboarding/screens/onboarding.dart';
import 'package:topsale/features/payments/screens/payment_screen.dart';
import 'package:topsale/features/products/screens/product_screen.dart';
import 'package:topsale/features/returns/screens/returns_screen.dart';
import 'package:topsale/features/signup/screens/signup.dart';
import '../../core/utils/app_strings.dart';
import '../../features/forgot_password/screens/forgot_password3.dart';
import '../../features/home/screens/home.dart';
import '../../features/splash/screens/splash_screen.dart';

class Routes{
  static const String initialRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String forgotPassword1Route = '/forgotPassword1';
  static const String forgotPassword2Route = '/forgotPassword2';
  static const String forgotPassword3Route = '/forgotPassword3';
  static const String homeRoute = '/home';
  static const String productsRoute = '/products';
  static const String newProductRoute = '/newProduct';
  static const String createSalesOrderRoute = '/createSalesOrder';
  static const String paymentRoute = '/payment';
  static const String  receiptRoute = '/ receipt';
  static const String  returnsRoute = '/ returns';
  static const String  customerPaymentsRoute = '/ customerPayments';
  static const String  catchReceiptRoute = '/ catchReceipt';

}









class AppRoutes{
 static Route onGenerateRoute(RouteSettings settings){
   switch(settings.name)
    {
     case Routes.initialRoute:
       return MaterialPageRoute(builder: (context) => const SplashScreen(),);

     case Routes.onBoardingRoute:
       return MaterialPageRoute(builder: (context) => const OnBoarding(),);


     case Routes.loginRoute:
       return MaterialPageRoute(builder: (context) => const LoginScreen(),);

     case Routes.signUpRoute:
       return MaterialPageRoute(builder: (context) => const SignUpScreen(),);

     case Routes.forgotPassword1Route:
       return MaterialPageRoute(builder: (context) => const ForgotPasswordStep1(),);

     case Routes.forgotPassword2Route:
       return MaterialPageRoute(builder: (context) => const ForgotPasswordStep2(),);

     case Routes.forgotPassword3Route:
       return MaterialPageRoute(builder: (context) => const ForgotPasswordStep3(),);

     case Routes.homeRoute:
       return MaterialPageRoute(builder: (context) => const Home(),);

     case Routes.productsRoute:
       return MaterialPageRoute(builder: (context) => const ProductsScreen(),);

     case Routes.newProductRoute:
       return MaterialPageRoute(builder: (context) => const NewProduct(),);

     case Routes.createSalesOrderRoute:

       final selectedProducts = settings.arguments as SelectedProducts;

       return MaterialPageRoute(builder: (context) =>  CreateSalesOrder(selectedProducts: selectedProducts),);

     case Routes.paymentRoute:
       final sum = settings.arguments as double;
       return MaterialPageRoute(builder: (context) =>  PaymentScreen(sum: sum),);

     case Routes.receiptRoute:
       return MaterialPageRoute(builder: (context) => const ReceiptScreen(),);

     case Routes.returnsRoute:
       return MaterialPageRoute(builder: (context) => const ReturnsScreen(),);

     case Routes.customerPaymentsRoute:
       return MaterialPageRoute(builder: (context) => const CustomerPaymentsScreen(),);

     case Routes.catchReceiptRoute:
       return MaterialPageRoute(builder: (context) => const CatchReceiptScreen(),);






     default:
       return undefinedRoute() ;
   }
  }
  static Route<dynamic> undefinedRoute(){
   return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text(AppStrings.noRouteFound),),),);
  }
}