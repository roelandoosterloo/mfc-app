import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ModelHelpers {
  ModelHelpers._();

  static Future<List<T?>> listAll<T extends Model>(
      GraphQLRequest<PaginatedResult<T>> request) async {
    GraphQLResponse<PaginatedResult<T>> response =
        await Amplify.API.query(request: request).response;
    if (response.errors.isNotEmpty) {
      Sentry.captureMessage(response.errors.map((e) => e.message).join(","));
      return <T>[];
    }

    List<T?> result = response.data?.items ?? [];

    while (response.data?.hasNextResult ?? false) {
      response = await Amplify.API
          .query(request: response.data!.requestForNextResult!)
          .response;
      if (response.errors.isNotEmpty) {
        Sentry.captureMessage(response.errors.map((e) => e.message).join(", "));
        return <T>[];
      }

      result.addAll(response.data?.items ?? []);
    }

    return result;
  }

  static Future<T?> get<T extends Model>(GraphQLRequest<T> request) async {
    GraphQLResponse<T> response =
        await Amplify.API.query(request: request).response;
    if (response.errors.isNotEmpty) {
      Sentry.captureMessage(response.errors.map((e) => e.message).join(","));
      return null;
    }
    return response.data;
  }

  static Future<bool> update<T extends Model>(GraphQLRequest<T> request) async {
    GraphQLResponse<T> response =
        await Amplify.API.mutate(request: request).response;
    if (response.errors.isNotEmpty) {
      Sentry.captureMessage(response.errors.map((e) => e.message).join(","));
      return false;
    }
    return true;
  }

  static Future<T?> create<T extends Model>(GraphQLRequest<T> request) async {
    GraphQLResponse<T> response =
        await Amplify.API.mutate(request: request).response;
    if (response.errors.isNotEmpty) {
      Sentry.captureMessage(response.errors.map((e) => e.message).join(","));
      return null;
    }
    return response.data;
  }
}
