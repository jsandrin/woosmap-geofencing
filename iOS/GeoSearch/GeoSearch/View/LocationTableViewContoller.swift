//
//  LocationTableViewContoller.swift
//  GeoSearch
//
//

import UIKit

enum dataType {
    case POI
    case location
}

class customDataCell  {
    public var date: Date?
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    public var locationDescription: String?
    public var city: String?
    public var distance: Double = 0.0
    public var zipCode: String?
    public var type: dataType
    
    public init() {
        self.date = Date()
        self.latitude = 0.0
        self.longitude = 0.0
        self.locationDescription = ""
        self.distance = 0.0
        self.zipCode = ""
        self.type = dataType.location
    }
}

class POITableCellView: UITableViewCell {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var info: UILabel!
}

class LocationTableViewContoller: UITableViewController {
    
    var locationToShow = [customDataCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(newLocationAdded(_:)),
            name: .newLocationSaved,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(newPOIAdded(_:)),
            name: .newPOISaved,
            object: nil)
        
    }
    
    func loadData() {
        locationToShow.removeAll()
        
        let locs = DataLocation().readLocations()
        let pois = DataPOI().readPOI()
        
        var toSort = [customDataCell]()
        
        for loc in locs {
            let customLoc = customDataCell()
            customLoc.date = loc.date
            customLoc.latitude = loc.latitude
            customLoc.longitude = loc.longitude
            customLoc.locationDescription = loc.locationDescription
            customLoc.type = dataType.location
            for poi in pois {
                if(loc.locationId == poi.locationId) {
                    customLoc.zipCode = poi.zipCode
                    customLoc.city = poi.city
                    customLoc.distance = poi.distance
                    customLoc.type = dataType.POI
                }
            }
            toSort.append(customLoc)
        }
        
        //POI and Location sorted
        locationToShow = toSort.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
        
    }
    
    @objc func newLocationAdded(_ notification: Notification) {
        loadData()
        tableView.reloadData()
    }
    
    @objc func newPOIAdded(_ notification: Notification) {
        loadData()
        tableView.reloadData()
    }
    
    
    @IBAction func purgePressed(_ sender: Any) {
        DataLocation().eraseLocations()
        DataPOI().erasePOI()
        locationToShow.removeAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Locations"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationToShow.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationData = locationToShow[indexPath.item]
        // Configure the cell
        let latitude = locationData.latitude
        let longitude = locationData.longitude
        
        if (locationToShow[indexPath.item].type == dataType.location) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
            cell.textLabel?.numberOfLines = 3
                        
            cell.textLabel?.text = String(format:"%f",latitude) + "," + String(format:"%f",longitude) 
            cell.detailTextLabel?.text = locationData.date!.stringFromDate()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as! POITableCellView
            cell.location.text = String(format:"%f",latitude) + "," + String(format:"%f",longitude)
            cell.time.text = locationData.date!.stringFromDate()
            cell.info.numberOfLines = 3
            cell.info.text = "City = " + locationData.city! + "\nZipcode = " + locationData.zipCode!  + "\nDistance = " + String(format:"%f",locationData.distance)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (locationToShow[indexPath.item].type == dataType.location) {
            return 60
        } else {
            return 110
        }
    }
    
}
