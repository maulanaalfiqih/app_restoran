import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('daftarResto', () {
    test('returns daftar resto if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      expect(ApiResto(client), isA<RestoResult>());

      test('throws an exception if the http call completes with an error', () {
        final client = MockClient();

        when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ApiResto(client), throwsException);
      });

      test('throws an exception if the http call completes with an error', () {
        final client = MockClient();

        when(client.get(
                Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ApiResto(client), throwsException);
      });
    });
  });
}
