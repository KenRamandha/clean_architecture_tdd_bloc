import 'dart:convert';

import 'package:clean_rchitecture_tdd_bloc/core/errors/exception.dart';
import 'package:clean_rchitecture_tdd_bloc/core/utils/constans.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/datasources/authentification_remote_data_source.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthentificationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthentificationRemoteDatasourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group('createUser :', () {
    test('should completed successfully when the statusCode is 200 / 201',
        () async {
      when(
        () => client.post(
          any(),
          body: any(
            named: 'body',
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response('user created successfully', 201),
      );

      final methodeCall = remoteDataSource.createUser;

      expect(
        methodeCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        equals(
          completes,
        ),
      );

      verify(
        () => client.post(
          Uri.https(baseURL, createUserEndPoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when status code is not 200/201',
        () async {
      when(() => client.post(
                any(),
                body: any(named: 'body'),
              ))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
        () async => await methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          predicate((dynamic e) =>
              e is APIException &&
              e.message == 'Invalid email address' &&
              e.statusCode == 400),
        ),
      );

      verify(
        () => client.post(
          Uri.https(baseURL, createUserEndPoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers :', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<Users>] when the statusCode is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );
      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(
        () => client.get(
          Uri.https(baseURL, getUserEndPoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'should throw [APIException] when status code is not 200',
      () async {
        const tMessage = 'Server Down';

        when(() => client.get(Uri.https(baseURL, getUserEndPoint))).thenAnswer(
          (_) async => http.Response(tMessage, 500),
        );

        methodCall() => remoteDataSource.getUsers();

        expect(
          methodCall,
          throwsA(
            predicate((e) =>
                e is APIException &&
                e.message == tMessage &&
                e.statusCode == 500),
          ),
        );

        verify(
          () => client.get(
            Uri.https(baseURL, getUserEndPoint),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
