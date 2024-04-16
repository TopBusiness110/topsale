import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/get_location.dart';
import 'package:topsale/core/models/selected_products.dart';
import 'package:topsale/core/remote/service_api.dart';

part 'dismissal_notice_state.dart';

class DismissalNoticeCubit extends Cubit<DismissalNoticeState> {
  DismissalNoticeCubit(this.api) : super(DismissalNoticeInitial());
  ServiceApi api;
  final List<String> items = [
    ' مخزن1',
    'مخزن2',
    'مخزن3',
    'مخزن4',
  ];
  String? selectedFromStockValue;
  String? selectedToStockValue;
  selectFromStock(value) {
    selectedFromStockValue = value;
    // changeButtonColor(true);

    //isSelected = true;
    emit(ChangingStockState());
  }

  selectToStock(value) {
    selectedToStockValue = value;
    // changeButtonColor(true);

    //isSelected = true;
    emit(ChangingStockState());
  }

  GetLocationModel? getFromLocationModel;
  getFromLocations() async {
    emit(LoadingGetFromLocationsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getfromLocations();
    response.fold((l) => emit(FailureGetFromLocationsState()), (r) {
      emit(SuccessGetFromLocationsState());
      getFromLocationModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  GetLocationModel? getToLocationModel;
  getToLocations() async {
    emit(LoadingGetToLocationsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getfromLocations();
    response.fold((l) => emit(FailureGetToLocationsState()), (r) {
      emit(SuccessGetToLocationsState());
      getToLocationModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  DefaultModel? createPickingModel;
  createPicking() async {
    emit(LoadingCreatePickingState());

    final response = await api.createPicking(
      fromLocationId: int.parse(selectedFromStockValue!),
      toLocationId: int.parse(selectedToStockValue!),
    );
    response.fold((l) => emit(FailureCreatePickingState()), (r) {
      emit(SuccessCreatePickingState());
      createPickingModel = r;
      createStockMove();
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  DefaultModel? creatStockModel;
  createStockMove() async {
    emit(LoadingCreateStockMoveState());

    final response = await api.createStockMove(
        fromLocationId: int.parse(selectedFromStockValue!),
        toLocationId: int.parse(selectedToStockValue!),
        name: selectedProducts[0].name!,
        pickingId: createPickingModel!.result!,
        productId: selectedProducts[0].id!,
        qty: selectedProducts[0].userOrderedQuantity);
    response.fold((l) => emit(FailureCreateStockMoveState()), (r) {
      emit(SuccessCreateStockMoveState());
      creatStockModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  List<ProductModelData> selectedProducts = [];
  addProduct({required ProductModelData product}) {
    if (product.qty_available > product.userOrderedQuantity) {
      print(
          "____________________selectedProducts.isEmpty __________________________");
      // product.userOrderedQuantity++;
      product.userOrderedQuantity++;
      if (selectedProducts.isEmpty) {
        selectedProducts.add(product);
      } else {
        bool isExist = false;

        for (int i = 0; i < selectedProducts.length; i++) {
          if (selectedProducts[i].id == product.id) {
            isExist = true;

            emit(AddProductsState());
          } else {
            // isExist = false;
          }
        }
        if (!isExist) {
          selectedProducts.add(product);
        }
      }

      emit(AddProductsState());
      return;
    } else {}
  }

  removeProduct({required ProductModelData product}) {
    if (product.userOrderedQuantity > 0) {
      product.userOrderedQuantity = product.userOrderedQuantity - 1;
      emit(RemoveProductsState());
    } else if (product.userOrderedQuantity == 0) {
      selectedProducts.remove(product);
      emit(RemoveProductsState());
    }
  }

  AllProductsModel? productsModel;
  getAllProducts() async {
    emit(LoadingAllProductsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllProducts();
    response.fold((l) => emit(AllProductsFailureState()), (r) {
      emit(AllProductsSuccessState());
      productsModel = r;

      print("***************************************************");
      print(productsModel.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }
}
