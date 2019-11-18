# iOS 13 lifecycle issue
This project was created for investigation of the lifecycle issue for Adobe Mobile Services SDK that happens only on iPhone7 or older devices. There are some changes since the iOS 13 operating system, which are not public documentated but impact how the SDK calcuate some lifecycle related metrics. The current guess is that the `UIApplicationDidEnterBackgroundNotification` may not be triggered or is delayed under some circumstances. However we were not able to reproduce it. But we found another thing during the investiagation, it's that while forcing close a foreground app, the `beginBackgroundTaskWithExpirationHandler` method does not work as expected when being used in the `applicationDidEnterBackground` delegate method. 

## Setup the project
* Downlaod the git project
* Update the project signing

## Behavior
We are monitoring two things here:
* For iOS 13 issue in general, setup a breakpoint on line `sleep(1)` inside the `startBackgroundTask` method.
* For SDK, use Charles to monitor the lifecycle hit.

And follow the steps:
* Install the app from xcode and debug it.
* Forclose the app, check if the break point ever get hit.
* Disconnect the device from xcode, and use Charles to inspect network requests
* Open and then force close the app. Then open the app and check if the CrashEvent is included in the lifecycle request.

### iOS 13/Iphone X
* The break point gets hit.
* No CrashEvent is included in the lifecycle request.

### iOS 13/Iphone 6s
* The break point does NOT get hit.
* No CrashEvent is NOT included in the lifecycle request.

### iOS 12/Iphone 6
* The break point gets hit.
* No CrashEvent is included in the lifecycle request.
