import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_test/core/network_info.dart';
import 'package:mbank_test/data/local/mfr_local_data_source_iml.dart';
import 'package:mbank_test/data/remote/api_service_impl.dart';
import 'package:mbank_test/presentation/bloc/main_screen_cubit/main_screen_cubit.dart';
import 'package:mbank_test/presentation/screens/main_screen.dart';
import 'package:mbank_test/repo/mfr_repo.dart';
import 'package:mbank_test/repo/mfr_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class MyApp extends StatelessWidget {
  final MfrRepo mfrRepo;

  const MyApp({
    super.key,
    required this.mfrRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenCubit>(
            create: (context) => MainScreenCubit(
                  mfrRepo: mfrRepo,
                )..loadMfrs()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
