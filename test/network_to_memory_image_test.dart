import 'package:flutter_test/flutter_test.dart';
import 'package:network_to_memory_image/network_to_memory_image.dart';
import 'dart:typed_data';

void main() {
  test('Load single image returns null for invalid URL', () async {
    final result = await NetworkToMemoryImage.loadSingle(
        "https://invalid-url.com/image.jpg");
    expect(result, isNull);
  });

  test('Load multiple images with some invalid URLs', () async {
    final urls = [
      "https://invalid-url.com/image.jpg",
      "https://another-invalid-url.com/image.jpg",
    ];

    final result = await NetworkToMemoryImage.loadMultiple(urls);
    expect(result, isA<List<Uint8List?>>());
    expect(result.length, 2);
    expect(result[0], isNull); // Since the URL is invalid
    expect(result[1], isNull); // Also invalid
  });
}
