class CredicardModel {
  String cardNumber;
  String cardHolderName;
  String cardExpirationDate;
  String cardCVV;

  CredicardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpirationDate,
    required this.cardCVV,
  });

  CredicardModel copyWith({
    String? cardNumber,
    String? cardHolderName,
    String? cardExpirationDate,
    String? cardCVV,
  }) {
    return CredicardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardExpirationDate: cardExpirationDate ?? this.cardExpirationDate,
      cardCVV: cardCVV ?? this.cardCVV,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'cardExpirationDate': cardExpirationDate,
      'cardCVV': cardCVV,
    };
  }

  factory CredicardModel.fromJson(Map<String, dynamic> json) {
    return CredicardModel(
      cardNumber: json['cardNumber'],
      cardHolderName: json['cardHolderName'],
      cardExpirationDate: json['cardExpirationDate'],
      cardCVV: json['cardCVV'],
    );
  }
  @override
  String toString() {
    return 'CredicardModel(cardNumber: $cardNumber, cardHolderName: $cardHolderName, cardExpirationDate: $cardExpirationDate, cardCVV: $cardCVV)';
  }
}
