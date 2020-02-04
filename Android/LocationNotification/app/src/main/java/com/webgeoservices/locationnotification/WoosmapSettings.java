package com.webgeoservices.locationnotification;


import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;


public class WoosmapSettings {

    static public String WoosmapNotification = "woosmapNotification";
    static public String notificationChannelId = "woosmap_001";

    // delay for outdated notification
    static public int outOfTimeDelay = 300;

    // Key for APIs
    static public String privateKeyGMPStatic = "";
    static public String privateKeySearchAPI = "";

    static class Tags {
        static String WoosmapTag = "WoosmapLocationNotification";
        static String NotificationError = "NotificationError";
    }

    static class Urls {
        static String SearchAPIUrl = "https://api.woosmap.com/stores/search/?private_key=%s&lat=%s&lng=%s&stores_by_page=1";
        static String GoogleMapStaticUrl = "https://maps.google.com/maps/api/staticmap?markers=color:red%%7C%s,%s&markers=color:blue%%7C%s,%s&zoom=14&size=400x400&sensor=true&key=%s";
        static String GoogleMapStaticUrl1POI = "https://maps.google.com/maps/api/staticmap?markers=color:red%%7C%s,%s&zoom=14&size=400x400&sensor=true&key=%s";
    }


    public static String getNotificationDefaultUri(Context context) {
        String notificationUri = "";
        try {
            ApplicationInfo ai = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
            Bundle bundle = ai.metaData;
            notificationUri = bundle.getString("woosmap_notification_default_uri");
            Log.d(Tags.WoosmapTag, "notification defautl uri : " + notificationUri);
        } catch (PackageManager.NameNotFoundException e) {
            Log.e(Tags.WoosmapTag, "Failed to load project key, NameNotFound: " + e.getMessage());
        } catch (NullPointerException e) {
            Log.e(Tags.WoosmapTag, "Failed to load meta-data, NullPointer: " + e.getMessage());
        }
        return notificationUri;
    }
}
