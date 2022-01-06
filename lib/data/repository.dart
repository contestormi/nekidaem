import 'package:nekidaem/data/datasources/nekidaem_api.dart';
import 'package:nekidaem/data/models/card_model.dart';
import 'package:nekidaem/services/cache_serivce.dart';

class Repository {
  final NekidaemRemoteDataImpl _nekidaemAPI = NekidaemRemoteDataImpl();
  final CacheService _cacheService = CacheService();

  Future<void> getJWTToken(
      {required String username, required String password}) async {
    _cacheService.saveToken(
        await _nekidaemAPI.getJWTToken(username: username, password: password));
  }

  Future<List<CardModel>> getAllCards() async {
    if (CacheService.dataBox.isNotEmpty) {
      return CacheService.dataBox.values.toList();
    } else {
      var token = CacheService.tokenBox.get('key') as String;
      final response = await _nekidaemAPI.getAllCards(token);
      _cacheService.saveData(response);
      return response;
    }
  }

  void logout() async {
    _cacheService.clearTokenBox();
  }
}
