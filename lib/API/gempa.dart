class GempaModel {
  Infogempa? infogempa;

  GempaModel({this.infogempa});

  GempaModel.fromJson(Map<String, dynamic> json) {
    infogempa = json['Infogempa'] != null
        ? new Infogempa.fromJson(json['Infogempa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infogempa != null) {
      data['Infogempa'] = this.infogempa!.toJson();
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
        gempa!.add(new Gempa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gempa != null) {
      data['gempa'] = this.gempa!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tanggal'] = this.tanggal;
    data['Jam'] = this.jam;
    data['DateTime'] = this.dateTime;
    data['Coordinates'] = this.coordinates;
    data['Lintang'] = this.lintang;
    data['Bujur'] = this.bujur;
    data['Magnitude'] = this.magnitude;
    data['Kedalaman'] = this.kedalaman;
    data['Wilayah'] = this.wilayah;
    data['Potensi'] = this.potensi;
    return data;
  }
}