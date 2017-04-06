

#ifdef LOG // PREPROCESSOR MACRO DEFINED IN BUILD SETTINGS -> APPLE LLVM 3.0 COMPILER -> PREPROCESSING
    #define DLog(fmt, ...) LogDebug(fmt, ##__VA_ARGS__); // redirect old log to debug log
    #else
    #   define DLog(...) {}
#endif

// ################# NEW LOGGING HELPER ##################

#ifndef LOGGING_LEVEL_TRACE
#	define LOGGING_LEVEL_TRACE		1
#endif
#ifndef LOGGING_LEVEL_INFO
#	define LOGGING_LEVEL_INFO		1
#endif
#ifndef LOGGING_LEVEL_ERROR
#	define LOGGING_LEVEL_ERROR		1
#endif
#ifndef LOGGING_LEVEL_DEBUG
#	define LOGGING_LEVEL_DEBUG		1
#endif
#ifndef LOGGING_LEVEL_CV
#	define LOGGING_LEVEL_CV		0
#endif

#ifndef LOGGING_LEVEL_TRACE_FORMAT
#   define LOGGING_LEVEL_TRACE_FORMAT @"TRACE"
#endif
#ifndef LOGGING_LEVEL_INFO_FORMAT
#   define LOGGING_LEVEL_INFO_FORMAT @"INFO"
#endif
#ifndef LOGGING_LEVEL_ERROR_FORMAT
#   define LOGGING_LEVEL_ERROR_FORMAT @"***ERROR***"
#endif
#ifndef LOGGING_LEVEL_DEBUG_FORMAT
#   define LOGGING_LEVEL_DEBUG_FORMAT @"DEBUG"
#endif
#ifndef LOGGING_LEVEL_CV_FORMAT
#   define LOGGING_LEVEL_CV_FORMAT @"CV"
#endif


#define LogPublic(fmt, ...) NSLog((fmt), ##__VA_ARGS__); // public log
#ifdef LOG
    // Logging format
    #define LOG_FORMAT_WITH_LOCATION(fmt, lvl, ...) { [JMLogging JMLog:fmt level:lvl function:__PRETTY_FUNCTION__ line:__LINE__, ##__VA_ARGS__]; }
    #define LOG_FORMAT(fmt, lvl, ...) LOG_FORMAT_WITH_LOCATION(fmt, lvl, ##__VA_ARGS__)

    // Trace logging
    #if defined(LOGGING_LEVEL_TRACE) && LOGGING_LEVEL_TRACE
        #define LogTrace(fmt, ...) LOG_FORMAT(fmt, LOGGING_LEVEL_TRACE_FORMAT, ##__VA_ARGS__)
    #else
        #define LogTrace(...) {}
    #endif

    // Info logging
    #if defined(LOGGING_LEVEL_INFO) && LOGGING_LEVEL_INFO
        #define LogInfo(fmt, ...) LOG_FORMAT(fmt, LOGGING_LEVEL_INFO_FORMAT, ##__VA_ARGS__)
    #else
        #define LogInfo(...) {}
    #endif

    // Error logging
    #if defined(LOGGING_LEVEL_ERROR) && LOGGING_LEVEL_ERROR
        #define LogError(fmt, ...) LOG_FORMAT(fmt, LOGGING_LEVEL_ERROR_FORMAT, ##__VA_ARGS__)
    #else
        #define LogError(...) {}
    #endif

    // Debug logging
    #if defined(LOGGING_LEVEL_DEBUG) && LOGGING_LEVEL_DEBUG
        #define LogDebug(fmt, ...) LOG_FORMAT(fmt, LOGGING_LEVEL_DEBUG_FORMAT, ##__VA_ARGS__)
    #else
        #define LogDebug(...) {}
    #endif

    // Computer Vision logging
    #if defined LOGGING_LEVEL_CV && LOGGING_LEVEL_CV
        #define LogCV(fmt, ...) LOG_FORMAT(fmt, LOGGING_LEVEL_CV_FORMAT, ##__VA_ARGS__)
    #else
        #define LogCV(...) {}
    #endif

@interface JMLogging : NSObject

+ (BOOL) isFileLoggingEnabled;
+ (void) setFileLoggingEnabled:(BOOL)loggingEnabled;
+ (void) writeLogDataToFile:(NSString*)fileName;
+ (void) JMLog:(NSString *)format level:(NSString*)logLevel function:(const char*)function line:(int)line, ...;

@end

#else
    #define LogTrace(...) {}
    #define LogDebug(...) {}
    #define LogError(...) {}
    #define LogInfo(...) {}
    #define LogCV(...) {}
#endif


