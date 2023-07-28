import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import '../models/constants_and_variables.dart';

class BannerAd extends StatelessWidget {
  const BannerAd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: Center(
        child: AdmobBanner(
          adUnitId: adBannerAndroidId,
          adSize: AdmobBannerSize.LARGE_BANNER,
          listener: (AdmobAdEvent event, Map<String, dynamic>? args) {},
        ),
      ),
    );
  }
}