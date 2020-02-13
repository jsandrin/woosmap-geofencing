In the `WoosmapMessageBuilderMaps`, get the last location via the `FusedLocationProviderClient` before that check permission with using the `checkSelfPermission` method of [`ActivityCompat`](https://developer.android.com/reference/android/support/v4/app/ActivityCompat.html) or [`ContextCompat`](https://developer.android.com/reference/android/support/v4/content/ContextCompat.html).

When permission has been granted, continue as usual.

 ```java
private void getLatestLocation(Context context, OnSuccessListener<Location> successListener) {
    if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
        Log.d(WoosmapSettings.Tags.WoosmapTag, "No permission");
    } else {
        FusedLocationProviderClient locationProvider = new FusedLocationProviderClient(context);
        locationProvider.getLastLocation().addOnSuccessListener(successListener);
    }
}
 ```
