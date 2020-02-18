//
//  settings.swift
//  GeoSearchSDK
//
//

import Foundation

 //Woosmap SearchAPI Key
public var searchWoosmapKey = ""
public let searchWoosmapAPI = "http://api.woosmap.com/stores/search/?private_key=\(searchWoosmapKey)&lat=%@&lng=%@&stores_by_page=1"

//Location filters
public var currentLocationDistanceFilter = 0.0
public var currentLocationTimeFilter = 0

//API filters
public var searchAPIDistanceFilter = 0.0
public var searchAPITimeFilter = 0



