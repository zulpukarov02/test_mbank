import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/presentation/bloc/detail_screen_bloc/car_models_event.dart';
import 'package:mbank_test/presentation/bloc/detail_screen_bloc/car_models_state.dart';
import 'package:mbank_test/repo/mfr_repo.dart';

class CarModelsBloc extends Bloc<CarModelsEvent, CarModelsState> {
  final MfrRepo mfrRepo;

  CarModelsBloc({required this.mfrRepo}) : super(CarModelsEmptyState()) {
    on<GetCarModelsEvent>((event, emit) async {
      emit(CarModelsLoadingState());
      final models = await mfrRepo.getModels(event.makeID);
      if(models != null){
        emit(CarModelsLoadedState(models: models));
      }else{
        emit(CarModelsEmptyState());
      }
    });
  }
}
