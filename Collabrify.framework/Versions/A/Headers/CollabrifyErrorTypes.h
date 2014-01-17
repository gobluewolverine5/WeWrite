//
//  CollabrifyErrorTypes.h
//  Collabrify
//
//  Created by Brandon Knope on 1/13/14.
//  Copyright (c) 2014 Collabrify. All rights reserved.
//

typedef NS_ENUM(NSInteger, CollabrifyServerSideErrorType)
{
    CollabrifyServerSideError_NOT_SET = 0,
    CollabrifyServerSideError_GENERAL_ERROR = 1,
    CollabrifyServerSideError_IO_EXCEPTION = 2,
    CCollabrifyServerSideError_INVALID_PROTOCOL_BUFFER_EXCEPTION = 3,
    CollabrifyServerSideError_NOT_IMPLEMENTED_YET = 4,
    CollabrifyServerSideError_OPERATION_NOT_PERMITTED = 5,
    CollabrifyServerSideError_INVALID_SETTINGS_FOR_OPERATION = 6,
    CollabrifyServerSideError_CLIENT_SIDE_ERROR = 7,
    CollabrifyServerSideError_SERVER_SIDE_ERROR = 8,
    CollabrifyServerSideError_UNRECOGNIZED_EXCEPTION_ENUM = 9,
    CollabrifyServerSideError_ACCOUNT_ALREADY_EXISTS = 10,
    CollabrifyServerSideError_ACCOUNT_PASSWORD_MISSING = 11,
    CollabrifyServerSideError_ACCOUNT_GMAIL_MISSING = 12,
    CollabrifyServerSideError_ACCOUNT_NAME_MISSING = 13,
    CollabrifyServerSideError_ACCOUNT_REF_MISSING = 14,
    CollabrifyServerSideError_ACCOUNT_ACCESS_TOKEN_MISSING = 15,
    CollabrifyServerSideError_INVALID_ACCOUNT_GMAIL = 16,
    CollabrifyServerSideError_INVALID_ACCESS_TOKEN = 17,
    CollabrifyServerSideError_INVALID_ACCOUNT_GMAIL_OR_ACCESS_TOKEN = 18,
    CollabrifyServerSideError_INVALID_ACCOUNT_GMAIL_OR_PASSWORD = 19,
    CollabrifyServerSideError_SESSION_ALREADY_EXISTS = 20,
    CollabrifyServerSideError_SESSION_ID_MISSING = 21,
    CollabrifyServerSideError_SESSION_NAME_MISSING = 22,
    CollabrifyServerSideError_SESSION_PASSWORD_MISSING = 23,
    CollabrifyServerSideError_SESSION_REF_MISSING = 24,
    CollabrifyServerSideError_INVALID_SESSION_ID = 25,
    CollabrifyServerSideError_INVALID_SESSION_KEY = 26,
    CollabrifyServerSideError_INVALID_SESSION_PASSWORD = 27,
    CollabrifyServerSideError_INVALID_SESSION_ID_OR_PASSWORD = 28,
    CollabrifyServerSideError_SESSION_TAGS_MISSING = 29,
    CollabrifyServerSideError_TOO_MANY_SESSION_TAGS = 30,
    CollabrifyServerSideError_TOO_FEW_SESSION_TAGS = 31,
    CollabrifyServerSideError_SESSION_TAG_IS_NULL_OR_EMPTY = 32,
    CollabrifyServerSideError_SESSION_ENDED = 33,
    CollabrifyServerSideError_INVALID_BASE_FILE_KEY = 40,
    CollabrifyServerSideError_BASE_FILE_DATA_MISSING = 41,
    CollabrifyServerSideError_BASE_FILE_DATA_TOO_LARGE = 42,
    CollabrifyServerSideError_NO_BASE_FILE_FOR_SESSION = 43,
    CollabrifyServerSideError_BASE_FILE_NOT_COMPLETE_YET = 44,
    CollabrifyServerSideError_BASE_FILE_ALREADY_COMPLETE = 45,
    CollabrifyServerSideError_FILE_REF_IS_MISSING = 50,
    CollabrifyServerSideError_BYTE_DATA_IS_MISSING = 51,
    CollabrifyServerSideError_BYTE_DATA_TOO_LARGE = 52,
    CollabrifyServerSideError_BYTE_DATA_TOO_LARGE_FOR_REQUEST = 53,
    CollabrifyServerSideError_BYTE_DATA_TOO_LARGE_FOR_RESPONSE = 54,
    CollabrifyServerSideError_INVALID_START_POSITION_OR_LENGTH = 55,
    CollabrifyServerSideError_OWNER_GMAIL_MISSING = 70,
    CollabrifyServerSideError_OWNER_DISPLAY_NAME_MISSING = 71,
    CollabrifyServerSideError_OWNER_NOTIFICATION_ID_MISSING = 72,
    CollabrifyServerSideError_OWNER_NOTIFICATION_TYPE_MISSING = 73,
    CollabrifyServerSideError_OWNER_REF_MISSING = 74,
    CollabrifyServerSideError_OWNER_PARTICIPANT_ID_IS_ZERO = 75,
    CollabrifyServerSideError_OWNER_ACTION_BY_NON_OWNER = 76,
    CollabrifyServerSideError_OWNER_REMOTE_SERVLET_NOTIFICATION_URL_MISSING = 77,
    CollabrifyServerSideError_OWNER_REMOTE_SERVLET_GET_NOTIFICATION_ID_URL_MISSING = 78,
    CollabrifyServerSideError_LATE_JOIN_NOT_ALLOWED = 79,
    CollabrifyServerSideError_PARTICIPANT_GMAIL_MISSING = 80,
    CollabrifyServerSideError_PARTICIPANT_DISPLAY_NAME_MISSING = 81,
    CollabrifyServerSideError_PARTICIPANT_NOTIFICATION_ID_MISSING = 82,
    CollabrifyServerSideError_PARTICIPANT_NOTIFICATION_TYPE_MISSING = 83,
    CollabrifyServerSideError_PARTICIPANT_REF_MISSING = 84,
    CollabrifyServerSideError_PARTICIPANT_ID_MISSING = 85,
    CollabrifyServerSideError_PARTICIPANT_NOT_IN_SESSION = 86,
    CollabrifyServerSideError_PARTICIPANT_ALREADY_IN_SESSION = 87,
    CollabrifyServerSideError_INVALID_PARTICIPANT_LIMIT = 88,
    CollabrifyServerSideError_PARTICIPANT_LIMIT_REACHED = 89,
    CollabrifyServerSideError_PARTICIPANT_REMOTE_SERVLET_NOTIFICATION_URL_MISSING = 90,
    CollabrifyServerSideError_PARTICIPANT_REMOTE_SERVLET_GET_NOTIFICATION_ID_URL_MISSING = 91,
    CollabrifyServerSideError_REMOTE_SERVLET_ERROR = 92,
    CollabrifyServerSideError_INVALID_ORDER_ID = 100,
    CollabrifyServerSideError_NO_EVENT_WITH_ORDER_ID = 101,
    CollabrifyServerSideError_EVENT_DATA_MISSING = 102,
    CollabrifyServerSideError_EVENT_DATA_TOO_LARGE = 103,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_NOT_PROVIDED = 110,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_MISSING_KEY = 111,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_MISSING_TYPE_ENUM = 112,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_MISSING_VALUE = 113,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_NO_SUCH_KEY = 114,
    CollabrifyServerSideError_KEY_VALUE_ENTRY_TOO_LARGE = 115,
    CollabrifyServerSideError_COLLABRIFY_CLOUD_DOWN_FOR_MAINTENANCE = 150,
    CollabrifyServerSideError_COLLABRIFY_CLIENT_VERSION_INCOMPATIBLE = 151
};