 

class PaymentState {
  final bool isProcessing;

  final String error;

  PaymentState({
    required this.isProcessing,
    required this.error,
  });
 
  factory PaymentState.initial() {
    return PaymentState(
      isProcessing: false,
      error: '',
    );
  }

  PaymentState copyWith({
    bool? isProcessing,
    String? error,
  }) {
    return PaymentState(
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'isProcessing': isProcessing,
      'error': error,
    };
  }

 
  factory PaymentState.fromJson(Map<String, dynamic> json) {
    return PaymentState(
      isProcessing: json['isProcessing'] ?? false,
      error: json['error'] ?? '',
    );
  }
}
