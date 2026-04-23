class AppValidators {

  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title can't be empty";
    }
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      return "Title contains invalid characters";
    }

    if (value.trim().length < 3) {
      return "Title must be at least 3 characters";
    }

    if (value.trim().length > 50) {
      return "Title must be less than 50 characters";
    }

    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description can't be empty";
    }
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      return "Title contains invalid characters";
    }

    if (value.trim().length < 10) {
      return "Description must be at least 10 characters";
    }

    if (value.trim().length > 300) {
      return "Description must be less than 300 characters";
    }

    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return "Name must contain letters only";
    }

    return null;
  }
  static String? validateRePassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }
}