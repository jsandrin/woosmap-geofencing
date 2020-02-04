//
//  SearchAPiJson.swift
//  WoosmapNowNotification
//
//

import Foundation

struct SearchAPIJson_Base : Codable {
    let type : String?
    let features : [Features]?
    let pagination : Pagination?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case features = "features"
        case pagination = "pagination"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        features = try values.decodeIfPresent([Features].self, forKey: .features)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
    
}

struct Address : Codable {
    let lines : String?
    let country_code : String?
    let city : String?
    let zipcode : String?
    
    enum CodingKeys: String, CodingKey {
        
        case lines = "lines"
        case country_code = "country_code"
        case city = "city"
        case zipcode = "zipcode"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lines = try values.decodeIfPresent(String.self, forKey: .lines)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
    }
    
}

struct Features : Codable {
    let type : String?
    let properties : Properties?
    let geometry : Geometry?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case properties = "properties"
        case geometry = "geometry"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        properties = try values.decodeIfPresent(Properties.self, forKey: .properties)
        geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
    }
    
}

struct Geometry : Codable {
    let type : String?
    let coordinates : [Double]?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case coordinates = "coordinates"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        coordinates = try values.decodeIfPresent([Double].self, forKey: .coordinates)
    }
    
}

struct Pagination : Codable {
    let page : Int?
    let pageCount : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case pageCount = "pageCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
    }
    
}

struct Properties : Codable {
    let store_id : String?
    let name : String?
    let contact : String?
    let address : Address?
    let user_properties : User_properties?
    let tags : [String]?
    let types : [String]?
    let distance : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case store_id = "store_id"
        case name = "name"
        case contact = "contact"
        case address = "address"
        case user_properties = "user_properties"
        case tags = "tags"
        case types = "types"
        case distance = "distance"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        user_properties = try values.decodeIfPresent(User_properties.self, forKey: .user_properties)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        types = try values.decodeIfPresent([String].self, forKey: .types)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
    }
    
}

struct User_properties : Codable {
    let aSCII_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case aSCII_name = "ASCII_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aSCII_name = try values.decodeIfPresent(String.self, forKey: .aSCII_name)
    }
    
}
