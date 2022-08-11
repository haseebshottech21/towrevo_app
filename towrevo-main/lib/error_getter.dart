class ErrorGetter {
  dynamic firstNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter First Name';
    } else if (value.length > 30) {
      return 'First Name length Should be less than 30';
    } else if (value.length < 3) {
      return 'First Name must at least 3 characters';
    }
    return null;
  }

  dynamic lastNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Last Name';
    } else if (value.length > 30) {
      return 'Last Name length Should be less than 30';
    } else if (value.length < 3) {
      return 'Last Name must at least 3 characters';
    }
    return null;
  }

  dynamic startingPriceErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Starting Price';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Price must be in numbers';
    }
    return null;
  }

  dynamic isEINNumberValid(String number) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{9}$';
    var regExp = RegExp(regexPattern);

    if (number.isEmpty) {
      return 'Please enter EIN number';
    } else if (!regExp.hasMatch(number)) {
      return 'Enter valid EIN number ex: XX-XXXXXXX';
    }
    return null;
  }

  dynamic companyNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Company Name';
    } else if (value.length > 60) {
      return 'Company Name length Should be less than 60';
    } else if (value.length < 3) {
      return 'Company Name must at least 3 characters';
    }

    return null;
  }

  dynamic companyDescriptionErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Company Description';
    } else if (RegExp(r'\d').hasMatch(value.trim())) {
      return 'Numbers are not allow.';
    } else if (value.length > 300) {
      return 'Company Description length Should be less than 300';
    } else if (value.length < 3) {
      return 'Company Description must at least 3 characters';
    }
    return null;
  }

  dynamic feedbackErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Fill Feedback Field';
    } else if (value.length > 300) {
      return 'Feedback Field length Should be less than 300';
    } else if (value.length < 10) {
      return 'Feedback Field must at least 10 characters';
    }
    return null;
  }

  dynamic emailErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Email Address';
    } else if (value.length > 256) {
      return 'Email Address length Should be less than 256';
    } else if (!value.contains('@')) {
      return 'Enter Valid Email Address';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Enter Valid Email Address';
    }
    return null;
  }

  // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  // double password_strength = 0;

  // bool validatePassword(String pass) {
  //   String _password = pass.trim();
  //   if (_password.isEmpty) {
  //     // setState(() {
  //     password_strength = 0;
  //     // });
  //   } else if (_password.length < 6) {
  //     // setState(() {
  //     password_strength = 1 / 4;
  //     // });
  //   } else if (_password.length < 8) {
  //     // setState(() {
  //     password_strength = 2 / 4;
  //     // });
  //   } else {
  //     if (pass_valid.hasMatch(_password)) {
  //       // setState(() {
  //       password_strength = 4 / 4;
  //       // });
  //       return true;
  //     } else {
  //       // setState(() {
  //       password_strength = 3 / 4;
  //       // });
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  // late String _password;
  // double _strength = 0;

  // RegExp numReg = RegExp(r".*[0-9].*");
  // RegExp letterReg = RegExp(r".*[A-Za-z].*");

  // String _displayText = 'Please enter a password';

  // dynamic checkPassword(String value) {
  //   _password = value.trim();

  //   if (_password.isEmpty) {
  //     // setState(() {
  //     _strength = 0;
  //     return 'Please enter you password';
  //     // });
  //   }
  // else if (_password.length < 6) {
  //   setState(() {
  //     _strength = 1 / 4;
  //     _displayText = 'Your password is too short';
  //   });
  // } else if (_password.length < 8) {
  //   setState(() {
  //     _strength = 2 / 4;
  //     _displayText = 'Your password is acceptable but not strong';
  //   });
  // } else {
  //   if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
  //     setState(() {
  //       // Password length >= 8
  //       // But doesn't contain both letter and digit characters
  //       _strength = 3 / 4;
  //       _displayText = 'Your password is strong';
  //     });
  //   } else {
  //     // Password length >= 8
  //     // Password contains both letter and digit characters
  //     setState(() {
  //       _strength = 1;
  //       _displayText = 'Your password is great';
  //     });
  //   }
  // }
  // }

  // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  // dynamic passwordErrorGetter(String pass) {
  //   String password = pass.trim();
  //   if (password.isEmpty) {
  //     return 'Please Enter Password';
  //   }
  //   if (password.length < 6) {
  //     return 'Password is too short.';
  //   }
  //   if (password.length < 8) {
  //     return 'Password Should be at least 8 characters';
  //   }
  //   if (!pass_valid.hasMatch(_password)) {
  //     return 'Password should contain Capital, small letter & Number & Special';
  //   }
  //   return null;
  //   // else {
  //   //   return 'Password not match';
  //   // }
  //   // }
  // }

  dynamic passwordErrorGetter(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password Should be at least 8 characters';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Password should contain Capital, small letter & Number & Special';
      } else {
        return null;
      }
    }
  }

  dynamic passwordLogin(String password) {
    // RegExp regex =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    }
    return null;
    // } else if (password.length < 8) {
    //   return 'Password Should be at least 8 characters';
    // } else {
    //   if (!regex.hasMatch(password)) {
    //     return 'Password should contain Capital, small letter & Number & Special';
    //   } else {
    //     return null;
    //   }
    // }
  }

  dynamic confirmPasswordErrorGetter(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'Please Enter Confirm Password';
    } else if (confirmPassword.trim() != password.trim()) {
      return 'Confirm Password Should be Same as Password';
    }
    return null;
  }

  dynamic phoneNumberErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Phone Number';
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    return null;
  }

  dynamic voucherCodeErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Add Voucher';
    }
    return null;
  }
}
