package com.webgeoservices.locationnotification;

import android.util.Log;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

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