import 'package:mystocks_ui/model/portfolio_detail.dart';

class PortfolioDetailListEntity {
  
  List<PortfolioDetail> portfolioDetails = [];
  
  PortfolioDetailListEntity();

  @override
  String toString() {
    return 'PortfolioDetailListEntity[transactions=$portfolioDetails, ]';
  }

  PortfolioDetailListEntity.fromJson(Map<String, dynamic> json) {
    portfolioDetails =
      PortfolioDetail.listFromJson(json['portfolioDetails']);
  }

  Map<String, dynamic> toJson() {
    return {
      'portfolioDetails': portfolioDetails
     };
  }

  static List<PortfolioDetailListEntity> listFromJson(List<dynamic> json) {
    return json.map((value) => new PortfolioDetailListEntity.fromJson(value)).toList();
  }

  static Map<String, PortfolioDetailListEntity> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PortfolioDetailListEntity>();
    if (json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PortfolioDetailListEntity.fromJson(value));
    }
    return map;
  }
}

