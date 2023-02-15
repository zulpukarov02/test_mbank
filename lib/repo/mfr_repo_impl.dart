import 'package:mbank_test/core/exception.dart';
import 'package:mbank_test/core/network_info.dart';
import 'package:mbank_test/core/ui_messages.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/entities/model.dart';
import 'package:mbank_test/data/local/mfr_local_data_source.dart';
import 'package:mbank_test/data/remote/api_service.dart';
import 'package:mbank_test/repo/mfr_repo.dart';

class MfrRepoImpl extends MfrRepo {
  final ApiService apiService;
  final NetworkInfo networkInfo;
  final MfrLocalDataSource mfrLocalDataSource;

  MfrRepoImpl({
    required this.apiService,
    required this.networkInfo,
    required this.mfrLocalDataSource,
  });

  @override
  Future<List<Mfr>?> getMfrs(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMfrs = await apiService.getMfrs(page);
        mfrLocalDataSource.mfrToCache(remoteMfrs);
        return remoteMfrs;
      } on ServerException {
        UIMessages.showErrToast('Server error');
        return null;
      }
    } else {
      try {
        final localMfrs = await mfrLocalDataSource.getMfrFromCache();
        return localMfrs;
      } on CacheException {
        UIMessages.showErrToast('Cache error');
        return null;
      }
    }
  }

  @override
  Future<List<Model>> getModels(int makeID) {
    // TODO: implement getModels
    throw UnimplementedError();
  }
}
