import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_cubit.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_state.dart';
import 'package:mbank_test/presentation/widgets/custom_loading_indicator.dart';

class MfrListWidget extends StatelessWidget {
  final scrollController = ScrollController();
  final Function selectMfr;

  MfrListWidget({Key? key, required this.selectMfr}) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<MainScreenCubit>().loadMfrs();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
      List<Mfr> mfrs = [];
      bool isLoading = false;
      if (state is MainScreenLoading && state.isFirstFetch) {
        return const CustomLoadingIndicator();
      } else if (state is MainScreenLoading) {
        mfrs = state.oldMfrs;
        isLoading = true;
      } else if (state is MainScreenLoaded) {
        mfrs = state.mfrs;
      }
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < mfrs.length) {
            return MfrListTile(
              mfr: mfrs[index],
              selectMfr: selectMfr,
            );
          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return const CustomLoadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 20,
            color: Colors.grey[400],
          );
        },
        itemCount: mfrs.length + (isLoading ? 1 : 0),
      );
    });
  }


}

class MfrListTile extends StatelessWidget {
  final Mfr mfr;
  final Function selectMfr;

  const MfrListTile({
    Key? key,
    required this.mfr,
    required this.selectMfr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectMfr(mfr);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white54),
          child: Row(
            children: [
              Text(
                mfr.id.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mfr.country,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      mfr.mfrName,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
