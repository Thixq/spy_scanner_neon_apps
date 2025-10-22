import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spy_scanner/feature/models/base_model.dart';

/// A generic Firestore manager that can dynamically switch model types and collections.
/// Designed to work as a GetIt singleton for multiple scan history collections.
final class FirestoreHistoryManager<T extends BaseModel> {
  FirestoreHistoryManager({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  late T Function(Map<String, dynamic> json) _fromJson;
  late String _collectionPath;

  bool get _isConfigured => _collectionPath.isNotEmpty;

  /// Configure this instance for a specific model type and collection path.
  /// You must call this once before using save/get methods.
  void configure({
    required T Function(Map<String, dynamic> json) fromJson,
    required String collectionPath,
  }) {
    _fromJson = fromJson;
    _collectionPath = collectionPath;
  }

  CollectionReference<Map<String, dynamic>> get _collection {
    if (!_isConfigured) {
      throw StateError(
        'FirestoreHistoryManager is not configured. '
        'Call configure() before using it.',
      );
    }
    return _firestore.collection(_collectionPath);
  }

  /// Save a single model
  Future<void> save(T model) async {
    await _collection
        .doc(model.id)
        .set(
          model.toJson(),
          SetOptions(merge: true),
        );
  }

  /// Save multiple models atomically (batch)
  Future<void> saveAll(List<T> models) async {
    if (models.isEmpty) return;

    final batch = _firestore.batch();
    for (final model in models) {
      final ref = _collection.doc(model.id);
      batch.set(ref, model.toJson(), SetOptions(merge: true));
    }
    await batch.commit();
  }

  /// Delete multiple documents atomically (batch)
  Future<void> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return;

    final batch = _firestore.batch();
    for (final id in ids) {
      final ref = _collection.doc(id);
      batch.delete(ref);
    }
    await batch.commit();
  }

  /// Fetch all documents
  Future<List<T>> getAll() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((e) => _fromJson(e.data())).toList();
  }

  /// Stream documents in real-time
  Stream<List<T>> listenAll() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((e) => _fromJson(e.data())).toList(),
    );
  }
}
