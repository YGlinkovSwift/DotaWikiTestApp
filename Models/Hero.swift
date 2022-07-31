import Foundation

struct Hero: Codable {
    let heroName: String
    let heroMainAttribute: String
    let heroAttackType: String
    let heroPortraitImageURL: String
    let heroIconImageURL: String
    let heroBaseStrange: Int
    let heroBaseAgility: Int
    let heroBaseIntelligence: Int
    let heroStrangePerLevel: Double
    let heroAgilityPerLevel: Double
    let heroIntelligencePerLevel: Double
    let heroAttackRange: Int
    let heroMoveSpeed: Int
    let heroGameRoles: [String]
    
    enum CodingKeys: String, CodingKey {
        case heroName = "localized_name"
        case heroMainAttribute = "primary_attr"
        case heroAttackType = "attack_type"
        case heroPortraitImageURL = "img"
        case heroIconImageURL = "icon"
        case heroBaseStrange = "base_str"
        case heroBaseAgility = "base_agi"
        case heroBaseIntelligence = "base_int"
        case heroStrangePerLevel = "str_gain"
        case heroAgilityPerLevel = "agi_gain"
        case heroIntelligencePerLevel = "int_gain"
        case heroAttackRange = "attack_range"
        case heroMoveSpeed = "move_speed"
        case heroGameRoles = "roles"
    }

}
