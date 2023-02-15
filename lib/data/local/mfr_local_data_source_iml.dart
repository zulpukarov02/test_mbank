import 'dart:convert';

import 'package:mbank_test/core/exception.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/local/mfr_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedMfr = 'cachedMfr';

class MfrLocalDataSourceImpl implements MfrLocalDataSource {
  final SharedPreferences sharedPreferences;

  MfrLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Mfr>> getMfrFromCache() {
    final jsonMfrList = sharedPreferences.getStringList(cachedMfr);
    if (jsonMfrList!.isNotEmpty) {
      return Future.value(
          jsonMfrList.map((mfr) => Mfr.fromJson(json.decode(mfr))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> mfrToCache(List<Mfr> mfrs) {
    final List<String> jsonMfrList =
        mfrs.map((mfr) => json.encode(mfr.toJson())).toList();

    sharedPreferences.setStringList(cachedMfr, jsonMfrList);
    print('Mfr write to Cache: ${jsonMfrList.length}');
    return Future.value(jsonMfrList);
  }
}
