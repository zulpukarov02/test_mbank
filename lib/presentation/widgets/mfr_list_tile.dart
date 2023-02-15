import 'package:flutter/material.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/presentation/screens/detail_screen.dart';

class MfrListTile extends StatelessWidget {
  final Mfr mfr;

  const MfrListTile({
    Key? key,
    required this.mfr
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(mfr: mfr,),
          ),
        );
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
