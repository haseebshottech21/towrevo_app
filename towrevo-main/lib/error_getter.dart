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
