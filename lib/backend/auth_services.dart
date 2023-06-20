import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<UserCredential> signInWithGoogle() async {
  
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;


  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await _auth.signInWithCredential(credential);
}
