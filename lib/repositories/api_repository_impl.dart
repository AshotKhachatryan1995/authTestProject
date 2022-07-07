import 'dart:convert';

import 'package:auth_test_project/blocs/constants/app_urls.dart';
import 'package:auth_test_project/models/brewery.dart';
import 'package:auth_test_project/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> loadData() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.fetchUrl));

      if (response.statusCode == 200) {
        final dataList = jsonDecode(response.body) as List;
        final items = dataList.map((e) => Brewery.fromJson(e)).toList();

        return items;
      } else {
        throw Exception('status code is ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
