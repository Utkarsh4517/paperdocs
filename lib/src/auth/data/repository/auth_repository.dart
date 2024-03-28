import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:paperdocs/constants/url.dart';
import 'package:paperdocs/data/models/error_model.dart';
import 'package:paperdocs/data/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel = ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final newUserAccount = UserModel(
          name: user.displayName!,
          email: user.email,
          imageUrl: user.photoUrl!,
          uid: '',
          token: '',
        );
        final result = await _client.post(Uri.parse('$host/api/signup'), body: newUserAccount.toJson(), headers: {'Content-type': 'application/json; charset=UTF-8'});
        switch (result.statusCode) {
          case 200:
            final newUser = newUserAccount.copyWith(uid: jsonDecode(result.body)['user']['_id']);
            errorModel = ErrorModel(error: null, data: newUser);
            break;

          default:
        }
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
