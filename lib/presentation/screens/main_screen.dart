import 'package:flutter/material.dart';
import 'package:mbank_test/presentation/widgets/mfr_list_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.selectMfr}) : super(key: key);
  final Function selectMfr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manufacturers List"),
      ),
      body: MfrListWidget(selectMfr: selectMfr,)
    );
  }
}
