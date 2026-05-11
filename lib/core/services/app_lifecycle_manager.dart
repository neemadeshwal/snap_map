import 'package:flutter/material.dart';

class AppLifecycleManager extends WidgetsBindingObserver {
  static final AppLifecycleManager _instance = AppLifecycleManager._internal();

  factory AppLifecycleManager() {
    return _instance;
  }

  AppLifecycleManager._internal();

  VoidCallback? onAppResumed;
  VoidCallback? onAppPaused;

  DateTime? _pauseTime;
  bool _isInitialized = false;

  void init() {
    if (!_isInitialized) {
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;
      print("App cycle manager initialized");
    }
  }

  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
    }
    _isInitialized = false;
    print("App cycle manager removed");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App lifecycle changed: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground — do NOT clear _pauseTime here; the auth
        // check runs async and must read pause duration first (see resetPauseTime after check).

        final pauseSnapshot = _pauseTime;
        final secondsBackground = pauseSnapshot == null
            ? null
            : DateTime.now().difference(pauseSnapshot).inSeconds;

        debugPrint(
          '[BIOMETRIC_DEBUG] resumed: pauseTime=$pauseSnapshot '
          'backgroundSeconds=$secondsBackground — scheduling onAppResumed',
        );
        onAppResumed?.call();
        break;

      case AppLifecycleState.paused:
        // App went to background
        print('[APP PAUSED] Record pause time');
        _pauseTime = DateTime.now();
        onAppPaused?.call();
        break;

      case AppLifecycleState.inactive:
        // App is inactive (transitioning states)
        print('[APP INACTIVE]');
        break;

      case AppLifecycleState.detached:
        // App is being terminated
        print('[APP DETACHED]');
        break;

      case AppLifecycleState.hidden:
        // App is hidden (rare state on some platforms)
        print('[APP HIDDEN]');
        break;
    }
  }
  // check if app was in backgrround for longer than threshold

  bool shouldRequireReAuth({Duration threshold = const Duration(minutes: 5)}) {
    if (_pauseTime == null) {
      debugPrint(
        '[BIOMETRIC_DEBUG] shouldRequireReauth: false (no _pauseTime — '
        'never paused this session, or already reset after last check)',
      );
      return false;
    }

    final now = DateTime.now();
    final difference = now.difference(_pauseTime!);
    final shouldReauth = difference > threshold;

    debugPrint(
      '[BIOMETRIC_DEBUG] shouldRequireReauth: paused ${difference.inSeconds}s '
      '(threshold ${threshold.inSeconds}s) => $shouldReauth',
    );

    return shouldReauth;
  }

  // Get how long app was paused in seconds

  int getBackgroundDurationSeconds() {
    if (_pauseTime == null) return 0;

    return DateTime.now().difference(_pauseTime!).inSeconds;
  }

  void resetPauseTime() {
    _pauseTime = null;
  }

  void recordUserActivity() {
    // When user interacts with the app, reset the pause time
    // This prevents session timeout when user is actively using the app
    _pauseTime = null;
    debugPrint('[USER_ACTIVITY] User interacted with app - pause time reset');
  }
}
