import 'package:b2b_partenership/core/errors/failure.dart';

bool isConnectionError(Failure failure) {
  final errorMsg = failure.errMsg.toLowerCase();
  return errorMsg.contains('connection') ||
      errorMsg.contains('internet') ||
      errorMsg.contains('socketexception') ||
      errorMsg.contains('timeout');
}
