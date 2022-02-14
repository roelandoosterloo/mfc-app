import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementRepository {
  List<Measurement>? _measurements;

  Future<void> addMeasurement(Measurement measurement) async {
    GraphQLOperation op = Amplify.API.mutate(
      request: GraphQLRequest<String>(
        document: '''
    mutation CreateMeasurement(\$date: AWSDate!, \$weight: Float!, \$note: String, \$type: String!){
      createMeasurement(input: {date: \$date, weight: \$weight, note: \$note, type: \$type}) {
        id
      }
    }
    ''',
        variables: {
          "date": measurement.formatDate,
          "weight": measurement.weight,
          "note": measurement.note,
          "type": measurement.type,
        },
      ),
    );
    GraphQLResponse response = await op.response;
    return;
  }

  Stream<List<Measurement>> listMeasurements() async* {
    if (_measurements != null) {
      yield _measurements!;
    }
    String graphQLDocument = ''' 
    query ListMeasurements {
      getMeasurementsByDate(
        type: "Measurement",
        sortDirection: ASC
      ) {
        items {
          id
          date
          weight
          note
        }
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
    List<dynamic> items = json["getMeasurementsByDate"]["items"];
    List<Measurement> measurements =
        items.map((it) => Measurement.fromJson(it)).toList();
    yield measurements;
  }
}
