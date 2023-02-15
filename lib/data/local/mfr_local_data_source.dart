import 'package:mbank_test/data/entities/mfr.dart';

abstract class MfrLocalDataSource {
  Future<List<Mfr>> getMfrFromCache();

  Future<void> mfrToCache(List<Mfr> persons);
}
