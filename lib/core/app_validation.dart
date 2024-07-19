String? validateMobile(String? value) {
  if (value!.length != 10) {
    return 'Mobile Number must be of 10 digit';
  } else {
    return null;
  }
}

String? validatemobile(String? value) {
  if (value!.length != 10) {
    return 'Mobile Number must be of 10 digit';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

String? validateemail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

//==============================email validation ======================================//
String? validatemail(String? value) {
  String pattan =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regExp = RegExp(pattan);
  if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
    return ' Please Enter Valid Email Address';
  } else {
    return null;
  }
}

String? locationValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct Location';
  }

  return null;
}

String? drivingValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct Location';
  }

  return null;
}

String? fullnameValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter full name';
  }

  return null;
}

String? fnameValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct First Name';
  }

  return null;
}

String? lastnameValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct Last Name';
  }

  return null;
}

String? lnameValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct Last Name';
  }

  return null;
}

String? birthdateValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Correct BirthDate';
  }

  return null;
}

String? passwordValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter password';
  }

  return null;
}

String? confrompasswordValidate(String? value) {
  if (value!.isEmpty) {
    return 'Enter Confrom New Password';
  }

  return null;
}
