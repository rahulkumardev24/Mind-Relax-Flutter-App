class AppConstants {
  static const String appName = 'Mind Relax';
  static const String appVersion = '1.0.0';

  // Focus timer durations
  static const int focusDuration = 25 * 60; // 25 minutes in seconds
  static const int breakDuration = 5 * 60; // 5 minutes in seconds

  // Breathing exercise durations
  static const List<int> breathingDurations = [60, 180, 300]; // 1, 3, 5 minutes

  // Sleep timer options
  static const List<int> sleepTimerOptions = [5, 10, 15, 30, 45, 60]; // minutes

  // Ad IDs (replace with your actual ad unit IDs)
  static const String bannerAdId = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitialAdId = 'ca-app-pub-3940256099942544/1033173712';
  static const String rewardedAdId = 'ca-app-pub-3940256099942544/5224354917';
}