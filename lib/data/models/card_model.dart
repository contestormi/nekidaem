import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class CardModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String row;
  @HiveField(2)
  final int? seqNum;
  @HiveField(3)
  final String text;

  CardModel({
    required this.id,
    required this.row,
    required this.seqNum,
    required this.text,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
