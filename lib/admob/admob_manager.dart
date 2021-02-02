import 'package:firebase_admob/firebase_admob.dart';

class AdmobManager {
  BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;

  String appID = 'ca-app-pub-6660347485032552~9964956486';
  String bannerID = 'ca-app-pub-6660347485032552/3646960148';
  // String interstitialID = InterstitialAd.testAdUnitId;
  // String nativeId = NativeAd.testAdUnitId;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['게임', '옷', '페이스북', '운동', '신발', '금융', '자산', '배달', '쇼핑몰'],
    // testDevices: <String>[],
  );

  init() async {
    FirebaseAdMob.instance.initialize(appId: appID);
    _bannerAd = createBannerAd();
    // _interstitialAd = createInterstitialAd();
    // _nativeAd = createNativeAd();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerID,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //     adUnitId: interstitialID,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event is $event");
  //     },
  //   );
  // }
  // NativeAd createNativeAd() {
  //   return NativeAd(
  //     adUnitId: NativeAd.testAdUnitId,
  //     factoryId: 'adFactoryExample',
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("$NativeAd event $event");
  //     },
  //   );
  // }

  // showNativeAd() {
  //   _nativeAd
  //     ..load()
  //     ..show();
  // }

  // showInterstitialAd() {
  //   _interstitialAd
  //     ..load()
  //     ..show();
  // }

  showBannerAd() {
    _bannerAd
      ..load()
      ..show();
  }

  disposeBannerAd() {
    _bannerAd.dispose();
  }

  // disposeInterstitialAd() {
  //   _interstitialAd.dispose();
  // }

  // disposeNativeAd() {
  //   _nativeAd.dispose();
  // }
}
