# EasyPost Objective-C Client Library

EasyPost is a simple shipping API. You can sign up for an account at [https://easypost.com](https://easypost.com)

## Installation

Update these two values in `EZPConfiguration.m` file:

```objectivec
NSString * const kTestSecretAPIKey = @"YOUR_TEST_API_KEY";
NSString * const kLiveSecretAPIKey = @"YOUR_LIVE_API_KEY";
```

to match your configuration; now you may use the default `EZPClient` instance:

```objectivec
self.client = [EZPClient defaultClient];
```

Otherwise you can create a client object directly with your secret API key:

```objectivec
self.client = [[EZPClient alloc] initWithSecretKey:@"XXXXX"];
```

> You may have multiple clients (with different secret keys) for making API request simultaneously from different EasyPost accounts.

## Usage

This library includes methods for asynchronous and synchronous access to EasyPost API. Below is an example of creation an address object and verifying it:

* Asynchronous:

    ```objectivec
NSDictionary *parameters = @{ ... };
[self.client createAndVerifyAddressWithParameters:parameters completion:^(EZPAddress *address, NSError *error) {
        NSLog(@"Verified address: %@", address);
}];
    ```

* Synchronous:
    ```objectivec
NSDictionary *parameters = @{ ... };
EZPAddress *address = [self.client createAndVerifyAddressWithParameters:parameters];
NSLog(@"Verified address: %@", address);
    ```


> Synchronous network operations is probably anti-pattern, but it's easier to use (to avoid long nesting of asynchronous callbacks). 
> Asynchronous and synchronous version can be combined.

The project includes two sample applications:

- EasyPoster (OS X)
- EasyPosterMobile (iOS)

## Credits

* [https://github.com/mproberts/objc-promise](https://github.com/mproberts/objc-promise)
* [https://github.com/aryaxt/OCMapper](https://github.com/aryaxt/OCMapper)

## EasyPost API Documentation

Up-to-date official documentation is available [here](https://www.geteasypost.com/docs).
