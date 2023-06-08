import 'package:blocdocplay/execisecounter/colorcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerColorpage extends StatelessWidget {
  const ContainerColorpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Container colour"),
        ),
        body: BlocBuilder<ContainerColorBloc, Color>(
          builder: (context, color) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<ContainerColorBloc>().add(Wronganswer());
                  },
                  child: Container(
                    color: color,
                    height: 50,
                    width: 200,
                  ),
                ),
                ...List.generate(4, (index) {
                  return InkWell(
                    onTap: () {
                      context.read<ContainerColorBloc>().add(Correctanswer());
                    },
                    child: Container(
                      color: color,
                      height: 50,
                      width: 200,
                    ),
                  );
                })
              ],
            );
          },
        ));
  }
}
