import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pay/pay.dart';

import 'package:spy_scanner/core/logging/error_handler.dart';
import 'package:spy_scanner/feature/services/payment_service.dart';

@GenerateMocks([Pay, ErrorHandler])
import 'payment_service_test.mocks.dart';

void main() {
  late MockPay mockPay;

  late MockErrorHandler mockErrorHandler;
  late PaymentService paymentService;

  final testItems = <PaymentItem>[
    const PaymentItem(
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
      amount: '10.99',
    ),
  ];
  final successfulResult = <String, dynamic>{
    'status': 'SUCCESS',
    'token': 'mock_token_123',
  };

  setUp(() {
    mockPay = MockPay();
    mockErrorHandler = MockErrorHandler();
    paymentService = PaymentService.withErrorHandler(
      mockPay,
      mockErrorHandler,
    ); // Assumed new constructor
  });

  group('PaymentService Tests (Apple Pay)', () {
    test('Successful applePay operation should return data', () async {
      when(
        mockErrorHandler.executeSafely<Map<String, dynamic>>(
          any,
          errorMessage: anyNamed('errorMessage'),
          onError: anyNamed('onError'),
        ),
      ).thenAnswer((_) async => successfulResult);
      final result = await paymentService.applePay(items: testItems);
      expect(result, equals(successfulResult));
      verify(
        mockErrorHandler.executeSafely<Map<String, dynamic>>(
          any,
          errorMessage:
              'An error occurred while launching the Apple Pay payment selector.',
        ),
      ).called(1);
    });

    test(
      'In case of error, applePay should return null and the error should be logged',
      () async {
        when(
          mockErrorHandler.executeSafely<Map<String, dynamic>>(
            any,
            errorMessage: anyNamed('errorMessage'),
            onError: anyNamed('onError'),
          ),
        ).thenAnswer((_) async => null);

        final result = await paymentService.applePay(items: testItems);

        expect(result, isNull);

        verify(
          mockErrorHandler.executeSafely<Map<String, dynamic>>(
            any,
            errorMessage:
                'An error occurred while launching the Apple Pay payment selector.',
          ),
        ).called(1);
      },
    );
  });

  group('PaymentService Tests (Google Pay)', () {
    test('Successful googlePay operation should return data', () async {
      when(
        mockErrorHandler.executeSafely<Map<String, dynamic>>(
          any,
          errorMessage: anyNamed('errorMessage'),
          onError: anyNamed('onError'),
        ),
      ).thenAnswer((_) async => successfulResult);

      final result = await paymentService.googlePay(items: testItems);

      expect(result, equals(successfulResult));

      verify(
        mockErrorHandler.executeSafely<Map<String, dynamic>>(
          any,
          errorMessage:
              'An error occurred while launching the Google Pay payment selector.',
        ),
      ).called(1);
    });

    test(
      'In case of error, googlePay should return null and the error should be logged',
      () async {
        when(
          mockErrorHandler.executeSafely<Map<String, dynamic>>(
            any,
            errorMessage: anyNamed('errorMessage'),
            onError: anyNamed('onError'),
          ),
        ).thenAnswer((_) async => null);

        final result = await paymentService.googlePay(items: testItems);

        expect(result, isNull);

        verify(
          mockErrorHandler.executeSafely<Map<String, dynamic>>(
            any,
            errorMessage:
                'An error occurred while launching the Google Pay payment selector.',
          ),
        ).called(1);
      },
    );
  });
}
