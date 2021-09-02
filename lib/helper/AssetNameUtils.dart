class AssetNameUtils {

  static String? mapName(String symbol) {
    Map<String, String> nameMap = {
      'btc': "Bitcoin",
      'SOFI': "SoFi Technologies, Inc,",
      'MCD': "McDonald's Corporation",
      'SPY': "SPDR S&P 500 ETF Trust",
      'INTC': "Intel Corporation",
      'TABAK.PR': "Philip Morris CR a.s.",
      'MONET.PR': "MONETA Money Bank, a.s.",
      'CEZ.PR': "ČEZ, a. s. "
    };
    return nameMap[symbol];
  }
}