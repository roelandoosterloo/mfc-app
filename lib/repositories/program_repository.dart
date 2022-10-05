import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Membership.dart';
import 'package:mfc_app/models/Program.dart';

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

  Future<Membership?> getMembership(String programId) async {
    String graphqLDocument = '''
    query ListMemberships {
      listMemberships(filter: {programId: {eq: "$programId"}}){
        items {
          id
          programId
        }
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(document: graphqLDocument),
    );
    GraphQLResponse response = await op.response;
    if (response.data != null && response.errors.length == 0) {
      Map<String, dynamic> json = jsonDecode(response.data);
      List<dynamic> items = json["listMemberships"]["items"];
      if (items.isEmpty) {
        return null;
      }
      List<Membership> memberships =
          items.map((it) => Membership.fromJson(it)).toList();
      return memberships.first;
    }
    return null;
  }

  Future<bool> createMembership(String productId, String purchaseId) async {
    Membership? membership = await getMembership(productId);
    if (membership != null) {
      return true;
    }
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
