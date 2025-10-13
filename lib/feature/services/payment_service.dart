import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:spy_scanner/core/logging/error_handler.dart';

/// A service that manages payment transactions using the Pay library.
/// It uses ErrorHandler for robust error management.
final class PaymentService {
  PaymentService(this._payInstance) : _errorHandler = ErrorHandler(_moduleName);

  @visibleForTesting
  PaymentService.withErrorHandler(this._payInstance, this._errorHandler);

  static const String _moduleName = 'PaymentService';

  final Pay _payInstance;
  final ErrorHandler _errorHandler;

  /// Initiates the payment process via Apple Pay.
  /// Error management is handled by ErrorHandler.executeSafely.
  Future<Map<String, dynamic>?> applePay({
    required List<PaymentItem> items,
  }) async {
    return _errorHandler.executeSafely<Map<String, dynamic>>(
      () async {
        final result = await _payInstance.showPaymentSelector(
          PayProvider.apple_pay,
          items,
        );
        return result;
      },
      errorMessage:
          'An error occurred while launching the Apple Pay payment selector.',
    );
  }

  /// Initiates the payment process via Google Pay.
  /// Error management is handled by ErrorHandler.executeSafely.
  Future<Map<String, dynamic>?> googlePay({
    required List<PaymentItem> items,
  }) async {
    return _errorHandler.executeSafely<Map<String, dynamic>>(
      () async {
        final result = await _payInstance.showPaymentSelector(
          PayProvider.google_pay,
          items,
        );
        return result;
      },
      errorMessage:
          'An error occurred while launching the Google Pay payment selector.',
    );
  }
}
