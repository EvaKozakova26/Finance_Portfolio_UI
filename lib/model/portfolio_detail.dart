class PortfolioDetail {
  
  final String symbol;
  final String fullName;
  final String sharePercentageHistoric;
  final String sharePercentageCurrent;

  PortfolioDetail({required this.symbol, required this.fullName, required this.sharePercentageHistoric, required this.sharePercentageCurrent});

  @override
  String toString() {
    return 'PortfolioDetail[symbol=$symbol, fullName=$fullName, sharePercentageHistoric=$sharePercentageHistoric, sharePercentageTotal=$sharePercentageCurrent, ]';
  }

  factory PortfolioDetail.fromJson(Map<String, dynamic> json) {
    return PortfolioDetail(
        symbol: json['symbol'],
        fullName: json['fullName'],
        sharePercentageHistoric: json['sharePercentageHistoric'],
        sharePercentageCurrent: json['sharePercentageCurrent']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'fullName': fullName,
      'sharePercentageHistoric': sharePercentageHistoric,
      'sharePercentageTotal': sharePercentageCurrent
     };
  }

  static List<PortfolioDetail> listFromJson(List<dynamic> json) {
    return json.map((value) => new PortfolioDetail.fromJson(value)).toList();
  }

  static Map<String, PortfolioDetail> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PortfolioDetail>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PortfolioDetail.fromJson(value));
    }
    return map;
  }
}

