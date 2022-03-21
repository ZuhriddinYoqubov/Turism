import 'dart:convert';

import 'package:mobileapp/models/restaurant_model.dart';

import 'git_model.dart';
import 'hotel_model.dart';
/// git : {"id":"a37ca999-9d85-486c-8192-e8547267195a","image":"image__9b4f9545-bc99-4787-9c55-3d9aa56cea35.jpg","languages":["uz","kz"],"inform_uz":"The intended recipient you are not the intended recipient you are not","inform_en":"Let me 🚀🚀🚀🚀🚀the following basic premise the following","inform_ru":"Hi ok thanks for the first time in the intended recipient you are not","city":"toshkent","tell":["998999666"],"price":"55525555555","date":"2022-03-05T10:58:40.793Z","reyting":0,"users":1}
/// restaurants : [{"id":"64072a2d-9b14-4d36-8cec-bcf540498a68","name":"Bizning Restoran","media":["image__07a974e9-ed04-4e26-b790-08765bd3b2c2.png"],"inform_uz":"INformUz","inform_en":"jkadsfhjkadhfjdahs","inform_ru":"IN form ru","karta":"https://goo.gl/maps/tV4zVprnkh7K6dGT7","city":"toshkent","site":null,"tell":["+9989321657","+9989898989"],"date":"2022-03-05T14:05:53.042Z","category_id":"903908cf-7f6d-424f-8c03-66d30e9347bf","reyting":0,"users":1}]
/// hotels : [{"id":"21b27bb5-48bb-42f3-8d1f-91fa035dd2ac","name":"Hhhhhhhg","media":["image__a91e2d41-f820-405f-9d7b-6333c819a735.jpg"],"inform_uz":"4gg the intended recipient you are not the intended","inform_en":"You can see the attached file is scanned image in 6","inform_ru":"If you are not the intended recipient you are not the intended","karta":"Najot Ta'lim8 71 200 11 23https://maps.app.goo.gl/mS9wmqMcsVFCpA337","city":"toshkent","site":null,"tell":["[333333333]"],"date":"2022-03-05T11:34:05.873Z","category_id":"1991edea-7d4a-49fb-b627-79b777cf54ae","reyting":0,"users":1},{"id":"f3f82f1f-8ae8-4b85-bdc9-2ca802bce09d","name":"Mehmonxona","media":["image__572fb17c-f710-48f7-8aaf-29f672d661f1.jpg"],"inform_uz":"6hh the intended recipient or an authorized agent you should have a good idea","inform_en":"The following URL to the attached file is scanned image in PDF and word to","inform_ru":"6\nI am not sure if you need any more info 😃🙂😃🙂😃😃😃😃 the intended recipient you","karta":"GG from Shahs of sunset","city":"toshkent","site":null,"tell":["[123455666]"],"date":"2022-03-06T07:28:43.357Z","category_id":"1991edea-7d4a-49fb-b627-79b777cf54ae","reyting":0,"users":1}]

BusinessAccountModel businessAccountModelFromJson(String str) => BusinessAccountModel.fromJson(json.decode(str));
String businessAccountModelToJson(BusinessAccountModel data) => json.encode(data.toJson());
class BusinessAccountModel {
  BusinessAccountModel({
      Git? git, 
      List<Restaurant>? restaurants, 
      List<Hotel>? hotels,}){
    _git = git;
    _restaurants = restaurants;
    _hotels = hotels;
}

  BusinessAccountModel.fromJson(dynamic json) {
    _git = json['git'] != null ? Git.fromJson(json['git']) : null;
    if (json['restaurants'] != null) {
      _restaurants = [];
      json['restaurants'].forEach((v) {
        _restaurants?.add(Restaurant.fromJson(v));
      });
    }
    if (json['hotels'] != null) {
      _hotels = [];
      json['hotels'].forEach((v) {
        _hotels?.add(Hotel.fromJson(v));
      });
    }
  }
  Git? _git;
  List<Restaurant>? _restaurants;
  List<Hotel>? _hotels;

  Git? get git => _git;
  List<Restaurant>? get restaurants => _restaurants;
  List<Hotel>? get hotels => _hotels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_git != null) {
      map['git'] = _git?.toJson();
    }
    if (_restaurants != null) {
      map['restaurants'] = _restaurants?.map((v) => v.toJson()).toList();
    }
    if (_hotels != null) {
      map['hotels'] = _hotels?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}