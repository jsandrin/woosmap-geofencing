##  Overview

Get the location of user on notification to complete the payload with information from APIs. In this sample, we call a search API Woosmap to get the POIs nearrest of the location of the user and a call to Google Static Map to show where is the nearrest POI.

<p style="text-align:center">
  <img alt="Notification Location" src="https://raw.githubusercontent.com/woosmap/woosmap-geofencing/master/iOS/LocationNotification/assets/2Markers.png" width="50%">
</p>

##  Pre-requisites

- iOS 8 and above.
- Xcode 8 and above

## Installation
* Download the latest code version or add the repository as a git submodule to your git-tracked project.
*  Open your Xcode project, then drag and drop source directory onto your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
* Compile and install the mobile app onto your mobile device.

## Get Keys
* Get the token in the log debug or on the main screen of the app.
* If you want a map in the notification, get Google map Key for static map on [Google documentation](https://developers.google.com/maps/documentation/maps-static/get-api-key).

<p style="text-align:center">
  <img alt="Google map Static" src="https://raw.githubusercontent.com/woosmap/woosmap-geofencing/master/iOS/LocationNotification/assets/1Marker.png" width="50%">
</p>

* If you want find the nearest of your store from the user location, get Woosmap Key API on [Woosmap developer documentation](https://developers.woosmap.com/get-started).

<p style="text-align:center">
  <img alt="Search API" src="https://raw.githubusercontent.com/woosmap/woosmap-geofencing/master/iOS/LocationNotification/assets/UserLocationPOI.png" width="50%">
</p>

* If you don't use the APIs with keys, you can only get the location of the user.

<p style="text-align:center">
  <img alt="User Location" src="https://raw.githubusercontent.com/woosmap/woosmap-geofencing/master/iOS/LocationNotification/assets/userLocation.png" width="50%">
</p>

## Send Notification
* Get the token in the log debug or on the main screen of the app.
* Install the app PushNotification from the github : [https://github.com/noodlewerk/NWPusher](https://github.com/noodlewerk/NWPusher)
* Enter your push certificate : [https://github.com/noodlewerk/NWPusher#certificate](https://github.com/noodlewerk/NWPusher#certificate)
* Enter a message in json format like this "{"location":"1","timestamp":"1589288354"}". The object "location" enable to have a location, and the "timestamp" object valid the delay between the time server and the time mobile to know if the location is reliable.
* If you want send notification from an app iOS, use the project : https://github.com/noodlewerk/NWPusher#push-from-ios. Follow instructions to change the p12 file and enter the token of the notification app. 


## Documentation

* [Enabling Location](./doc/EnablingLocation.md)
* [Enabling the Push Notification Service](./doc/EnablingPushNotificationService.md)
* [Notifications Service Extensions](./doc/NotificationsServiceExtensions.md)
* [Check Timestamp of the payload](./doc/CheckTimestampPayload.md)
* [Setup the location manager](./doc/SetupLocationManager.md)
* [APIs request](./doc/APIsRequest.md)


















