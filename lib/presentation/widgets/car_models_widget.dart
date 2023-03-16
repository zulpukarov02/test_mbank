import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/presentation/bloc/detail_screen_bloc/car_models_bloc.dart';
import 'package:mbank_test/presentation/bloc/detail_screen_bloc/car_models_event.dart';
import 'package:mbank_test/presentation/widgets/custom_loading_indicator.dart';

import '../bloc/detail_screen_bloc/car_models_state.dart';

class CarModelsWidget extends StatefulWidget {
  final int mfrID;

  const CarModelsWidget({Key? key, required this.mfrID}) : super(key: key);

  @override
  State<CarModelsWidget> createState() => _CarModelsWidgetState();
}

class _CarModelsWidgetState extends State<CarModelsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CarModelsBloc>().add(GetCarModelsEvent(widget.mfrID));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<CarModelsBloc, CarModelsState>(
        builder: (context, state) {
          if (state is CarModelsLoadingState) {
            return const CustomLoadingIndicator();
          } else if (state is CarModelsLoadedState) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ModelTile(text: state.models[index].name);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: state.models.length);
          } else if (state is CarModelsEmptyState) {
            return const Text("Don't have data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ModelTile extends StatelessWidget {
  final String text;

  const ModelTile({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.shade200,
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(2, 5),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
