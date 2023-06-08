///[Some common Network Exceptions]
enum Exceptions {
  internet,
  server,
  formate,
  unknown,
  http,
}

///[Some common Network Exceptions sizer]
///
extension Messages on Exceptions {
  ///[Most Useful n common error messages]
  String get message {
    switch (this) {
      case Exceptions.internet:
        return "No Internet Available.\nPlease check your internet connection & Try Again!";
      case Exceptions.server:
        return "Something went wrong, Please try again.";
      case Exceptions.formate:
        return "Something went wrong, Please try again.";
      case Exceptions.unknown:
        return "Something went wrong, Our team has been notified";
      case Exceptions.http:
        return "Something went wrong, Our team has been notified HTTP";
      default:
        return "Something went wrong, Our team has been notified";
    }
  }

  /// [Useful for the custom error messages]
  String customMessage(String message, {String? status}) {
    return status != null ? "$status! $message" : message;
  }
}
