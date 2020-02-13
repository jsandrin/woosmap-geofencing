To verify if the notification is too late between the time send and the time received on the mobile.

## Delay timeout

Set the out of time delay in second : 
```swift
let outOfTimeDelay = 300
```

## Compare with Server Timestamp
In didReiceive method parse the payload to extract the timestamp server and compare with the timestamp local with a extratime. The timestamp is the time in second in UTC since 1970 : 
```swift
if let timeStampServer = aps["timestamp"] as ? Int {
	let currentTime = Date().timeIntervalSince1970
	// convert to Integer
	let timeStampLocal = Int(currentTime)
	
	if (timeStampServer + outOfTimeDelay < timeStampLocal) {
		// the notification is too late, change the payload_
		bestAttemptContent?.body = "OUT OF TIME"
		// deliver the notifation
		contentHandler(bestAttemptContent!.copy() as! UNNotificationContent)
		return
	}
}
```
