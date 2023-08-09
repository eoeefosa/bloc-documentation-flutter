import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('CacheClient', () {
    test('can write and read a value for a given key', () {
      final cached = CacheClient();
      const key = '__key__';
      const value = '__value__';
      expect(cached.read(key: key), isNull);
      cached.write(key: key, value: value);
      expect(cached.read(key: key), equals(value));
    });
  });
}
