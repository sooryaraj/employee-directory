import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static void displaySnackBar(String message) async {
    await Future.delayed(const Duration(milliseconds: 400));
    var _snackbar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      _snackbar,
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl)) != null) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  static Widget loader() {
    return const Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        height: 40.0,
        width: 40.0,
      ),
    );
  }

  static Widget shimmer() {
    return Shimmer(
      duration: const Duration(seconds: 3), //Default value
      interval:
          const Duration(seconds: 5), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      colorOpacity: 0, //Default value
      enabled: true, //Default value
      direction: const ShimmerDirection.fromLTRB(), //Default Value
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  static Widget emptyWidget({required String title}) {
    return Center(
        child: Text(
      title,
      style: const TextStyle(
          color: Colors.black12, fontSize: 30, fontWeight: FontWeight.bold),
    ));
  }
}
