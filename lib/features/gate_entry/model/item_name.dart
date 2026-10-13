import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_name.freezed.dart';
part 'item_name.g.dart';

@freezed
class ItemName with _$ItemName {
  const factory ItemName({
    @JsonKey(name: 'item_name') required String itemName,
  }) = _ItemName;

  factory ItemName.fromJson(Map<String, Object?> json)
      => _$ItemNameFromJson(json);
}