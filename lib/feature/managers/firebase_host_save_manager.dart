import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spy_scanner/feature/models/host_model.dart';

/// A simple repository responsible for saving host scan results to Firestore.
final class FirebaseHostSaveManager {
  FirebaseHostSaveManager({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Saves a list of hosts under a given user and subnet.
  Future<void> saveHosts({
    required String userId,
    required String subnet,
    required List<HostModel> hosts,
  }) async {
    final batch = _firestore.batch();
    final collectionRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('scans')
        .doc(subnet)
        .collection('hosts');

    for (final host in hosts) {
      final docRef = collectionRef.doc(host.id);
      batch.set(docRef, {
        'id': host.id,
        'address': host.address,
        'deviceName': host.deviceName,
        'mac': host.mac,
        'vendor': host.vendor,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }
}
