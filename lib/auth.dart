import 'package:flutter/material.dart';
import 'package:Karma/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  User _currentUser;
  User get currentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseDatabase.instance.reference();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(currentUser.uid == user.uid);

    _currentUser = await findUserInDatabase(currentUser);
    notifyListeners();
    return _currentUser != null;
  }

  Future<User> findUserInDatabase(firebaseUser) async {
    DataSnapshot data = await db.child("users").child(firebaseUser.uid).once();
    if (data.value == null) {
      await db.child("users").child(firebaseUser.uid).set({
        'uid': firebaseUser.uid,
        'nombre': firebaseUser.displayName,
        'karma': 2
      });
      DataSnapshot data =
          await db.child("users").child(firebaseUser.uid).once();
      return User(Map.from(data.value));
    } else {
      return User(Map.from(data.value));
    }
  }
}
