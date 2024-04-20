
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController{
  static User? user = FirebaseAuth.instance.currentUser;
  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();

    if(googleAccount!=null){
      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      saveUser(googleAccount) ;
      return userCredential.user;
    }
    return null;
  }

  static Future<void> saveUser(GoogleSignInAccount account) async {
    FirebaseFirestore.instance.collection('users').doc(account.email)
      .set({
        "email": account.email,
        "name": account.displayName,
        "profilepic": account.photoUrl,
      });
    print("Save User success");
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}