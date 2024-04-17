// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    String? jsonrpc;
    dynamic id;
    Result? result;

    AuthModel({
        this.jsonrpc,
        this.id,
        this.result,
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result?.toJson(),
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
    UserCompanies? userCompanies;
    bool? showEffect;
    bool? displaySwitchCompanyMenu;
    List<int>? userId;
    int? maxTimeBetweenKeysInMs;
    List<dynamic>? webTours;
    bool? tourDisable;
    String? notificationType;
    bool? mapBoxToken;
    bool? odoobotInitialized;
    bool? iapCompanyEnrich;
    bool? ocnTokenKey;
    bool? fcmProjectId;
    int? inboxAction;
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
        this.userCompanies,
        this.showEffect,
        this.displaySwitchCompanyMenu,
        this.userId,
        this.maxTimeBetweenKeysInMs,
        this.webTours,
        this.tourDisable,
        this.notificationType,
        this.mapBoxToken,
        this.odoobotInitialized,
        this.iapCompanyEnrich,
        this.ocnTokenKey,
        this.fcmProjectId,
        this.inboxAction,
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
        userCompanies: json["user_companies"] == null ? null : UserCompanies.fromJson(json["user_companies"]),
        showEffect: json["show_effect"],
        displaySwitchCompanyMenu: json["display_switch_company_menu"],
        userId: json["user_id"] == null ? [] : List<int>.from(json["user_id"]!.map((x) => x)),
        maxTimeBetweenKeysInMs: json["max_time_between_keys_in_ms"],
        webTours: json["web_tours"] == null ? [] : List<dynamic>.from(json["web_tours"]!.map((x) => x)),
        tourDisable: json["tour_disable"],
        notificationType: json["notification_type"],
        mapBoxToken: json["map_box_token"],
        odoobotInitialized: json["odoobot_initialized"],
        iapCompanyEnrich: json["iap_company_enrich"],
        ocnTokenKey: json["ocn_token_key"],
        fcmProjectId: json["fcm_project_id"],
        inboxAction: json["inbox_action"],
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
        "user_companies": userCompanies?.toJson(),
        "show_effect": showEffect,
        "display_switch_company_menu": displaySwitchCompanyMenu,
        "user_id": userId == null ? [] : List<dynamic>.from(userId!.map((x) => x)),
        "max_time_between_keys_in_ms": maxTimeBetweenKeysInMs,
        "web_tours": webTours == null ? [] : List<dynamic>.from(webTours!.map((x) => x)),
        "tour_disable": tourDisable,
        "notification_type": notificationType,
        "map_box_token": mapBoxToken,
        "odoobot_initialized": odoobotInitialized,
        "iap_company_enrich": iapCompanyEnrich,
        "ocn_token_key": ocnTokenKey,
        "fcm_project_id": fcmProjectId,
        "inbox_action": inboxAction,
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
    String? loadMenus;

    CacheHashes({
        this.translations,
        this.loadMenus,
    });

    factory CacheHashes.fromJson(Map<String, dynamic> json) => CacheHashes(
        translations: json["translations"],
        loadMenus: json["load_menus"],
    );

    Map<String, dynamic> toJson() => {
        "translations": translations,
        "load_menus": loadMenus,
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

class UserCompanies {
    int? currentCompany;
    Map<String, AllowedCompany>? allowedCompanies;
    DisallowedAncestorCompanies? disallowedAncestorCompanies;

    UserCompanies({
        this.currentCompany,
        this.allowedCompanies,
        this.disallowedAncestorCompanies,
    });

    factory UserCompanies.fromJson(Map<String, dynamic> json) => UserCompanies(
        currentCompany: json["current_company"],
        allowedCompanies: Map.from(json["allowed_companies"]!).map((k, v) => MapEntry<String, AllowedCompany>(k, AllowedCompany.fromJson(v))),
        disallowedAncestorCompanies: json["disallowed_ancestor_companies"] == null ? null : DisallowedAncestorCompanies.fromJson(json["disallowed_ancestor_companies"]),
    );

    Map<String, dynamic> toJson() => {
        "current_company": currentCompany,
        "allowed_companies": Map.from(allowedCompanies!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "disallowed_ancestor_companies": disallowedAncestorCompanies?.toJson(),
    };
}

class AllowedCompany {
    int? id;
    String? name;
    int? sequence;
    List<dynamic>? childIds;
    bool? parentId;

    AllowedCompany({
        this.id,
        this.name,
        this.sequence,
        this.childIds,
        this.parentId,
    });

    factory AllowedCompany.fromJson(Map<String, dynamic> json) => AllowedCompany(
        id: json["id"],
        name: json["name"],
        sequence: json["sequence"],
        childIds: json["child_ids"] == null ? [] : List<dynamic>.from(json["child_ids"]!.map((x) => x)),
        parentId: json["parent_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sequence": sequence,
        "child_ids": childIds == null ? [] : List<dynamic>.from(childIds!.map((x) => x)),
        "parent_id": parentId,
    };
}

class DisallowedAncestorCompanies {
    DisallowedAncestorCompanies();

    factory DisallowedAncestorCompanies.fromJson(Map<String, dynamic> json) => DisallowedAncestorCompanies(
    );

    Map<String, dynamic> toJson() => {
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
