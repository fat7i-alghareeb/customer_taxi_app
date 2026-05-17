class ClientConfigModel {
  const ClientConfigModel({
    required this.stripeEnabled,
    required this.stripePublishableKey,
    required this.signalREnabled,
  });

  final bool stripeEnabled;
  final String stripePublishableKey;
  final bool signalREnabled;

  factory ClientConfigModel.fromJson(Map<String, dynamic> json) {
    return ClientConfigModel(
      stripeEnabled: json['stripeEnabled'] as bool? ?? false,
      stripePublishableKey: json['stripePublishableKey'] as String? ?? '',
      signalREnabled: json['signalREnabled'] as bool? ?? false,
    );
  }

  static const ClientConfigModel disabled = ClientConfigModel(
    stripeEnabled: false,
    stripePublishableKey: '',
    signalREnabled: false,
  );
}
