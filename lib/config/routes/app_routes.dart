import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/selected_products.dart';
import 'package:topsale/features/%20receipt/screens/receipt_return_screen.dart';
import 'package:topsale/features/%20receipt/screens/receipt_screen%20details.dart';
import 'package:topsale/features/%20receipt/screens/receipt_screen.dart';
import 'package:topsale/features/catch_receipt/screens/catch_receipt_screen.dart';
import 'package:topsale/features/create_sales_order/screens/create_sales_order.dart';
import 'package:topsale/features/customer_payments/screens/customer_payments_screen.dart';
import 'package:topsale/features/dismissal_notice/screens/dismissal_notice_screen.dart';
import 'package:topsale/features/dismissal_notice_details/screens/dismissal_notice_details_screen.dart';
import 'package:topsale/features/expectet_clients_list/screens/expected_clients_list_screen.dart';
import 'package:topsale/features/forgot_password/screens/forgot_password1.dart';
import 'package:topsale/features/forgot_password/screens/forgot_password2.dart';
import 'package:topsale/features/google_map/screens/google_map_screen.dart';
import 'package:topsale/features/google_map_routing/google_map_routing_screen.dart';
import 'package:topsale/features/home/tabs/expected_clients_tab.dart';
import 'package:topsale/features/itinerary_details/screens/itinerary_details_screen.dart';
import 'package:topsale/features/login/screens/login.dart';
import 'package:topsale/features/my_account/screens/edit_account.dart';
import 'package:topsale/features/my_account/screens/my_account.dart';
import 'package:topsale/features/new_product/screens/new_product_screen.dart';
import 'package:topsale/features/onboarding/screens/onboarding.dart';
import 'package:topsale/features/payments/screens/payment_screen.dart';
import 'package:topsale/features/products/screens/product_screen.dart';
import 'package:topsale/features/reports/screens/report_screen.dart';
import 'package:topsale/features/reports/screens/reports_screen.dart';
import 'package:topsale/features/returns/screens/returns_screen.dart';
import 'package:topsale/features/sales_ordered_list/screens/sales_ordered_list_screen.dart';
import 'package:topsale/features/signup/screens/signup.dart';
import '../../core/models/product_model.dart';
import '../../core/models/shipment_model.dart';
import '../../core/utils/app_strings.dart';
import '../../features/catch_receipt/models/catch_receipt_model.dart';
import '../../features/forgot_password/screens/forgot_password3.dart';
import '../../features/home/screens/home.dart';
import '../../features/returns_list/screens/returns_list_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

class Routes {
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
  static const String receiptRoute = '/ receipt';
  static const String receiptReturnsRoute = '/ receiptReturns';

  static const String returnsRoute = '/ returns';
  static const String customerPaymentsRoute = '/ customerPayments';
  static const String catchReceiptRoute = '/ catchReceipt';
  static const String dismissalNoticeRoute = '/ dismissalNotice';
  static const String myAccountRoute = '/ myAccount';
  static const String editAccountRoute = '/ editAccount';
  static const String reportsRoute = '/ reports';
  static const String reportRoute = '/ report';
  static const String expectedClientsListRoute = '/ xpectedClientsList';
  static const String itineraryDetailsRoute = '/ itineraryDetails';
  static const String dismissalNoticeDetailsRoute = '/ dismissalNoticeDetails';
  static const String expectedClientsTabRoute = '/ ExpectedClientsTab';
  static const String googleMapRoute = '/ googleMap';
  static const String googleMapRoutingRoute = '/ googleMapRoutingScreen';
  static const String salesOrderedListRoute = '/ salesOrderedListScreen';
  static const String returnsListRoute = '/ returnsListScreen';
}

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoarding(),
        );

      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case Routes.forgotPassword1Route:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordStep1(),
        );

      case Routes.forgotPassword2Route:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordStep2(),
        );

      case Routes.forgotPassword3Route:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordStep3(),
        );

      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );

      case Routes.productsRoute:
        return MaterialPageRoute(
          builder: (context) => const ProductsScreen(),
        );

      case Routes.newProductRoute:
        return MaterialPageRoute(
          builder: (context) => const NewProduct(),
        );

      case Routes.createSalesOrderRoute:
        final selectedProducts = settings.arguments as SelectedProducts;

        return MaterialPageRoute(
          builder: (context) =>
              CreateSalesOrder(selectedProducts: selectedProducts),
        );

      case Routes.paymentRoute:
        final sum = settings.arguments as double;
        final partnerId = settings.arguments as dynamic;
        final quantity = settings.arguments as dynamic;
        final productId = settings.arguments as dynamic;

        final onPressed = settings.arguments as void Function()?;
        return MaterialPageRoute(
          builder: (context) => PaymentScreen(
            sum: sum,
            onPressed: onPressed,
            partnerId: partnerId,
            productId: productId,
            quantity: quantity,
          ),
        );

      case Routes.receiptRoute:
        return MaterialPageRoute(
          builder: (context) => const ReceiptScreen(),
        );
      
      case Routes.receiptReturnsRoute:
        return MaterialPageRoute(
          builder: (context) => const ReceiptReturnScreen(),
        );
      
      case Routes.returnsRoute:
        return MaterialPageRoute(
          builder: (context) => const ReturnsScreen(),
        );

      case Routes.customerPaymentsRoute:
        return MaterialPageRoute(
          builder: (context) => const CustomerPaymentsScreen(),
        );

      case Routes.catchReceiptRoute:
        final catchReceiptModel = settings.arguments as CatchReceiptModel;
        return MaterialPageRoute(
          builder: (context) =>
              CatchReceiptScreen(catchReceiptModel: catchReceiptModel),
        );

      case Routes.dismissalNoticeRoute:
        return MaterialPageRoute(
          builder: (context) => const DismissalNoticeScreen(),
        );

      case Routes.myAccountRoute:
        return MaterialPageRoute(
          builder: (context) => const MyAccount(),
        );

      case Routes.editAccountRoute:
        return MaterialPageRoute(
          builder: (context) => const EditAccountScreen(),
        );

      case Routes.reportsRoute:
        return MaterialPageRoute(
          builder: (context) => const ReportsScreen(),
        );
     
      case Routes.expectedClientsListRoute:
        return MaterialPageRoute(
          builder: (context) => const ExpectedClientsListScreen(),
        );

      case Routes.itineraryDetailsRoute:
        return MaterialPageRoute(
          builder: (context) => ItineraryDetailsScreen(),
        );

      case Routes.dismissalNoticeDetailsRoute:
        final productsList = settings.arguments as List<ProductModelData>;
        return MaterialPageRoute(
          builder: (context) =>
              DismissalNoticeDetailsScreen(products: productsList),
        );

      case Routes.expectedClientsTabRoute:
        return MaterialPageRoute(
          builder: (context) => ExpectedClientsTab(),
        );

      case Routes.googleMapRoute:
        final latlng = settings.arguments as LatLng;

        return MaterialPageRoute(
          builder: (context) => GoogleMapScreen(latLng: latlng),
        );

      case Routes.googleMapRoutingRoute:
        final latlng = settings.arguments as LatLng;

        return MaterialPageRoute(
          builder: (context) => GoogleMapRoutingScreen(
            destinationlatLng: latlng,
          ),
        );

      case Routes.salesOrderedListRoute:
        return MaterialPageRoute(
          builder: (context) => SalesOrderedListScreen(),
        );

      case Routes.returnsListRoute:
        return MaterialPageRoute(
          builder: (context) => const ReturnsListScreen(),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
