import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/acontainerbloc.dart';

class AcontainerQuiz extends StatelessWidget {
  const AcontainerQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    int correctindex = 2;
    return Scaffold(
      body: BlocBuilder<ContainerBloc, int?>(builder: (context, stateindex) {
        return ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              height: 100,
              width: 200,
            ),
            ...List.generate(
              5,
              (index) => InkWell(
                onTap: () {
                  context
                      .read<ContainerBloc>()
                      .add(Optionclicked(selectedoption: index));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: stateindex != null
                        ? (stateindex == correctindex
                            ? Colors.green
                            : (index == correctindex
                                ? Colors.green
                                : Colors.red))
                        : Colors.yellow,
                    height: 50,
                    width: 200,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Color colorselected(int? value) {
    if (value == 1) {
      return Colors.green;
    } else if (value == null) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }
}
