import 'package:hive/hive.dart';

part 'report.g.dart';

@HiveType(typeId: 1)
class Report {
  Report({required this.kerusakan,required  this.wilayah,required  this.tanggal});
  @HiveField(0)
  String kerusakan;

  @HiveField(1)
  String wilayah;

  @HiveField(2)
  String tanggal;
}
