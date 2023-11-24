class GempaModel {
  Infogempa? infogempa;

  GempaModel({this.infogempa});

  GempaModel.fromJson(Map<String, dynamic> json) {
    infogempa = json['Infogempa'] != null
        ? Infogempa.fromJson(json['Infogempa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (infogempa != null) {
      data['Infogempa'] = infogempa!.toJson();
    }
    return data;
  }
}

class Infogempa {
  List<Gempa>? gempa;

  Infogempa({this.gempa});

  Infogempa.fromJson(Map<String, dynamic> json) {
    if (json['gempa'] != null) {
      gempa = <Gempa>[];
      json['gempa'].forEach((v) {
        gempa!.add(Gempa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gempa != null) {
      data['gempa'] = gempa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gempa {
  String? tanggal;
  String? jam;
  String? dateTime;
  String? coordinates;
  String? lintang;
  String? bujur;
  String? magnitude;
  String? kedalaman;
  String? wilayah;
  String? potensi;

  Gempa(
      {this.tanggal,
      this.jam,
      this.dateTime,
      this.coordinates,
      this.lintang,
      this.bujur,
      this.magnitude,
      this.kedalaman,
      this.wilayah,
      this.potensi});

  Gempa.fromJson(Map<String, dynamic> json) {
    tanggal = json['Tanggal'];
    jam = json['Jam'];
    dateTime = json['DateTime'];
    coordinates = json['Coordinates'];
    lintang = json['Lintang'];
    bujur = json['Bujur'];
    magnitude = json['Magnitude'];
    kedalaman = json['Kedalaman'];
    wilayah = json['Wilayah'];
    potensi = json['Potensi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Tanggal'] = tanggal;
    data['Jam'] = jam;
    data['DateTime'] = dateTime;
    data['Coordinates'] = coordinates;
    data['Lintang'] = lintang;
    data['Bujur'] = bujur;
    data['Magnitude'] = magnitude;
    data['Kedalaman'] = kedalaman;
    data['Wilayah'] = wilayah;
    data['Potensi'] = potensi;
    return data;
  }
}