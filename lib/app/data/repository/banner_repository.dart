import 'package:flutter/foundation.dart';
import 'package:lms/app/core/values/urls.dart';
import 'package:lms/app/data/models/banner.dart';
import 'package:lms/app/data/services/dio_client.dart';

class BannerRepository {
  final DioClient dioClient;

  BannerRepository(this.dioClient);

  @override
  Future<List<BannerData>> getBanners({int? limit}) async {
    try {
      Map<String, dynamic>? queryParams;
      if (limit != null) {
        queryParams = {"limit": limit};
      }
      final result =
          await dioClient.get(Urls.banners, queryParameters: queryParams);

      BannerResponse res = BannerResponse.fromJson(result);
      return res.data ?? [];
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getBanners: $e, $stackTrace');
      }
      return [];
    }
  }
}
