import 'package:hive/hive.dart';

part 'report.g.dart';

@HiveType(typeId: 0)
class Report extends HiveObject {
  @HiveField(0)
  late String kerusakan;

  @HiveField(1)
  late String wilayah;

  @HiveField(2)
  late String tanggal;

  @HiveField(3)
  late String imagePath;

  Report({
    required this.kerusakan,
    required this.wilayah,
    required this.tanggal,
    required this.imagePath,
  });
}
