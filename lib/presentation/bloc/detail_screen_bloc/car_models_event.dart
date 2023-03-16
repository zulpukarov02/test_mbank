abstract class CarModelsEvent {
  const CarModelsEvent();
}

class GetCarModelsEvent extends CarModelsEvent {
  final int makeID;

  GetCarModelsEvent(this.makeID);
}
