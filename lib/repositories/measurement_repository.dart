import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementRepository {
  final FirebaseFirestore _firestore;
  final User _user;
  late CollectionReference _collection;
  final StreamController<List<Measurement>> _streamController =
      StreamController();

  MeasurementRepository({FirebaseFirestore? firestore, required User user})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _user = user {
    _collection =
        _firestore.collection('users/${_user.uid}/measurements').withConverter(
              fromFirestore: (snapshot, _) =>
                  Measurement.fromJson(snapshot.data()!),
              toFirestore: (measurement, _) =>
                  (measurement! as Measurement).toJson(),
            );
  }

  Future<void> addMeasurement(Measurement measurement) async {
    await _collection.add(measurement);
    return;
  }

  Stream<List<Measurement>> refresh() {
    return _collection
        .orderBy(
          'date',
          descending: true,
        )
        .limit(200)
        .snapshots()
        .map(
          (QuerySnapshot snapshot) =>
              (snapshot.docs.map((e) => e.data() as Measurement).toList()),
        );
  }

  void dispose() {
    _streamController.close();
  }

  Stream<List<Measurement>> measurements() =>
      _streamController.stream.asBroadcastStream();
}
