//
//  JMExtendedScanDebugging.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMServerTaskLogInfo;

__attribute__((visibility("default"))) @interface JMExtendedScanDebugging : NSObject

@property (nonatomic, assign, getter=isScanStarted)     BOOL scanStarted;
@property (nonatomic, assign, getter=isLogFinalized)    BOOL logFinalized;

@property (nonatomic, assign, getter=isEnabled) BOOL        enabled;
@property (nonatomic, strong)                   NSString*   serverTasksLogFile;
@property (nonatomic, strong)                   NSString*   rootDirectory;
@property (nonatomic, strong)                   NSString*   currentDirectory;
@property (nonatomic, strong)                   NSString*   finalDirectory;
@property (nonatomic, strong)                   NSString*   currentOcrFile;

- (void)writeString:(NSString*)string atPath:(NSString*)filePath;
- (void)writeData:(NSData*)data atPath:(NSString*)filePath;

- (NSString*)systemDocumentsDirectoryPath;
- (NSString*)createLogTimestamp;

- (NSString*)rootDirectoryWithName:(NSString*)directoryName;

- (BOOL)createDirectoryAtPath:(NSString*)path;
- (BOOL)removeDirectoryAtPath:(NSString*)path;

- (void)logImage:(UIImage*)image withIdentifier:(NSString*)identifier;

- (void)renameFileAtPath:(NSString*)sourcePath to:(NSString*)destinationPath;

- (void)startLog;
- (void)finalizeLogForScanReference:(NSString*)scanReference;

- (void)appendLineToLogString:(NSMutableString*)logString key:(NSString*)aKey value:(NSString*)aValue separator:(NSString*)aSeparator;
- (void)appendLineToLogString:(NSMutableString*)logString key:(NSString*)aKey value:(NSString*)aValue;
- (void)appendLineToLogString:(NSMutableString*)logString key:(NSString*)aKey boolValue:(BOOL)aBoolValue;

- (void)logServerTaskLogInfo:(JMServerTaskLogInfo*)serverTaskLogInfo;
- (NSString*)createLogStringFromServerTaskLogInfo:(JMServerTaskLogInfo*)serverTaskLogInfo;

- (void)reset;

@end
