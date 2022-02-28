import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/database/Homemodel.dart';

import 'package:ecommmerce/database/cartmodel.dart';
import 'package:ecommmerce/database/favoritemodel.dart';
import 'package:ecommmerce/database/searchmodel.dart';

import 'package:ecommmerce/database/userData.dart';
import 'package:ecommmerce/network/remote.dart';

import 'package:ecommmerce/pages/cart.dart';
import 'package:ecommmerce/pages/edituser.dart';
import 'package:ecommmerce/pages/favorites.dart';
import 'package:ecommmerce/pages/products.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopState extends Cubit<Status> {
  ShopState() : super(intiState());

  static ShopState get(context) => BlocProvider.of(context);

  PageController _pagecontroller = PageController();
  GlobalKey<CurvedNavigationBarState> navbar = GlobalKey();
  int page = 0;
  loginModel? loginmodel = loginModel();
  HomeModel? homemodel;
  SearchModel? results;
  CartInfo? myCart = CartInfo();
  Map<String, dynamic>? result;
  List pages = [Products(), Favorite(), Edituser()];
  Favoritemodel? allFavorites;
  ChangeListpage(int index) {
    return pages[index];
  }

  Changepage(index) {
    page = index;
    emit(Changepagesuccessfully());
  }

  ChangeNevBar(index) {
    page = index;
    navbar.currentState?.setPage(index);
    emit(ChangeNevBarsuccessfully());
  }

  SelectItem(int index) {
    cubit!.myCart!.data!.cartItems[index].selectItem =
        !cubit!.myCart!.data!.cartItems[index].selectItem;
    emit(SelectItemCart());
  }

  plus(int index) {
    if (cubit!.myCart!.data!.cartItems[index].quantity < 9) {
      cubit!.myCart!.data!.cartItems[index].quantity++;
      emit(PlusCounter());
    }
  }

  minus(int index) {
    if (cubit!.myCart!.data!.cartItems[index].quantity > 1) {
      cubit!.myCart!.data!.cartItems[index].quantity--;
      emit(MinusCounter());
    }
  }

  SignUp(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    emit(registerLoadinge());
    await DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      emit(registerSuccess());
      result = value.data;
    }).catchError((onError) {
      emit(registerError(onError.toString()));
    });
  }

  userLogin({required String email, required String password}) async {
    emit(loginLoadinge());
    await DioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value) {
      loginmodel = loginModel.formjeson(jeson: value.data);

      emit(loginSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(loginError(onError.toString()));
    });
  }

  HomeProducts({required String token}) async {
    emit(ProductsLoading());
    await DioHelper.getData(url: HOME, token: token).then((value) {
      print(value.data);
      homemodel = HomeModel.fromjeson(jeson: value.data);
      emit(GetProductsSuccessfuly());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetProductsError(onError.toString()));
    });
  }

  UpdateProfile() async {
    emit(UpdateLoadinge());
    await DioHelper.Update(url: UPDATE, data: {
      'name': loginmodel?.data?.name,
      'phone': loginmodel?.data?.phone,
      'email': loginmodel?.data?.email,
      'password': loginmodel?.data?.password,
      'image': loginmodel?.data?.image,
    }).then((value) {
      emit(UpdateSuccess());
      print(value.data);
    }).catchError((onError) {
      emit(UpdateError(onError.toString()));
    });
  }

  AddToCart({required productId, required String token}) async {
    emit(LoadingCart());
    await DioHelper.postData(
            url: CART, data: {'product_id': productId}, token: token)
        .then((value) {
      emit(AddToCartSuccessful());
      print(value.data);
    }).catchError((onError) {
      emit(AddToCartError(onError));
    });
  }

  GetCart({required String token}) async {
    emit(LoadingCart());
    await DioHelper.getData(url: CART, token: token).then((value) {
      myCart = CartInfo.fromjeson(jeson: value.data);

      emit(GetCartSuccessfuly());
    }).catchError((onError) {
      emit(GetCartError(onError.toString()));
    });
  }

  ChangeFavorite(int index, bool search) {
    if (!search)
      cubit!.homemodel!.data!.products[index].inFavorites =
          !cubit!.homemodel!.data!.products[index].inFavorites!;
    else
      cubit!.results!.data!.products[index].inFavorites =
          !cubit!.results!.data!.products[index].inFavorites!;
    emit(ChangeStateFavorite());
  }

  AddToFavorite({required int productID}) async {
    emit(LoadingFavorite());

    await DioHelper.postData(
            url: Fav,
            data: {'product_id': productID},
            token: cubit!.loginmodel!.data!.token)
        .then((value) {
      emit(AddToCartSuccessful());
    }).catchError((onError) {
      emit(AddToFavoriteError(onError.toString()));
    });
  }

  GetAllFavorites({required String token}) async {
    emit(LoadingFavorite());

    await DioHelper.getData(url: Fav, token: token).then((value) {
      allFavorites = Favoritemodel.fromjeson(jeson: value.data);
      emit(GetFavoriteSuccessful());
    }).catchError((onError) {
      emit(GetFavoriteError(onError.toString()));
    });
  }

  DeleteCart({required String token}) async {
    emit(LoadingDelete());
    await DioHelper.Delete(url: delcart, token: token).then((value) {
      emit(DeleteCartSuccess());
      print(value.data);
    }).catchError((onError) {
      emit(DeleteCartError(onError.toString()));
    });
  }

  Search({required String text, required String token}) async {
    emit(LoadingSearch());
    await DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      results = SearchModel.fromjeson(jeson: value.data);
      emit(SearchStateSuccessful());
      print(value.data);
    }).catchError((onError) {
      emit(SearchStateError(onError.toString()));
    });
  }
}
