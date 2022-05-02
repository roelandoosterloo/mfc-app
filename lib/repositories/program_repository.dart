import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/course/Membership.dart';
import 'package:mfc_app/models/course/Program.dart';

class ProgramRepository {
  List<Program> _programCache = [];

  Stream<List<Program>> listProgramsForSale() async* {
    if (_programCache.isNotEmpty) {
      yield _programCache;
    }
    String graphQLDocument = '''
    query ListPrograms {
      listPrograms(
        filter: {isForSale: {eq: true}}
      ) {
        items {
          id
          name
          description
          imageUrl
          isForSale
          price
          productStoreId
          productUrl
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

    List<dynamic> items = json["listPrograms"]["items"];
    List<Program> programs = items.map((it) => Program.fromJson(it)).toList();
    yield programs;
    _programCache = programs;
  }

  Future<List<Membership>> listMemberships() async {
    String graphQLDocument = '''
    query ListMemberships {
      listMemberships{
        items {
          id
          programId
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
    List<dynamic> items = json["listMemberships"]["items"];
    List<Membership> memberships =
        items.map((it) => Membership.fromJson(it)).toList();
    return memberships;
  }

  Future<bool> createMembership(String productId, String purchaseId) async {
    String graphQLDocument = '''
    mutation purchaseProgram {
      purchaseProgram(
        productId: "$productId",
        transactionId: "$purchaseId"
      )
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    await op.response;
    return true;
  }
}
