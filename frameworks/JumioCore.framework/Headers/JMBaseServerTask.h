//
//  JMBaseServerTask.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMServerTaskLogInfo.h"

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodDELETE
};

typedef NS_ENUM(NSUInteger, ContentType) {
    ContentTypeJSON,
    ContentTypeMultipartForm
};

// Header Keys
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyAuthorization;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyAccept;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyContentType;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyContentEncodingKey;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyAcceptEncodingKey;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyContentEncodingValue;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyAcceptEncodingValue;
extern __attribute__((visibility("default"))) NSString *const kConfigurationValueJSON;
extern __attribute__((visibility("default"))) NSString *const kConfigurationValueALE;
extern __attribute__((visibility("default"))) NSString *const kConfigurationValueMultipartForm;
extern __attribute__((visibility("default"))) NSString *const kConfigurationValueBoundary;
extern __attribute__((visibility("default"))) NSString *const kConfigurationKeyBoundary;


__attribute__((visibility("default"))) @interface JMBaseServerTaskResult : NSObject

- (void)loadFromData:(NSData*)data;

@end



__attribute__((visibility("default"))) @interface JMBaseServerTaskConfiguration : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *merchantReportingCriteria;
@property (nonatomic, strong) NSString *merchantApiToken;
@property (nonatomic, strong) NSString *merchantApiSecret;
@property (nonatomic, strong) NSString *trackingId;

@property (nonatomic, strong) NSString *jumioIdScanReference;

@end


extern NSString *const kServerTaskHeaderUserAgentKey;
extern NSString *const kServerTaskHeaderXTrackingIdKey;

__attribute__((visibility("default"))) @interface JMBaseServerTask : NSObject {
    @protected
    ContentType _contentType;
    NSString*   _boundary;
    HTTPMethod  _httpMethod;
}

/* Task that will be performed on the session */
@property (nonatomic, strong, readonly) NSURLSessionTask* sessionTask;

/* Default error of the request */
@property (nonatomic, strong, readonly) NSError* defaultError;

/* HTTP Method definitions that will be used for the request */
@property (nonatomic, assign, readonly) HTTPMethod httpMethod;

/* HTTP content form type used in the request */
@property (nonatomic, assign, readonly) ContentType contentType;

/* Boundary used for Multi-Part form type requests*/
@property (nonatomic, strong, readonly) NSString* boundary;

/* Task log info */
@property (nonatomic, strong, readonly) JMServerTaskLogInfo* serverTaskLogInfo;

/* Current task configuration */
@property (nonatomic, strong) JMBaseServerTaskConfiguration* configuration;

/* Timeout interval of the request */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/* Completion block that will be executed when the task is successfuly completed with the specified result */
@property (nonatomic, copy) void (^completionBlock)(JMBaseServerTaskResult*);

/* Error block that will be executed when the task failed with the specified error */
@property (nonatomic, copy) void (^errorBlock)(NSError*);

/**
 @brief Default constructor.
 @param configuration The server task configuration. Must not be nil.
 */
- (instancetype) initWithConfiguration:(JMBaseServerTaskConfiguration *)configuration;


/**
 @brief Creates the session task with teh specified URL request
 @discussion The default implementation returns a NSURLSessionDataTask. It must be subclassed in case another type of request is required.
 @param urlRequest The request URL that the session task will use to execute. Must not be nil.
 
 @warning In case this method is subclassed, the task result handling method must be called inside.
 @code - (void)handleTaskResult:(NSData*) data response:(NSHTTPURLResponse*) response error:(NSError*) error;
 */
- (NSURLSessionTask*)createSessionTaskWithURLRequest:(NSURLRequest* const)urlRequest;

/**
 @brief Creates the NSMutableURLRequest used by the session task.
 @discussion Returns the NSMutableURLRequest fully configured with URL, HTTP headers, HTTP body, HTTP MEthod, timeout interval.
 */
- (NSMutableURLRequest*)createURLRequest;

/**
 @brief Creates the URL for the NSMutableURLRequest.
 @discussion Returns the NSURL containing the URL required by the NSMutableURLRequest, build from the baseURL from the supplied configuration, created with:
 @code - (NSMutableURLRequest*)createURLRequest;
 */
- (NSURL*)createURL;

/**
 @brief Creates the HTTP headers for the NSMutableURLRequest.
 @discussion Returns all the HTTP headers dictionary required by the NSMutableURLRequest, created with:
 @code - (NSMutableURLRequest*)createURLRequest;
 */
- (NSDictionary*)createHTTPHeaders;

/**
 @brief Creates the HTTP Body for the NSMutableURLRequest.
 @discussion Returns the HTTP body required by the NSMutableURLRequest, created with:
 @code - (NSMutableURLRequest*)createURLRequest;
 @warning Relevant only for http methods other than GET
 */
- (NSData*)createHTTPBody;

/**
 @brief Creates the authentication value for the HTTP headers.
 @discussion Returns the authentication value required by the HTTP headers, created with:
 @code - (NSDictionary*)createHTTPHeaders;
 */
- (NSString*)createAuthentificationValue;

/**
 @brief Creates the URL parameters.
 @discussion Returns the URL parameters used to the create the HTTP body of non GET type with:
 @code - (NSData*)createHTTPBody;
 */
- (NSDictionary*)createRequestParameters;

/**
 @brief Creates the user agent value.
 @discussion Returns user agent value required when the HTTP headers are created with:
 @code - (NSData*)createHTTPHeaders;
 */
- (NSString*)createUserAgentValue;

/**
 @brief Creates the urlsession on which the task will be exectued .
 @discussion Returns the NSURLSession required when creating the session task with:
 @code - (NSURLSessionTask*)createSessionTaskWithURLRequest:(NSURLRequest* const)urlRequest;
 */
- (NSURLSession*)createSession;

/**
 @brief Encrypts the data.
 @discussion Returns the encrypted data.
 @warning Default implementation does nothing, therefore it MUST be implemented in the subclass in order to achieve encryption.
 
 @param unencryptedData Data to be encrypted, using the supplied encryption algorithm. Must not be nil.
 @param error Error that occured during encryption, nil if the encryption was successful.
 */
- (NSData*)encryptData:(NSData*)unencryptedData error:(NSError**)error;

/**
 @brief Decrypts the data.
 @discussion Returns the decrypted data.
 @param encryptedData Data to be decrypted, using the supplied decryption algorithm. Must not be nil.
 @param error Error that occured during decryption, nil if the decryption was successful.
 
 @warning Default implementation does nothing, therefore it MUST be implemented in the subclass in order to achieve decryption of the previously encrypted data with:
 @code - (NSData*)encryptData:(NSData*)unencryptedData error:(NSError**)error;
 */
- (NSData*)decryptData:(NSData*)encryptedData error:(NSError**)error;

/**
 @brief Starts the task.
 @discussion Starts the task given task with the supplied completion, error block.
 @param completionBlock Completion block that will be performed if the task successfuly completes with the corresponding result as parameter. This block can be nil.
 @param errorBlock Error block that will be performed if the task failed with the corresponding error as parameter. This block can be nil.
 */
- (void)start:(void(^)(JMBaseServerTaskResult*))completionBlock error:(void(^)(NSError*))errorBlock;

/**
 @brief Restarts the task.
 @discussion Restarts the task previously started by:
 @warning FOR INTERNAL USE ONLY, DO NOT CALL THIS DIRECTLY
 @code - (void)start:(void(^)(JMBaseServerTaskResult*))completionBlock error:(void(^)(NSError*))errorBlock;
 */
- (void)startTask;

/**
 @brief Cancels the task.
 @discussion Cancels the task immediately.
 */
- (void)cancel;

/**
 @brief Invalidates the task.
 @discussion Invalidates the task immediately. A invalidated task will be canceled and "forgotten", it's completion or error blocks will not be called.
 */
- (void)invalidate;

/**
 @brief Handles the task result.
 @discussion Handles the task result received. It contains bussiness logic how to handle the successful or failed response, as well as response data validation.
 This method should be called when creating the session task with:
 @code - (NSURLSessionTask*)createSessionTaskWithURLRequest:(NSURLRequest* const)urlRequest;
 */
- (void)handleTaskResult:(NSData*) data response:(NSHTTPURLResponse*) response error:(NSError*) error;

/**
 @brief Handles the response validation.
 @discussion Returns true if the data object is considered valid. This method can be implemented in the subclass if custom validation is required.
 @param data The data that it's validation will be supplied. Must not be nil.
 */
- (BOOL)isResponseDataValid:(NSData*)data;

/**
 @brief Handles the task successful finalization.
 @discussion Handles the task successful finalization, at this point the no error has occured and the data has already been validated.
 At this point the response data must be converted into a JMBaseServerTaskResult object and sent to the completionBlock by calling:
 @code - (void)performCompletionBlockWithResult:(JMBaseServerTaskResult*)result;
 
 @param data Reponse data received after performing the request. Cannot be nil.
 */
- (void)handleTaskSuccessfulWithResult:(NSData *)data;

/**
 @brief Handles the task failed finalization.
 @discussion Handles the task failed finalization with the specified. At this point the error must be sent to the errorBlock by calling:
 @code - (void)performErrorBlockWithError:(NSError*)error;
 
 @param error Error that occured during the task execution. Cannot be nil.
 */
- (void)handleTaskFailedWithError:(NSError *)error;

/**
 @brief Performs the completionBlock.
 @discussion Performs the completionBlock specified in:
 @code - (void)start:(void(^)(JMBaseServerTaskResult*))completionBlock error:(void(^)(NSError*))errorBlock;
 
 @param result Result after task successful finalization
 */
- (void)performCompletionBlockWithResult:(JMBaseServerTaskResult*)result;

/**
 @brief Performs the errorBlock.
 @discussion Performs the errorBlock specified in:
 @code - (void)start:(void(^)(JMBaseServerTaskResult*))completionBlock error:(void(^)(NSError*))errorBlock;
 
 @param error Error that occured during the task execution
 */
- (void)performErrorBlockWithError:(NSError*)error;

/**
 @brief Maps the NSHTTPURLResponse to specific NSError object.
 @discussion Returns the corresponding error object for the status code. Normally this method should return nil if the statusCode is 200 (HTTP_OK).
 This method maps the httpResponse received from:
 @code - (void)handleTaskResult:(NSData*) data response:(NSHTTPURLResponse*) response error:(NSError*) error;
 @warning It is mandatory that this method is implemented in the subclass.
 
 @param httpResponse Http response received after the request has been made. Must not be nil.
 */
- (NSError*)errorFromHTTPResponse:(NSHTTPURLResponse*)httpResponse;

/**
 @brief Maps the system error to another custom error object.
 @discussion Returns the corresponding error object for the corresponding error. This method maps the error object received from:
 @code - (void)handleTaskResult:(NSData*) data response:(NSHTTPURLResponse*) response error:(NSError*) error;
 @warning It is mandatory that this method is implemented in the subclass.
 
 @param httpResponse Http response received after the request has been made. Must not be nil.
 */
- (NSError*)errorFromSystemError:(NSError*)systemError;


/**
 @brief Logs the current log information available.
 @discussion This method is called when the task is finalized (regardless if successful or not) to log the current information gathered.
 @see serverTaskLogInfo

 @warning This method must be subclassed in order to achieve logging since the default implementation does nothing.
 */
- (void)logServerTaskInfo;
@end
