import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/entities/model.dart';

abstract class MfrRepo {
  Future<List<Mfr>?> getMfrs(int page);

  Future<List<Model>> getModels(int makeID);
}
