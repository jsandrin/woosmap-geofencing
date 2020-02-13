## Overview 

Android Q introduces changes to location permissions. These changes are very useful for end users because they have their most transparency and control.

Android Q introduces two changes: (1) separate permission for a background location and (2) background location reminders.

## Background Location Permission
Before Android Q, there were two types permissions: ACCESS_FINE_LOCATION and ACCESS_COARSE_LOCATION. These two authorizations allow access to a rental in foreground and background.

Android Q introduces a third type authorization: ACCESS_BACKGROUND_LOCATION. On Android Q, the user must grant background permissions separately from foreground permissions.

With the authorization request in the background, the user will be able to grant only authorizations in the foreground

 - “All the time” — this means an app can access location at any time
-  “While in use” — this means an app can access location only while the app is being used
-  “Deny” — this means an app cannot access location

If a user who previously granted location permissions upgrades to Android Q, they have vested rights when upgrading location permissions in the background, depending on your app settings.
More info on the ACCESS_BACKGROUND_LOCATION in this documentation https://developer.android.com/training/location/receive-location-updates.

Android Q also introduces rental reminders in the background. if the user grants background permissions, Android displays a reminder after a few days, allowing him to modify the parameters
 
## Manifest

We first need to add a new permission to our manifest file, this is the ACCESS_BACKGROUND_LOCATION permission. Although this is declared in the manifest, it can still be revoked at any time by the user.
```xml
<manifest>  
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" /> 
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.location.GPS_ENABLED_CHANGE" />
</manifest>
```

## Request Permission

Note that here we aren’t required to add the foregroundServiceType service type to our service declaration, this is because we don’t need momentary permission to run outside of our app — this background permission already gives our application the ability to do this.
As well as the above, the permission needs to be granted by the user at runtime. So before we try and access the users location from the background, we need to ensure that we have the required permission from the user to do so. We can do this by checking for the ACCESS_BACKGROUND_LOCATION permission. 
Our code for checking the permission may look something like this:

```java
private void requestPermissions() {  
    boolean shouldProvideRationale =  
            ActivityCompat.shouldShowRequestPermissionRationale(this,  
  android.Manifest.permission.ACCESS_FINE_LOCATION);  
  
  // Provide an additional rationale to the user. This would happen if the user denied the  
 // request previously, but didn't check the "Don't ask again" checkbox.  if (shouldProvideRationale) {  
        Log.i(WoosmapSettings.Tags.WoosmapTag, "Displaying permission rationale to provide additional context.");  
  ActivityCompat.requestPermissions(MainActivity.this,  
 new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION, android.Manifest.permission.ACCESS_BACKGROUND_LOCATION},  
  REQUEST_PERMISSIONS_REQUEST_CODE);  
  } else {  
        Log.i(WoosmapSettings.Tags.WoosmapTag, "Requesting permission");  
  // Request permission. It's possible this can be auto answered if device policy  
 // sets the permission in a given state or the user denied the permission // previously and checked "Never ask again".  ActivityCompat.requestPermissions(MainActivity.this,  
 new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION, android.Manifest.permission.ACCESS_BACKGROUND_LOCATION},  
  REQUEST_PERMISSIONS_REQUEST_CODE);  
  }  
}
```
