import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/credentials_validator/credentials_validator.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/forgot_password/forgot_pass_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/login/login_events.dart';
import 'package:roboti_app/presentation/auth/view_model/bloc/signup/signup_events.dart';

class AuthValidator {
  CredentialsValidator validator = CredentialsValidator();

  bool loginCredentialsValid(LoginButtonPressEvent event) {
    if (event.email.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterAValidEmail);
      return false;
    } else if (event.password.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterTheCorrectPassword);
      return false;
    } else {
      bool isEmailValid = false, isPasswordValid = false;

      isEmailValid = validator.validateEmail(event.email);

      isPasswordValid = validator.validatePassword(event.password);

      if (!isEmailValid) {
        // Displaying the message
        ErrorMessages.display(lcGlobal.emailEnteredIsInvalid);
      }

      if (isEmailValid && !isPasswordValid) {
        // Displaying the message
        ErrorMessages.display(lcGlobal.passwordMustContain8Characters);
      }

      return isEmailValid && isPasswordValid;
    }
  }

  bool signUpCredentialsValid(CreateAccountScreenEvent event) {
    if (event.fName.isEmpty || event.lName.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterUserName);
      return false;
    } else if (event.email.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterAValidEmail);
      return false;
    } else if (event.password.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnter8CharactersPassword);
      return false;
    } else if (event.confirmPassword.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseReenterThePassword);
      return false;
    } else if (!validator.validateEmail(event.email)) {
      ErrorMessages.display(lcGlobal.emailEnteredIsInvalid);
      return false;
    } else if (!validator.validatePassword(event.password)) {
      ErrorMessages.display(lcGlobal.passwordMustContain8Characters);
      return false;
    } else if (event.password != event.confirmPassword) {
      ErrorMessages.display(lcGlobal.passwordsMustBeSame);
      return false;
    }
    return true;
  }

  bool forgotPasswordEmailValid(ForgotPasswordEmailAddedEvent event) {
    if (event.email.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterYourRegisteredEmail);
      return false;
    } else if (!validator.validateEmail(event.email)) {
      ErrorMessages.display(lcGlobal.emailEnteredIsInvalid);
      return false;
    }
    return true;
  }

  bool resetPasswordFieldsValid(ResetPasswordApiEvent event) {
    if (event.password.isEmpty) {
      ErrorMessages.display(lcGlobal.pleaseEnterAPassword);
      return false;
    } else if (!validator.validatePassword(event.password)) {
      ErrorMessages.display(lcGlobal.passwordMustBeAtLeast8CharactersLong);
      return false;
    } else if (event.confirmPassword.isEmpty) {
      ErrorMessages.display(lcGlobal.reEnterYourPasswordForConfirmation);
      return false;
    } else if (event.password != event.confirmPassword) {
      ErrorMessages.display(lcGlobal.passwordAndConfirmPasswordMustBeSame);
      return false;
    }
    return true;
  }
}
