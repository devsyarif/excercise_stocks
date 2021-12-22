import 'dart:convert';

import 'package:equatable/equatable.dart';

String stocksModelToJson(StocksModel data) => json.encode(data.toJson());

class StocksModel extends Equatable {
  StocksModel({
    this.currency,
    this.description,
    this.displaySymbol,
    this.figi,
    this.mic,
    this.symbol,
    this.type,
    this.isWatched = false,
    this.documentId,
  });

  final String currency;
  final String description;
  final String displaySymbol;
  final String figi;
  final String mic;
  final String symbol;
  final String type;
  final bool isWatched;
  final String documentId;

  StocksModel copyWith({bool isWatched, String documentId}) {
    return StocksModel(
      currency: this.currency,
      description: this.description,
      displaySymbol: this.displaySymbol,
      figi: this.figi,
      mic: this.mic,
      symbol: this.symbol,
      type: this.type,
      isWatched: isWatched ?? this.isWatched,
      documentId: documentId ?? this.documentId,
    );
  }

  factory StocksModel.fromJson(Map<String, dynamic> json) => StocksModel(
        currency: json["currency"] == null ? null : json["currency"],
        description: json["description"] == null ? null : json["description"],
        displaySymbol: json["displaySymbol"] == null ? null : json["displaySymbol"],
        figi: json["figi"] == null ? null : json["figi"],
        mic: json["mic"] == null ? null : json["mic"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency == null ? null : currency,
        "description": description == null ? null : description,
        "displaySymbol": displaySymbol == null ? null : displaySymbol,
        "figi": figi == null ? null : figi,
        "mic": mic == null ? null : mic,
        "symbol": symbol == null ? null : symbol,
        "type": type == null ? null : type,
      };

  @override
  List<Object> get props => [
        this.currency,
        this.description,
        this.displaySymbol,
        this.figi,
        this.mic,
        this.symbol,
        this.type,
        this.isWatched,
      ];
}
