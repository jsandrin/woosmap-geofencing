#### Handling messages

To receive messages, use a service that extends FirebaseMessagingService. Your service should override the onMessageReceived and onDeletedMessages callbacks. It should handle any message within 20 seconds of receipt (10 seconds on Android Marshmallow). The time window may be shorter depending on OS delays incurred ahead of calling onMessageReceived. After that time, various OS behaviors such as Android O's background execution limits may interfere with your ability to complete your work. For more information see our overview on message priority.

onMessageReceived is provided for most message types, with the following exceptions:

 - **Notification messages delivered when your app is in the background.** In this case, the notification is delivered to the device’s system tray. A user tap on a notification opens the app launcher by default.
 - **Messages with both notification and data payload, when received in the background**. In this case, the notification is delivered to the device’s system tray, and the data payload is delivered in the extras of the intent of your launcher Activity.

#### Override  `onMessageReceived`

By overriding the method `FirebaseMessagingService.onMessageReceived`, you can perform actions based on the received [RemoteMessage](https://firebase.google.com/docs/reference/android/com/google/firebase/messaging/RemoteMessage) object and get the message data:
   ```java
public class WoosmapMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        WoosmapMessageBuilderMaps messageBuilder = new WoosmapMessageBuilderMaps(this, MainActivity.class);
        WoosmapMessageDatas messageDatas = new WoosmapMessageDatas(remoteMessage.getData());
        if (messageDatas.isLocationRequest () && messageDatas.timestamp != null) {
            messageBuilder.sendWoosmapNotification(messageDatas);
        }

    }
}
 ```

