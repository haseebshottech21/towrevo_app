class ErrorGetter{

  dynamic firstNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter First Name';
    } else if (value.length > 30) {
      return 'First Name length Should be less than 30';
    }
    return null;
  }

  dynamic lastNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Last Name';
    } else if (value.length > 30) {
      return 'Last Name length Should be less than 30';
    }
    return null;
  }

  dynamic companyNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Company Name';
    } else if (value.length > 60) {
      return 'Company Name length Should be less than 60';
    }
    return null;
  }

  dynamic companyDescriptionErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Company Description';
    } else if (value.length > 300) {
      return 'Company Description length Should be less than 300';
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

  dynamic passwordErrorGetter(String value) {
    if (value.isEmpty) {
      return 'PLease Enter Password';
    }
    if (value.length < 8) {
      return 'Password Should be at least 6 characters';
    }
    return null;
  }

  dynamic confirmPasswordErrorGetter(String confirmPassword,String password) {
    if (confirmPassword.isEmpty) {
      return 'PLease Enter Confirm Password';
    }
    else if (confirmPassword != password) {
      return 'Confirm Password Should be Same as Password';
    }
    return null;
  }

  dynamic phoneNumberErrorGetter(String value) {
    if (value.isEmpty) {
      return 'PLease Enter Phone Number';
    }
    if (value.length < 9) {
      return 'Phone Number Should be at least 9 characters';
    }
    return null;
  }

}