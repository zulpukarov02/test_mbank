import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/entities/model.dart';

abstract class ApiService {
  Future<List<Mfr>> getMfrs(int page);

  Future<int> getMakeID(int mfrID);

  Future<List<Model>> getModels(int makeID);
}
