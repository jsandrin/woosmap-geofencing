To verify if the notification is too late between the time send and the time received on the mobile.

## Delay timeout

In WoosmapSettings class, set the out of time delay in second :

```java
// delay for outdated notification  
static public int outOfTimeDelay = 300;
```

## Compare with Server Timestamp

Parse the payload to extract the timestamp server and compare with the timestamp local with a extratime. The timestamp is the time in second in UTC since 1970 :
```java
 if (datas.timestamp != null) {
    Long tsMobile = System.currentTimeMillis()/1000;
    Long tsServer = Long.parseLong (datas.timestamp);
    if (tsServer + WoosmapSettings.outOfTimeDelay < tsMobile) {
        Log.d(WoosmapSettings.Tags.WoosmapTag, "Timestamp is outdated");
        return;
    }
} else {
    Log.d(WoosmapSettings.Tags.WoosmapTag, "No timestamp is define in the payload");
    return;
}
  ```


