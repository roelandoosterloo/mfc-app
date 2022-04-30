import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/models/course/Program.dart';
import 'package:mfc_app/screens/program/list/bloc/list_program_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ListProgramScreen extends StatelessWidget {
  const ListProgramScreen({Key? key}) : super(key: key);

  _onMoreInfo(Program p) async {
    if (!await launch(p.productUrl)) {
      throw "Could not open URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListProgramBloc>(context).add(ListProgramOpened());
    return BlocConsumer<ListProgramBloc, ListProgramState>(
      listener: (context, state) {
        if (state is PaymentFailed) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Programma's",
              ),
            ),
            body: (() {
              if (state is Loaded) {
                return Container(
                    child: ListView.builder(
                  itemCount: state.programs.length,
                  itemBuilder: (context, index) {
                    Program p = state.programs[index];

                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(p.name),
                            subtitle: Text(
                                "€ " + (p.price?.toStringAsFixed(2) ?? "-")),
                          ),
                          AspectRatio(
                            aspectRatio: 1.77,
                            child: Image.network(
                              p.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              p.description,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _onMoreInfo(p);
                                },
                                child: const Text('MEER INFO'),
                              ),
                              if (state.memberships
                                  .any((element) => element.programId == p.id))
                                TextButton(
                                  onPressed: null,
                                  child: Text("Al gekocht"),
                                ),
                              if (!state.memberships
                                  .any((element) => element.programId == p.id))
                                TextButton(
                                  onPressed: !(state is PaymentPending)
                                      ? () {
                                          BlocProvider.of<ListProgramBloc>(
                                                  context)
                                              .add(PurchaseProgram(p));
                                        }
                                      : null,
                                  child: (() {
                                    if (state is PaymentPending &&
                                        state.programId == p.id) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                              ),
                                            ),
                                          ),
                                          Text('BESTELLING AFRONDEN'),
                                        ],
                                      );
                                    }
                                    return Text('BESTELLEN');
                                  })(),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ));
              } else if (state is NoProgramAvailable) {
                return Container(
                  child: Text("No data"),
                );
              } else if (state is FailedLoading) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: min(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height) *
                            0.4,
                        child: Image.asset(
                          "assets/images/warning-sign.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Daar ging iets fout",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(state.error),
                    ],
                  ),
                );
              }
              return Container(child: Text("Not laoded"));
            })());
      },
    );
  }
}
