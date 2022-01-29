import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementRepository {
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

  Future<List<Measurement>> listMeasurements() async {
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
    return measurements;
  }
}
