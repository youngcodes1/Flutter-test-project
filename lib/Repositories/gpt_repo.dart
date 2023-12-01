import 'package:http/http.dart' as http;

abstract class GptRepo {
  Future<http.Response?> getModels();

  Future<http.Response?> searchChat(Map data);
}
