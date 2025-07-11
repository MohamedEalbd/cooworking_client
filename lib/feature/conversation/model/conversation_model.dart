

import 'package:khidmh/feature/conversation/model/conversation_user.dart';

class ConversationModel {
  String? responseCode;
  String? message;
  ConversationContent? content;

  ConversationModel({this.responseCode, this.message, this.content});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? ConversationContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class ConversationContent {
  int? currentPage;
  List<ConversationData>? conversationList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ConversationContent(
      {this.currentPage,
        this.conversationList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ConversationContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      conversationList = <ConversationData>[];
      json['data'].forEach((v) {
        conversationList!.add(ConversationData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (conversationList != null) {
      data['data'] = conversationList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;

    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

///list of message
class ConversationData {
  String? id;
  String? channelId;
  String? message;
  String? userId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ConversationUser? user;
  List<ConversationFile>? conversationFile;

  ConversationData(
      {this.id,
        this.channelId,
        this.message,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.conversationFile
      });

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    message = json['message'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ConversationUser.fromJson(json['user']) : null;

    if (json['conversation_files'] != null) {
      conversationFile = <ConversationFile>[];
      json['conversation_files'].forEach((v) {
        conversationFile!.add(ConversationFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel_id'] = channelId;
    data['message'] = message;
    data['user_id'] = userId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    if (conversationFile != null) {
      data['conversation_files'] = conversationFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationFile {
  String? id;
  String? conversationId;
  String? storedFileName;
  String? storedFileNameFullPath;
  String? originalFileName;
  String? fileType;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? filSize;

  ConversationFile(
      {this.id,
        this.conversationId,
        this.storedFileName,
        this.storedFileNameFullPath,
        this.originalFileName,
        this.fileType,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.filSize
      });

  ConversationFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    storedFileName = json['stored_file_name'];
    storedFileNameFullPath = json['stored_file_name_full_path'];
    originalFileName = json['original_file_name'];
    fileType = json['file_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    filSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversation_id'] = conversationId;
    data['stored_file_name'] = storedFileName;
    data['stored_file_name_full_path'] = storedFileNameFullPath;
    data['original_file_name'] = originalFileName;
    data['file_type'] = fileType;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}