class ChangeFavoritesModel{
  bool? status;
  String? message;
  ChangeFavoritesModel.fromJson(Map<dynamic,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}