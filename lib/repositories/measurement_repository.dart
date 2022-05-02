import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementRepository {
  List<Measurement>? _measurements;

  Future<void> addMeasurement(Measurement measurement, String userName) async {
    GraphQLOperation op = Amplify.API.mutate(
      request: GraphQLRequest<String>(
        document: '''
    mutation CreateMeasurement(\$date: AWSDate!, \$weight: Float!, \$note: String, \$type: String!, \$owner: String!){
      createMeasurement(input: {
        date: \$date, 
        weight: \$weight, 
        note: \$note, 
        type: \$type, 
        owner: \$owner
      }) {
        id
      }
    }
    ''',
        variables: {
          "date": measurement.formatDate,
          "weight": measurement.weight,
          "note": measurement.note,
          "type": measurement.type,
          "owner": userName,
        },
      ),
    );
    GraphQLResponse response = await op.response;
    return;
  }

  Stream<List<Measurement>> _list({String? nextToken}) async* {
    String graphQLDocument = ''' 
    query ListMeasurements {
      getMeasurementsByDate(
        type: "Measurement",
        sortDirection: ASC,
        limit: 50,
        nextToken: ${nextToken != null ? "\"$nextToken\"" : null}
      ) {
        items {
          id
          date
          weight
          note
        }
        nextToken
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    GraphQLResponse response = await op.response;
    Map<String, dynamic> json = jsonDecode(response.data);
    String? token = json["getMeasurementsByDate"]["nextToken"];
    List<dynamic> items = json["getMeasurementsByDate"]["items"];
    List<Measurement> measurements =
        items.map((it) => Measurement.fromJson(it)).toList();
    yield measurements;
    if (token != null) {
      await for (final List<Measurement> m in _list(nextToken: token)) {
        yield m;
      }
    }
  }

  Stream<List<Measurement>> listMeasurements() async* {
    if (_measurements != null) {
      yield _measurements!;
    }
    List<Measurement> measurements = [];
    await for (List<Measurement> nextBatch in _list()) {
      measurements.addAll(nextBatch);
      yield measurements;
    }
    _measurements = measurements;
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
