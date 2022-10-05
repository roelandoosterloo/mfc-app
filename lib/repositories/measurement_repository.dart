import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Measurement.dart';
import 'package:mfc_app/utils/api_helper.dart';

class MeasurementRepository {
  Future<void> addMeasurement(
      DateTime date, double weight, String? note, String userName) async {
    Measurement measurement = Measurement(
        date: TemporalDate(date),
        weight: weight,
        owner: userName,
        type: "Measurement",
        note: note);
    final request = ModelMutations.create(measurement);
    Measurement? result = await ModelHelpers.create(request);
    return;
  }

  Future<List<Measurement>> listMeasurements() async {
    final request = ModelQueries.list(Measurement.classType, limit: 1000);
    List<Measurement?> result = await ModelHelpers.listAll(request);
    return result.whereType<Measurement>().toList();
  }

  Future removeMeasurement(String id) async {
    GraphQLOperation op =
        Amplify.API.mutate(request: GraphQLRequest(document: '''
    mutation deleteMeasurement {
      deleteMeasurement(input: {id: "$id"}) {
        id
      }
    }
    '''));
    GraphQLResponse response = await op.response;
    if (response.errors.isNotEmpty) {
      throw Exception("Measurement not deleted");
    }
    return;
  }
}
