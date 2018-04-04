![Jumio](images/document_verification.png)

# Transition guide for Document Verification


## 2.11.0

#### New error codes
Instead of `NSError` objects we now return `DocumentVerificationError` in `documentVerificationViewController:didFinishWithError:`. 

Please note, that `code` now is a NSString.
Read more detailed information on this in the [Error Section](integration_document-verification.md#error)

## 2.10.1
No backward incompatible changes.

## 2.10.0

#### Changed handling of frameworks to use a single artifact instead of two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved podspec file to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception handling in Swift
For initialization of DocumentVerificationViewController in Swift, you need to catch the underlying exception and translate it into an `NSError` instance. Whenever an exception is thrown, the `DocumentVerificationViewController` instance will be nil and the SDK is not usable. See our [sample implementation](/sample/SampleSwift/DocumentVerificationStartViewController.swift) on how this is applied.

## 2.9.2
No backward incompatible changes.

## 2.9.1
No backward incompatible changes.

## 2.9.0
No backward incompatible changes.

## 2.8.1
No backward incompatible changes.

## 2.8.0
No backward incompatible changes.

## 2.7.0
#### Product re-rebranding
Please note that the Multi Document product has been re-branded to Document Verification. This applies to all public classes, methods and Localizable string keys.

## 2.5.0
No backward incompatible changes.

## 2.4.0
No backward incompatible changes.

## 2.3.1
No backward incompatible changes.

## 2.3.0
No backward incompatible changes.

## 2.2.0
No backward incompatible changes.

## 2.1.0
No backward incompatible changes.
