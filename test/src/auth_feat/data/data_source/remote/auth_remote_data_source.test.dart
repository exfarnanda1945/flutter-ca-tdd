import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/core/errors/server_error.dart';
import 'package:tdd_flutter/core/utils/constants.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source.dart';
import 'package:tdd_flutter/src/auth_feat/data/data_source/remote/auth_remote_data_source_impl.dart';

import 'mock_http_client.dart';

void main() {
  late http.Client httpClient;
  late AuthRemoteDataSource authRemoteDs;

  setUp(() {
    httpClient = MockHttpClient();
    authRemoteDs = AuthRemoteDataSourceImpl(httpClient);

    // Allows any and captureAny to be used on parameters of type value
    registerFallbackValue(Uri());
  });

  group("Create User", () {
    test("should complete successfully when the status code is 200 or 201",
        () async {
      when(() => httpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((invocation) async => http.Response('Success', 201));

      final call = authRemoteDs.createUser;
      // final result =authRemoteDs.createUser(createdAt: "createdAt", name: "name", avatar: "avatar");

      // Expect when call AuthRemoteDataSourceImpl.createUser, the process its completes
      expect(
          // invoke createUser
          call(createdAt: "createdAt", name: "name", avatar: "avatar"),
          completes);

      // expect(result,isA<void>());

      // Verify the body raw is a same with json raw passed when httpClient.post invoke
      verify(() => httpClient.post(Uri.parse("${Constants.BASE_URL}users"),
          body: jsonEncode({
            "createdAt": "createdAt",
            "name": "name",
            "avatar": "avatar"
          }))).called(1);

      verifyNoMoreInteractions(httpClient);
    });

    test("should complete successfully when the status code is 200 or 201",
        () async {
      when(() => httpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((invocation) async => http.Response('Success', 200));

      final result = authRemoteDs.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar");
      expect(result, isA<void>());

      verify(() => httpClient.post(Uri.parse("${Constants.BASE_URL}users"),
          body: jsonEncode({
            "createdAt": "createdAt",
            "name": "name",
            "avatar": "avatar"
          }))).called(1);

      verifyNoMoreInteractions(httpClient);
    });

    test("should throws API Exception when status code is not 200 or 201 ",
        () async {
      when(() => httpClient.post(any(), body: any(named: 'body'))).thenAnswer(
          (invocation) async => http.Response("Internal Server Error", 500));

      final call = authRemoteDs.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar");

      // we need invoke the function, because we want expect the error value
      expect(
          () async => call,
          throwsA(const ServerError(
              message: "Internal Server Error", statusCode: 500)));

      verify(() => httpClient.post(Uri.parse("${Constants.BASE_URL}users"),
          body: jsonEncode({
            "createdAt": "createdAt",
            "name": "name",
            "avatar": "avatar"
          }))).called(1);

      verifyNoMoreInteractions(httpClient);
    });

    test(
      "should throws API Exception and status code 400",
      () async {
        when(() => httpClient.post(any(), body: any(named: "body"))).thenAnswer(
            (invocation) async => http.Response("Bad Request", 400));

        final result = authRemoteDs.createUser(
            createdAt: "", name: "name", avatar: "avatar");

        expect(
            () async => result,
            throwsA(
                const ServerError(message: "Bad Request", statusCode: 400)));

        verify(() => httpClient.post(Uri.parse("${Constants.BASE_URL}users"),
                body: jsonEncode(
                    {"createdAt": "", "name": "name", "avatar": "avatar"})))
            .called(1);

        verifyNoMoreInteractions(httpClient);
      },
    );
  });
}
