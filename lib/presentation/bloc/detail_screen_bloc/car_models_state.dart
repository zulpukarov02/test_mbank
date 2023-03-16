import 'package:mbank_test/data/entities/model.dart';

abstract class CarModelsState {
  const CarModelsState();
}

class CarModelsEmptyState extends CarModelsState {}

class CarModelsLoadingState extends CarModelsState {}

class CarModelsLoadedState extends CarModelsState {
  final List<Model> models;

  const CarModelsLoadedState({required this.models});
}

