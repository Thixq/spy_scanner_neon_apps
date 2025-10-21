import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A class responsible for managing user identity and profile metadata in Firestore.
/// Handles anonymous sign-in, metadata storage, and profile updates.
final class ProfileManager {
  ProfileManager({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Currently signed-in user
  User? get currentUser => _auth.currentUser;

  /// Reference to the Firestore users collection
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  /// Signs in anonymously if there is no existing user.
  /// Returns the authenticated [User] object.
  Future<User> signInAnonymouslyIfNeeded() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser!;
    }

    final credential = await _auth.signInAnonymously();
    await _createUserProfileIfNotExists(credential.user!);
    return credential.user!;
  }

  /// Creates a Firestore profile document for the user if it doesn't exist.
  Future<void> _createUserProfileIfNotExists(User user) async {
    final docRef = _usersCollection.doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'displayName': 'Anonymous User',
        'createdAt': FieldValue.serverTimestamp(),
        'isPremium': false,
        'lastLogin': FieldValue.serverTimestamp(),
      });
    } else {
      // Update the last login timestamp
      await docRef.update({'lastLogin': FieldValue.serverTimestamp()});
    }
  }

  /// Returns the Firestore profile data for the current user.
  Future<Map<String, dynamic>?> getProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _usersCollection.doc(user.uid).get();
    return doc.data();
  }

  /// Updates user profile fields in Firestore.
  /// Example: {'displayName': 'Kaan', 'isPremium': true}
  Future<void> updateProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user signed in');
    }

    await _usersCollection.doc(user.uid).update(data);
  }

  /// Updates the user's premium status.
  Future<void> setPremiumStatus(bool value) async {
    await updateProfile({'isPremium': value});
  }

  /// Signs out and deletes the user's Firestore document and account.
  Future<void> signOutAndDelete() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _usersCollection.doc(user.uid).delete();
      await user.delete();
    }
  }
}
