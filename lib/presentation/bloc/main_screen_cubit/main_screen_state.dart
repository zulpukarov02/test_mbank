import 'package:mbank_test/data/entities/mfr.dart';

abstract class MainScreenState {}

class MainScreenEmpty extends MainScreenState {}

class MainScreenLoading extends MainScreenState {
  final List<Mfr> oldMfrs;
  final bool isFirstFetch;

  MainScreenLoading(this.oldMfrs, {this.isFirstFetch = false});
}

class MainScreenLoaded extends MainScreenState {
  final List<Mfr> mfrs;

  MainScreenLoaded(this.mfrs);
}
