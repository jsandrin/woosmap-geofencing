
###  APIs request 
In this case we call a Search API Woosmap to find the POI nearest of the user location. After we call the Google API static map to download a jpeg with the user location and the location of POI. 

You must call the google api after the result of the first call api like the code below : 
```swift
// Call API search
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
        NSLog("error: \(error)")
    } else {
        if let response = response as? HTTPURLResponse {
            NSLog("statusCode: \(response.statusCode)")
        }
        let responseJSON = try? JSONDecoder().decode(SearchAPIJson_Base.self, from: data!)
        for feature in (responseJSON?.features)! {
            //Get info POI from search API
            let body = "City = \(feature.properties!.address!.city!) \n ZipCode = \(feature.properties!.address!.zipcode!) \n Distance = \(feature.properties!.distance!)"
            
            //Set the body of the notificaiton
            self.bestAttemptContent?.body = body
            
            //Get coordinates of the POI
            latitudePOI = (feature.geometry?.coordinates![1])!
            longitudePOI = (feature.geometry?.coordinates![0])!
        }
        
        let staticMapUrl:String
        
        if latitudePOI != 0.0 {
            staticMapUrl = "http://maps.google.com/maps/api/staticmap?markers=color:red%7C\(myLatitude),\(myLongitude)&markers=color:blue%7C\(latitudePOI),\(longitudePOI)&zoom=14&size=400x400&sensor=true&key=\(self.GoogleStaticMapKey)"
        } else {
            staticMapUrl = "http://maps.google.com/maps/api/staticmap?markers=color:blue%7C\(myLatitude),\(myLongitude)&zoom=15&size=400x400&sensor=true&key=\(self.GoogleStaticMapKey)"
        }
        let mapUrl: URL = URL(string: staticMapUrl)!
        
        // Call API Google Static Map
        URLSession.shared.downloadTask(with: mapUrl) { (location, response, error) in
            if let location = location {
                // Move temporary fi@le to remove .tmp extension
                let tmpDirectory = NSTemporaryDirectory()
                let tmpFile = "file://".appending(tmpDirectory).appending(mapUrl.lastPathComponent).appending(UUID().uuidString).appending(".jpg")
                let tmpUrl = URL(string: tmpFile)!
                try! FileManager.default.moveItem(at: location, to: tmpUrl)
                
                // Add the attachment to the notification content
                if let attachment = try? UNNotificationAttachment(identifier: "", url: tmpUrl) {
                    self.bestAttemptContent?.attachments = [attachment]
                }
            }
            // Serve the notification content
            self.contentHandler!(self.bestAttemptContent!)
            }.resume()
    }
}
task.resume()
```

Modify the body, subtitle and attachment of the content handler to show the informations from APIs.
