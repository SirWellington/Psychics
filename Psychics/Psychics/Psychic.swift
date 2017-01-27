//
//  Psychic.swift
//  Psychics
//
//  Created by Wellington Moreno on 1/27/17.
//  Copyright © 2017 Wellington Moreno. All rights reserved.
//

import Foundation

struct Psychic {
    
    let extID: String
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
