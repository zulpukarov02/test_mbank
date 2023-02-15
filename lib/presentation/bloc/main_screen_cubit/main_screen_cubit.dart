// ignore_for_file: constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_state.dart';
import 'package:mbank_test/repo/mfr_repo.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class MainScreenCubit extends Cubit<MainScreenState> {
  final MfrRepo mfrRepo;

  MainScreenCubit({required this.mfrRepo}) : super(MainScreenEmpty());

  int page = 1;

  void loadMfrs() async {
    if (state is MainScreenLoading) return;

    final currentState = state;

    var oldMfrs = <Mfr>[];
    if (currentState is MainScreenLoaded) {
      oldMfrs = currentState.mfrs;
    }

    emit(MainScreenLoading(oldMfrs, isFirstFetch: page == 1));

    final mfrs = await mfrRepo.getMfrs(page);
    if(mfrs != null){
      page++;
      final mfrsNew = (state as MainScreenLoading).oldMfrs;
      mfrsNew.addAll(mfrs);
      print('List length: ${mfrsNew.length.toString()}');
      emit(MainScreenLoaded(mfrsNew));
    }
  }

}