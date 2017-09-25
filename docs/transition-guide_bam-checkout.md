![BAM Checkout](images/bam_checkout.png)

# Transition guide for BAM Checkout

## 2.8.1
No backward incompatible changes.

## 2.8.0
No backward incompatible changes.

## 2.7.0
#### Product re-rebranding
Please note that the Netswipe product has been re-branded to BAMCheckout. This applies to all public classes, methods and Localizable string keys.

#### Adyen support removal
Adyen support has been removed, this includes the removal of  the encryptedAdyenString property from the BAMCheckoutConfiguration and BAMCheckoutCardInformation object.

## 2.5.0
No backward incompatible changes.

## 2.4.0
#### Changes in Localizable-Netswipe.strings
Please note that several strings have been added with introducing accessibility support, while some others have been removed.

## 2.3.1
No backward incompatible changes.

## 2.3.0
#### New parameter for scan reference in error delegate
Added scanReference to delegate didCancelWithError.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didCancelWithError:(NSError *) error scanReference:(NSString *) scanReference;
```

#### Removed name match feature
Name matching by comparing a provided name with the extracted name from a document was removed. The property _name_ in BAMCheckoutViewController class is deleted, as well as the boolean _nameMatch_ and integer _nameDistance_ in BAMCheckoutCardInformation class.

## 2.2.0
#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were added or modified in regards to the new design.

## 2.1.0
#### Exceptions at initialisation
An exception is thrown in case mandatory parameters in the `BAMCheckoutConfiguration` object are invalid.

#### Removed parameters
The boolean parameter `manualEntryEnabled` has been removed from `BAMCheckoutConfig` class, also its corresponding parameter `cardNumberManuallyEntered` from `BAMCheckoutCardInformation`.

#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were removed.
