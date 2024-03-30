import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:paperdocs/constants/url.dart';
import 'package:paperdocs/data/models/error_model.dart';
import 'package:paperdocs/data/models/user_model.dart';
import 'package:paperdocs/repository/local_storage_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client(), localStorageRepository: LocalStorageRepository()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalStorageRepository localStorageRepository,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel = ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final newUserAccount = UserModel(
          name: user.displayName!,
          email: user.email,
          profileImg: user.photoUrl!,
          uid: '',
          token: '',
        );
        final result = await _client.post(Uri.parse('$host/api/signup'), body: newUserAccount.toJson(), headers: {'Content-type': 'application/json; charset=UTF-8'});
        switch (result.statusCode) {
          case 200:
            final newUser = newUserAccount.copyWith(uid: jsonDecode(result.body)['user']['_id'], token: jsonDecode(result.body)['token']);
            errorModel = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
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
