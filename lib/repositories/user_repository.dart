import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserRepository {
  Future<SignUpResult> createUser(String email, String password) async {
    SignUpResult result = await Amplify.Auth.signUp(
      username: email.replaceAll('@', '#'),
      password: password.trim(),
      options: CognitoSignUpOptions(
        userAttributes: {CognitoUserAttributeKey.email: email},
      ),
    );
    return result;
  }

  Future<ResendSignUpCodeResult> resendSignUpCode(String email) async {
    return Amplify.Auth.resendSignUpCode(username: email.replaceAll("@", "#"));
  }

  Future<SignUpResult> confirmSignUp(String email, String code) async {
    SignUpResult result = await Amplify.Auth.confirmSignUp(
      username: email.replaceAll('@', '#'),
      confirmationCode: code,
    );
    return result;
  }

  Future<SignInResult> signIn(String email, String password) async {
    SignInResult result = await Amplify.Auth.signIn(
      username: email,
      password: password.trim(),
    );
    return result;
  }

  Future<SignInResult> confirmSignIn(String code) async {
    SignInResult result = await Amplify.Auth.confirmSignIn(
      confirmationValue: code,
    );
    return result;
  }

  Future<ResetPasswordResult> requestPasswordReset(String email) {
    return Amplify.Auth.resetPassword(username: email);
  }

  Future<UpdatePasswordResult> confirmPasswordReset(
      String email, String password, String code) {
    return Amplify.Auth.confirmResetPassword(
        username: email, newPassword: password, confirmationCode: code);
  }

  Future<void> signOut() async {
    SignOutResult result = await Amplify.Auth.signOut();
    return;
  }

  Future<bool> isSignedIn() async {
    try {
      await getUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AuthUser> getUser() async {
    return await Amplify.Auth.getCurrentUser();
  }

  Future<String> getUsername() async {
    AuthUser user = await Amplify.Auth.getCurrentUser();
    return user.username.replaceAll("@", "#");
  }
}
