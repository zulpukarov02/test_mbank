import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_cubit.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_state.dart';
import 'package:mbank_test/presentation/widgets/mfr_list_tile.dart';

class MfrListWidget extends StatelessWidget {
  final scrollController = ScrollController();
  MfrListWidget({Key? key}) : super(key: key);

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
        return _loadingIndicator();
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
            return MfrListTile(mfr: mfrs[index]);
          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
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

  Widget _loadingIndicator() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child:  Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(radius: 15,),
      ),
    );
  }
}
