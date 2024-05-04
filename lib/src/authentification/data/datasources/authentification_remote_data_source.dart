import 'dart:convert';

import 'package:clean_rchitecture_tdd_bloc/core/errors/exception.dart';
import 'package:clean_rchitecture_tdd_bloc/core/utils/constans.dart';
// import 'package:clean_rchitecture_tdd_bloc/core/utils/typedef.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthentificationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const createUserEndPoint = '/test-api/users';
const getUserEndPoint = '/test-api/users';

class AuthentificationRemoteDatasourceImplementation
    extends AuthentificationRemoteDataSource {
  AuthentificationRemoteDatasourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // check to make sure return right data when respons code 200
    // check to make sure that it "THROWS A CUSTOM EXCEPTION" with the right message when status code is bad

    try {
      final response = await _client.post(
        Uri.https(baseURL, createUserEndPoint),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(baseURL, getUserEndPoint));

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      } else {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((userData) => UserModel.fromMap(userData)).toList();
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
