abstract class Status {}

class intiState extends Status {}

class Changepagesuccessfully extends Status {}

class ChangeNevBarsuccessfully extends Status {}

class registerLoadinge extends Status {}

class registerSuccess extends Status {}

class registerError extends Status {
  final Error;
  registerError(this.Error);
}

class loginLoadinge extends Status {}

class loginSuccess extends Status {}

class loginError extends Status {
  final Error;
  loginError(this.Error);
}

class ProductsLoading extends Status {}

class GetProductsSuccessfuly extends Status {}

class GetProductsError extends Status {
  final error;
  GetProductsError(this.error);
}

class UpdateLoadinge extends Status {}

class UpdateSuccess extends Status {}

class UpdateError extends Status {
  final Error;
  UpdateError(this.Error);
}

class LoadingCart extends Status {}

class AddToCartSuccessful extends Status {}

class AddToCartError extends Status {
  final error;
  AddToCartError(this.error);
}

class GetCartSuccessfuly extends Status {}

class GetCartError extends Status {
  final error;
  GetCartError(this.error);
}

class PlusCounter extends Status {}

class MinusCounter extends Status {}

class SelectItemCart extends Status {}

class ChangeStateFavorite extends Status {}

class LoadingFavorite extends Status {}

class AddToFavoriteSuccessful extends Status {}

class AddToFavoriteError extends Status {
  final error;
  AddToFavoriteError(this.error);
}

class GetFavoriteSuccessful extends Status {}

class GetFavoriteError extends Status {
  final error;
  GetFavoriteError(this.error);
}

class LoadingDelete extends Status {}

class DeleteCartSuccess extends Status {}

class DeleteCartError extends Status {
  final error;
  DeleteCartError(this.error);
}

class LoadingSearch extends Status {}

class SearchStateSuccessful extends Status {}

class SearchStateError extends Status {
  final error;
  SearchStateError(this.error);
}
