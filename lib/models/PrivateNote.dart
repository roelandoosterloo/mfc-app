/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the PrivateNote type in your schema. */
@immutable
class PrivateNote extends Model {
  static const classType = const _PrivateNoteModelType();
  final String id;
  final String? _content;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const PrivateNote._internal({required this.id, required content}): _content = content;
  
  factory PrivateNote({String? id, required String content}) {
    return PrivateNote._internal(
      id: id == null ? UUID.getUUID() : id,
      content: content);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivateNote &&
      id == other.id &&
      _content == other._content;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PrivateNote {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PrivateNote copyWith({String? id, String? content}) {
    return PrivateNote(
      id: id ?? this.id,
      content: content ?? this.content);
  }
  
  PrivateNote.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content
  };

  static final QueryField ID = QueryField(fieldName: "privateNote.id");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PrivateNote";
    modelSchemaDefinition.pluralName = "PrivateNotes";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PrivateNote.CONTENT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _PrivateNoteModelType extends ModelType<PrivateNote> {
  const _PrivateNoteModelType();
  
  @override
  PrivateNote fromJson(Map<String, dynamic> jsonData) {
    return PrivateNote.fromJson(jsonData);
  }
}