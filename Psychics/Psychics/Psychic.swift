//
//  Psychic.swift
//  Psychics
//
//  Created by Wellington Moreno on 1/27/17.
//  Copyright © 2017 Wellington Moreno. All rights reserved.
//

import Foundation

struct Psychic {
    
    let extId: String
    let lineName: String
    let groupId: String
    let usp: String
    let basePrice: Double
    let isCustomerPick: Bool
    let isStaffPick: Bool
    let isRisingStar: Bool
    let customerPrice: Double
    let lineStatus: String
    let lineStatusDisplay: String
    let isPsychicAvailable: Bool
    let images: [URL]
    let tools: String
    let skills: [String]
    let specialties: String
    let style: String
    
    
    init?(jsonDictionary json: NSDictionary) {
        
        guard let extId = json[JSONKeys.extId] as? String,
              let lineName = json[JSONKeys.lineName] as? String,
              let groupId = json[JSONKeys.groupId] as? String,
              let usp = json[JSONKeys.usp] as? String,
              let basePrice = json[JSONKeys.basePrice] as? Double,
              let isCustomerPick = json[JSONKeys.isCustomerPick] as? Bool,
              let isStaffPick = json[JSONKeys.isStaffPick] as? Bool,
              let isRisingStar = json[JSONKeys.isRisingStar] as? Bool,
              let customerPrice = json[JSONKeys.customerPrice] as? Double,
              let lineStatus = json[JSONKeys.lineStatus] as? String,
              let lineStatusDisplay = json[JSONKeys.lineStatusDisplay] as? String,
              let isPsychicAvailable = json[JSONKeys.isPsychicAvailable] as? Bool,
              let imagesArray = json[JSONKeys.images] as? NSArray as? [String],
              let tools = json[JSONKeys.tools] as? String,
              let skillsString = json[JSONKeys.skills] as? String,
              let specialties = json[JSONKeys.specialties] as? String,
              let style = json[JSONKeys.style] as? String
        else {
            return nil
        }
        
        let images: [URL] = imagesArray
            .map() { $0.replacingOccurrences(of: "test-www", with: "www") } //Fixes broken test image links
            .flatMap(URL.init) //Converts Strings to URLs
        
        let skills = skillsString.components(separatedBy: ",")
        
        self.extId = extId
        self.lineName = lineName
        self.groupId = groupId
        self.usp = usp
        self.basePrice = basePrice
        self.isCustomerPick = isCustomerPick
        self.isStaffPick = isStaffPick
        self.isRisingStar = isRisingStar
        self.customerPrice = customerPrice
        self.lineStatus = lineStatus
        self.lineStatusDisplay = lineStatusDisplay
        self.isPsychicAvailable = isPsychicAvailable
        self.images = images
        self.tools = tools
        self.skills = skills
        self.specialties = specialties
        self.style = style
    }
}

fileprivate struct JSONKeys {
    static let extId = "extId"
    static let lineName = "lineName"
    static let groupId = "groupId"
    static let usp = "usp"
    static let basePrice = "basePrice"
    static let isCustomerPick = "isCustomerPick"
    static let isStaffPick = "isStaffPick"
    static let isRisingStar = "isRisingStar"
    static let customerPrice = "customerPrice"
    static let lineStatus = "lineStatus"
    static let lineStatusDisplay = "lineStatusDisplay"
    static let isPsychicAvailable = "isPsychicAvailable"
    static let images = "images"
    static let tools = "tools"
    static let skills = "skills"
    static let specialties = "specialties"
    static let style = "style"
    static let serviceStartYear = "serviceStartYear"
}
