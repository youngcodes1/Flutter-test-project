import 'package:flutter_test_project/Core/Apis/apis.dart';
import 'package:flutter_test_project/Core/Mixins/general_mixin.dart';
import 'package:flutter_test_project/Repositories/gpt_repo.dart';
import 'package:http/http.dart' as http;

class GptService with GeneralMixin implements GptRepo {
  @override
  Future<http.Response?> getModels() async {
    // TODO: implement getModels
    http.Response? res = await get(route: gtpRoute);
    return res;
  }

  @override
  Future<http.Response?> searchChat(Map data) async {
    // TODO: implement searchChat
    http.Response? res = await post(route: searchRoute, data: data);
    return res;
  }
}
