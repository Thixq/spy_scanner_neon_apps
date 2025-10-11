import 'dart:async';
import 'package:spy_scanner/core/logging/custom_logger.dart';

/// ErrorHandler provides a centralized way to execute operations safely,
/// automatically logging errors and allowing for custom error handling logic.
/// It's designed to replace repetitive try-catch blocks.
class ErrorHandler {
  /// Creates an ErrorHandler for a specific module, identified by [moduleName].
  ErrorHandler(String moduleName) : _logger = CustomLogger(moduleName);
  final CustomLogger _logger;

  /// Executes an asynchronous [operation] safely.
  ///
  /// Returns a value of type [T] on success.
  /// On failure, it logs the error, optionally executes the [onError] callback,
  /// and returns null.
  Future<T?> executeSafely<T>(
    Future<T> Function() operation, {
    required String errorMessage,
    FutureOr<void> Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      // The operation is executed and its result is awaited.
      return await operation();
    } catch (e, s) {
      // If an error occurs, log it using the CustomLogger.
      _logger.error(errorMessage, error: e, stackTrace: s);

      // If a custom onError callback is provided, execute it.
      if (onError != null) {
        await onError(e, s);
      }

      // Return null to signal that the operation failed.
      return null;
    }
  }
}
