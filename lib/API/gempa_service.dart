import 'gempa_api.dart';

class GempaService {
  static GempaService instance = GempaService();
  
  Future<Map<String, dynamic>> loadGempa() {
    return GempaAPI.get("autogempa.json");
  }

  Future<Map<String, dynamic>> loadGempaTerasa() {
    return GempaAPI.get("gempadirasakan.json");
  }
  
  Future<Map<String, dynamic>> loadDaftarGempa() {
    return GempaAPI.get("gempaterkini.json");
  }
}
