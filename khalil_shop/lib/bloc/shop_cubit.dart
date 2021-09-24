import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/helper/dio_helper.dart';
import 'package:khalil_shop/models/categories_model.dart';
import 'package:khalil_shop/models/change_favorites_model.dart';
import 'package:khalil_shop/models/favorites_model.dart';
import 'package:khalil_shop/models/home_model.dart';
import 'package:khalil_shop/screens/categories_screen.dart';
import 'package:khalil_shop/screens/favourites_screen.dart';
import 'package:khalil_shop/screens/products_screen.dart';
import 'package:khalil_shop/screens/settings_screen.dart';

import '../constatnts.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?>? favourites = {};

  Future<void> getHomeData() async {
    emit(ShopLoadingHomeDataState());

    DioHelper.getDate(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products!.forEach((element) {
        favourites!.addAll({
          element.id!: element.inFavourites,
        });
      });

      print(favourites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  Future<void> getCategoriesModel() async {
    DioHelper.getDate(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //  print(categoriesModel!.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {

    favourites![productId] = !favourites![productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postDate(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
      token: token,
    ).then((value) {

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status!){
        favourites![productId] = !favourites![productId]!;
      }else{
        getFavoritesModel();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {

      favourites![productId] = ! favourites![productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;

  void getFavoritesModel()  {

    emit(ShopLoadingGetFavoritesState());

    DioHelper.getDate(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //  print(categoriesModel!.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {

     // print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


}
