import 'package:mystocks_ui/model/asset_data.dart';

class AssetDataListEntity {
  final List<AssetData> assetData;

  AssetDataListEntity({required this.assetData});

  factory AssetDataListEntity.fromJson(Map<String, dynamic> json) {
    var assetDataFromJson = json['assetData'] as List;
    List<AssetData> assetDataList = assetDataFromJson.map((transactionsJson) => AssetData.fromJson(transactionsJson)).toList();
    return AssetDataListEntity(
        assetData: assetDataList,
    );
  }
}