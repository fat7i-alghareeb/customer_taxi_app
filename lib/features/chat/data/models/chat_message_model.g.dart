// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    _ChatMessageModel(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      senderId: json['senderId'] as String,
      senderRole: json['senderRole'] as String,
      content: json['content'] as String?,
      photoUrl: json['photoUrl'] as String?,
      sentAtUtc: DateTime.parse(json['sentAtUtc'] as String),
    );

Map<String, dynamic> _$ChatMessageModelToJson(_ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'senderId': instance.senderId,
      'senderRole': instance.senderRole,
      'content': instance.content,
      'photoUrl': instance.photoUrl,
      'sentAtUtc': instance.sentAtUtc.toIso8601String(),
    };
