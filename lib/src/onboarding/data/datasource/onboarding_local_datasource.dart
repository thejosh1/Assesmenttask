import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class OnboardingLocalDataSrcImpl extends OnboardingLocalDataSource {
  const OnboardingLocalDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try{
      await _prefs.setBool(kFirstTimerKey, false);
    } catch(e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async{
    try {
      return _prefs.getBool(kFirstTimerKey)??true;
    } catch(e) {
      throw CacheException(message: e.toString());
    }

  }

}
