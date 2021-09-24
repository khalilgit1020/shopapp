class HomeModel{
     bool? status;
   late HomeData data;

  HomeModel.fromJson(Map<dynamic,dynamic> json){
    status = json['status'];
    data  =HomeData.fromJson(json['data']);
  }

}

class HomeData{

  List<BannerModel>? banners=[];
  List<ProductsModel>? products=[];

  HomeData.fromJson(Map<dynamic,dynamic> json){

    json['banners'].forEach((element){
      banners!.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element){
      products!.add(ProductsModel.fromJson(element));
    });

  }
}

class BannerModel{

  late int id;
  late String image;

  BannerModel.fromJson(Map<dynamic,dynamic> json){

    id = json['id'];
    image = json['image'];

  }

}

class ProductsModel{

  late int? id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool? inFavourites;
  late bool? inCart;

  ProductsModel.fromJson(Map<dynamic,dynamic> json){

    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];

  }


}