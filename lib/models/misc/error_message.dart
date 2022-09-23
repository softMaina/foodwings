import 'dart:convert';

ErroMessage erroMessageFromJson(String str) => ErroMessage.fromJson(json.decode(str));

String erroMessageToJson(ErroMessage data) => json.encode(data.toJson());

class ErroMessage {
    ErroMessage({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory ErroMessage.fromJson(Map<String, dynamic> json) => ErroMessage(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
