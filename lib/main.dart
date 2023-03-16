import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/core/network_info.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/local/mfr_local_data_source_iml.dart';
import 'package:mbank_test/data/remote/api_service_impl.dart';
import 'package:mbank_test/presentation/bloc/detail_screen_bloc/car_models_bloc.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_cubit.dart';
import 'package:mbank_test/presentation/screens/detail_screen.dart';
import 'package:mbank_test/presentation/screens/main_screen.dart';
import 'package:mbank_test/repo/mfr_repo.dart';
import 'package:mbank_test/repo/mfr_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllRoutes {
  static const String main = '/';
  static const String detail = '/detail';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final apiService = ApiServiceImpl();
  final networkInfo = NetworkInfoImpl();
  final mfrLocalDataSourceImpl =
      MfrLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final mfrRepo = MfrRepoImpl(
    apiService: apiService,
    networkInfo: networkInfo,
    mfrLocalDataSource: mfrLocalDataSourceImpl,
  );
  runApp(MyApp(
    mfrRepo: mfrRepo,
  ));
}

class MyApp extends StatefulWidget {
  final MfrRepo mfrRepo;

  const MyApp({
    super.key,
    required this.mfrRepo,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Mfr? _mfr;
  String thisRoute = AllRoutes.main;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenCubit>(
            create: (context) => MainScreenCubit(
                  mfrRepo: widget.mfrRepo,
                )..loadMfrs()),
        BlocProvider<CarModelsBloc>(
            create: (context) => CarModelsBloc(
                  mfrRepo: widget.mfrRepo,
                )),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Navigator(
            pages: [
              MaterialPage(
                child: MainScreen(
                  selectMfr: (mfr) {
                    setState(() {
                      _mfr = mfr;
                    });
                  },
                ),
              ),
              if (_mfr != null)
                MaterialPage(
                  child: DetailScreen(
                    mfr: _mfr!,
                  ),
                  key: DetailScreen.valueKey,
                )
            ],
            onPopPage: (route, result) {
              final page = route.settings as MaterialPage;
              if (page.key == DetailScreen.valueKey) {
                _mfr = null;
              }
              return route.didPop(result);
            },
          )),
    );
  }
}
