class InitializeAuth {}

class PaymentAction {
  final String bookId;

  PaymentAction(this.bookId);
}

class PaymentSuccessAction {
  final bool isPaid;

  PaymentSuccessAction({
    required this.isPaid,
  });
}

class PaymentFailedAction {
  final String error;
  PaymentFailedAction(this.error);
}
