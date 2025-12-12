import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:developer' as dev;

class GoogleAds {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  VoidCallback? _onAdDismissed;

  /// Reklam yükle. onAdDismissed -> reklam kapandığında çağrılacak.
  void loadInterstitialAd({
    bool showAfterLoad = false,
    VoidCallback? onAdDismissed,
  }) {
    _onAdDismissed = onAdDismissed;

    // Debug/test id kullanılıyor. Prod'da kendi adUnitId'nizi koyun.
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          dev.log("🔥 AD LOADED!", name: "ADS");
          debugPrint('[GoogleAds] Interstitial loaded.');
          _interstitialAd = ad;
          _isAdLoaded = true;

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdShowedFullScreenContent: (InterstitialAd ad) {
                  debugPrint('[GoogleAds] Ad showed full screen content.');
                },
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                  debugPrint('[GoogleAds] Ad dismissed full screen content.');
                  try {
                    ad.dispose();
                  } catch (_) {}
                  _interstitialAd = null;
                  _isAdLoaded = false;

                  // Kullanıcı tanımlı callback
                  try {
                    _onAdDismissed?.call();
                  } catch (_) {}
                },
                onAdFailedToShowFullScreenContent:
                    (InterstitialAd ad, AdError error) {
                      debugPrint('[GoogleAds] Ad failed to show: $error');
                      try {
                        ad.dispose();
                      } catch (_) {}
                      _interstitialAd = null;
                      _isAdLoaded = false;
                    },
              );

          if (showAfterLoad) {
            showInterstitialAd();
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('[GoogleAds] Ad failed to load with error: $error');
          _isAdLoaded = false;
        },
      ),
    );
  }

  /// Reklamı göster (yüklüyse). Yüklü değilse tekrar yüklemeyi tetikler.
  void showInterstitialAd() {
    if (_interstitialAd != null && _isAdLoaded) {
      try {
        _interstitialAd!.show();
      } catch (e) {
        debugPrint('[GoogleAds] Error while showing ad: $e');
      }
    } else {
      debugPrint('[GoogleAds] Ad is not loaded yet, loading now...');
      // Hemen yeniden yükle, gösterim başarısızsa sonraki defada hazır olur
      loadInterstitialAd(showAfterLoad: false, onAdDismissed: _onAdDismissed);
    }
  }

  /// Reklamın yüklü olup olmadığını dışarıya bildir
  bool get isLoaded => _isAdLoaded;

  void dispose() {
    try {
      _interstitialAd?.dispose();
    } catch (_) {}
    _interstitialAd = null;
    _isAdLoaded = false;
    _onAdDismissed = null;
  }
}
