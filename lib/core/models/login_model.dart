// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    String? jsonrpc;
    dynamic id;
    Error? error;
    Result? result;

    AuthModel({
        this.jsonrpc,
        this.id,
        this.error,
        this.result,
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error?.toJson(),
        "result": result?.toJson(),
    };
}

class Error {
    int? code;
    String? message;
    Data? data;

    Error({
        this.code,
        this.message,
        this.data,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? name;
    String? debug;
    String? message;
    List<String>? arguments;
    Context? context;

    Data({
        this.name,
        this.debug,
        this.message,
        this.arguments,
        this.context,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        debug: json["debug"],
        message: json["message"],
        arguments: json["arguments"] == null ? [] : List<String>.from(json["arguments"]!.map((x) => x)),
        context: json["context"] == null ? null : Context.fromJson(json["context"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "debug": debug,
        "message": message,
        "arguments": arguments == null ? [] : List<dynamic>.from(arguments!.map((x) => x)),
        "context": context?.toJson(),
    };
}

class Context {
    Context();

    factory Context.fromJson(Map<String, dynamic> json) => Context(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Result {
    int? uid;
    bool? isSystem;
    bool? isAdmin;
    bool? isInternalUser;
    UserContext? userContext;
    String? db;
    UserSettings? userSettings;
    String? serverVersion;
    List<dynamic>? serverVersionInfo;
    String? supportUrl;
    String? name;
    String? username;
    String? partnerDisplayName;
    int? partnerId;
    String? webBaseUrl;
    int? activeIdsLimit;
    dynamic profileSession;
    dynamic profileCollectors;
    dynamic profileParams;
    int? maxFileUploadSize;
    bool? homeActionId;
    CacheHashes? cacheHashes;
    Map<String, Currency>? currencies;
    BundleParams? bundleParams;
    List<int>? userId;
    String? uaType;
    bool? isQuickEditModeEnabled;

    Result({
        this.uid,
        this.isSystem,
        this.isAdmin,
        this.isInternalUser,
        this.userContext,
        this.db,
        this.userSettings,
        this.serverVersion,
        this.serverVersionInfo,
        this.supportUrl,
        this.name,
        this.username,
        this.partnerDisplayName,
        this.partnerId,
        this.webBaseUrl,
        this.activeIdsLimit,
        this.profileSession,
        this.profileCollectors,
        this.profileParams,
        this.maxFileUploadSize,
        this.homeActionId,
        this.cacheHashes,
        this.currencies,
        this.bundleParams,
        this.userId,
        this.uaType,
        this.isQuickEditModeEnabled,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uid: json["uid"],
        isSystem: json["is_system"],
        isAdmin: json["is_admin"],
        isInternalUser: json["is_internal_user"],
        userContext: json["user_context"] == null ? null : UserContext.fromJson(json["user_context"]),
        db: json["db"],
        userSettings: json["user_settings"] == null ? null : UserSettings.fromJson(json["user_settings"]),
        serverVersion: json["server_version"],
        serverVersionInfo: json["server_version_info"] == null ? [] : List<dynamic>.from(json["server_version_info"]!.map((x) => x)),
        supportUrl: json["support_url"],
        name: json["name"],
        username: json["username"],
        partnerDisplayName: json["partner_display_name"],
        partnerId: json["partner_id"],
        webBaseUrl: json["web.base.url"],
        activeIdsLimit: json["active_ids_limit"],
        profileSession: json["profile_session"],
        profileCollectors: json["profile_collectors"],
        profileParams: json["profile_params"],
        maxFileUploadSize: json["max_file_upload_size"],
        homeActionId: json["home_action_id"],
        cacheHashes: json["cache_hashes"] == null ? null : CacheHashes.fromJson(json["cache_hashes"]),
        currencies: Map.from(json["currencies"]!).map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
        bundleParams: json["bundle_params"] == null ? null : BundleParams.fromJson(json["bundle_params"]),
        userId: json["user_id"] == null ? [] : List<int>.from(json["user_id"]!.map((x) => x)),
        uaType: json["ua_type"],
        isQuickEditModeEnabled: json["is_quick_edit_mode_enabled"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "is_system": isSystem,
        "is_admin": isAdmin,
        "is_internal_user": isInternalUser,
        "user_context": userContext?.toJson(),
        "db": db,
        "user_settings": userSettings?.toJson(),
        "server_version": serverVersion,
        "server_version_info": serverVersionInfo == null ? [] : List<dynamic>.from(serverVersionInfo!.map((x) => x)),
        "support_url": supportUrl,
        "name": name,
        "username": username,
        "partner_display_name": partnerDisplayName,
        "partner_id": partnerId,
        "web.base.url": webBaseUrl,
        "active_ids_limit": activeIdsLimit,
        "profile_session": profileSession,
        "profile_collectors": profileCollectors,
        "profile_params": profileParams,
        "max_file_upload_size": maxFileUploadSize,
        "home_action_id": homeActionId,
        "cache_hashes": cacheHashes?.toJson(),
        "currencies": Map.from(currencies!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "bundle_params": bundleParams?.toJson(),
        "user_id": userId == null ? [] : List<dynamic>.from(userId!.map((x) => x)),
        "ua_type": uaType,
        "is_quick_edit_mode_enabled": isQuickEditModeEnabled,
    };
}

class BundleParams {
    String? lang;

    BundleParams({
        this.lang,
    });

    factory BundleParams.fromJson(Map<String, dynamic> json) => BundleParams(
        lang: json["lang"],
    );

    Map<String, dynamic> toJson() => {
        "lang": lang,
    };
}

class CacheHashes {
    String? translations;

    CacheHashes({
        this.translations,
    });

    factory CacheHashes.fromJson(Map<String, dynamic> json) => CacheHashes(
        translations: json["translations"],
    );

    Map<String, dynamic> toJson() => {
        "translations": translations,
    };
}

class Currency {
    String? symbol;
    String? position;
    List<int>? digits;

    Currency({
        this.symbol,
        this.position,
        this.digits,
    });

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        symbol: json["symbol"],
        position: json["position"],
        digits: json["digits"] == null ? [] : List<int>.from(json["digits"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "position": position,
        "digits": digits == null ? [] : List<dynamic>.from(digits!.map((x) => x)),
    };
}

class UserContext {
    String? lang;
    String? tz;
    int? uid;

    UserContext({
        this.lang,
        this.tz,
        this.uid,
    });

    factory UserContext.fromJson(Map<String, dynamic> json) => UserContext(
        lang: json["lang"],
        tz: json["tz"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "lang": lang,
        "tz": tz,
        "uid": uid,
    };
}

class UserSettings {
    int? id;
    UserId? userId;
    bool? isDiscussSidebarCategoryChannelOpen;
    bool? isDiscussSidebarCategoryChatOpen;
    bool? pushToTalkKey;
    bool? usePushToTalk;
    int? voiceActiveDuration;
    List<List<dynamic>>? volumeSettingsIds;
    bool? homemenuConfig;

    UserSettings({
        this.id,
        this.userId,
        this.isDiscussSidebarCategoryChannelOpen,
        this.isDiscussSidebarCategoryChatOpen,
        this.pushToTalkKey,
        this.usePushToTalk,
        this.voiceActiveDuration,
        this.volumeSettingsIds,
        this.homemenuConfig,
    });

    factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        id: json["id"],
        userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
        isDiscussSidebarCategoryChannelOpen: json["is_discuss_sidebar_category_channel_open"],
        isDiscussSidebarCategoryChatOpen: json["is_discuss_sidebar_category_chat_open"],
        pushToTalkKey: json["push_to_talk_key"],
        usePushToTalk: json["use_push_to_talk"],
        voiceActiveDuration: json["voice_active_duration"],
        volumeSettingsIds: json["volume_settings_ids"] == null ? [] : List<List<dynamic>>.from(json["volume_settings_ids"]!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        homemenuConfig: json["homemenu_config"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId?.toJson(),
        "is_discuss_sidebar_category_channel_open": isDiscussSidebarCategoryChannelOpen,
        "is_discuss_sidebar_category_chat_open": isDiscussSidebarCategoryChatOpen,
        "push_to_talk_key": pushToTalkKey,
        "use_push_to_talk": usePushToTalk,
        "voice_active_duration": voiceActiveDuration,
        "volume_settings_ids": volumeSettingsIds == null ? [] : List<dynamic>.from(volumeSettingsIds!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "homemenu_config": homemenuConfig,
    };
}

class UserId {
    int? id;

    UserId({
        this.id,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
