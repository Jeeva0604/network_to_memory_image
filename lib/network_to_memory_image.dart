import 'dart:typed_data'; // Import for Uint8List, which represents a list of unsigned 8-bit integers.
import 'package:flutter/widgets.dart'; // Import for debugPrint, used for logging debug messages.
import 'package:http/http.dart' as http; // Import for making HTTP requests.

class NetworkToMemoryImage {
  /// Fetches a single network image and returns it as a [Uint8List].
  ///
  /// Parameters:
  /// - [url]: The URL of the image to fetch.
  ///
  /// Returns:
  /// - A [Uint8List] containing the image data if the request is successful.
  /// - Returns `null` if the request fails or the image cannot be loaded.
  static Future<Uint8List?> loadSingle(String url) async {
    try {
      // Send an HTTP GET request to the provided URL.
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // Return the image data as a Uint8List.
        return response.bodyBytes;
      } else {
        // Log an error message if the request fails.
        debugPrint(
            "Error: Failed to load image (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      // Log any exceptions that occur during the request.
      debugPrint("Error: $e");
    }
    // Return null if the image cannot be loaded.
    return null;
  }

  /// Fetches multiple network images and returns a list of [Uint8List].
  ///
  /// Parameters:
  /// - [urls]: A list of URLs of the images to fetch.
  ///
  /// Returns:
  /// - A list of [Uint8List?] containing the image data for each URL.
  /// - If an image cannot be loaded, its corresponding entry in the list will be `null`.
  static Future<List<Uint8List?>> loadMultiple(List<String> urls) async {
    // Initialize an empty list to store the fetched images.
    List<Uint8List?> images = [];

    // Iterate through each URL in the provided list.
    for (String url in urls) {
      // Fetch the image using the `loadSingle` method and add it to the list.
      images.add(await loadSingle(url));
    }

    // Return the list of fetched images.
    return images;
  }
}
