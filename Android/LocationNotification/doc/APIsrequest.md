## Find the Nearest POIs

When the task of get last location are completes successfully, we call a Search API Woosmap to find the POI nearest of the user location. After that, we call the Google API static map to download a jpeg with the user location and the location of POI.

You must call the google api after the result of the first call SearchAPI like the code below :
  ```java
getLatestLocation(this.context, new OnSuccessListener<Location> () {
    @Override
    public void onSuccess(final Location location) {
        if (location == null) {
            Log.d(WoosmapSettings.Tags.WoosmapTag, "Can't get user Location");
            return;
        }

        final RequestQueue requestQueue = Volley.newRequestQueue(context);

        String urlAPI = String.format(WoosmapSettings.Urls.SearchAPIUrl, WoosmapSettings.privateKeySearchAPI, location.getLatitude(), location.getLongitude ());
        StringRequest stringRequest = new StringRequest (urlAPI, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Gson gson = new Gson();
                SearchAPI data = gson.fromJson (response, SearchAPI.class);
                Feature featureSearch = data.getFeatures ()[0];
                String city = featureSearch.getProperties ().getAddress ().getCity ();
                String zipcode = featureSearch.getProperties ().getAddress ().getZipcode ();
                String distance = String.valueOf (featureSearch.getProperties ().getDistance ());
                double longitudePOI = featureSearch.getGeometry ().getCoordinates ()[0];
                double latitudePOI = featureSearch.getGeometry ().getCoordinates ()[1];

                // Fill body message with informations from API
                final String messageBody = "city = " + city +  "\n zipcode = " + zipcode + "\n distance = " + distance;
                mBuilder.setContentText (messageBody);
                mBuilder.setContentTitle("Location Notification");

                // Request Google Maps Static
                String urlGMPStatic = String.format (WoosmapSettings.Urls.GoogleMapStaticUrl,String.valueOf (location.getLatitude ()),String.valueOf (location.getLongitude ()),String.valueOf (latitudePOI),String.valueOf (longitudePOI),WoosmapSettings.privateKeyGMPStatic);

                // Retrieves an image specified by the URL, displays it in the UI.
                ImageRequest request = new ImageRequest (urlGMPStatic,
                        new Response.Listener<Bitmap>() {
                            @Override
                            public void onResponse(Bitmap bitmap) {
                                mStyle[0] = new NotificationCompat.BigPictureStyle().bigPicture(bitmap);
                                mBuilder.setLargeIcon (bitmap);
                                mBuilder.setStyle(mStyle[0]);

                                mBuilder.setContentIntent(mPendingIntent);

                                Notification notification = mBuilder.build();
                                mNotificationManager.notify(new Random ().nextInt(20), notification);

                            }
                        }, 0, 0, null, null,
                        new Response.ErrorListener() {
                            public void onErrorResponse(VolleyError error) {
                                Log.e (WoosmapSettings.Tags.WoosmapTag, error.toString() + " maps.google.com");
                            }
                        });
                // Add ImageRequest to the RequestQueue
                requestQueue.add(request);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                // Anything you want
                Log.e (WoosmapSettings.Tags.WoosmapTag, error.toString() + " search API");
            }
        });
        requestQueue.add(stringRequest);

    }
});
```
Modify the body, subtitle and attachment of the content handler to show the informations from APIs.
