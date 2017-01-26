# AcronymDictionary

AcronymDictionary allows you to look up definitions of acronyms. Simply type an acronym in the search bar and if any definitions are found they'll be shown.

## Features

### Search As You Type

AcronymDictionary searches as the user types but in order to avoid having a concurrent request for every letter typed the code keeps track of requests and cancels any old pending request.

### Caching

AcronymDictionary caches results in an `NSDictionary` with a limit set by default at 200 acronyms. This can be modified and if a memory warning is triggered by iOS then the app dumps that cache promptly.

## Usage

Install dependencies using `pod install`

