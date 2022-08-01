import Foundation
import UIKit

public enum UIIMageEnum {
    static let dotaLogoImage = UIImage(named: "dotaLogoImage")
    static let agilityImage = UIImage(named: "agilityImage")
    static let heroAttackRangeImage = UIImage(named: "heroAttackRangeImage")
    static let heroMoveSpeedImage = UIImage(named: "heroMoveSpeedImage")
    static let heroTypeAttackImage = UIImage(named: "heroTypeAttackImage")
    static let intelligenceImage = UIImage(named: "intelligenceImage")
    static let strangeImage = UIImage(named: "strangeImage")
    static let AllIconImage = UIImage(named: "all")
    
}

public enum UIFontEnum {
    static let warriorBrushWithSize35 = UIFont(name: "Warrior Brush", size: 35)
    static let warriorBrushWithSize25 = UIFont(name: "Warrior Brush", size: 25)
    static let warriorBrushWithSize20 = UIFont(name: "Warrior Brush", size: 20)
    static let warriorBrushWithSize15 = UIFont(name: "Warrior Brush", size: 15)
    
}

public enum ReuseIdentifierEnum {
    static let headerView = "HeaderView"
    static let customCell = "CustomCell"
}

public enum BaseLinkEnum {
    static let baseLinkURL = "https://api.opendota.com"
}

public enum SearchBarEnum {
    static let emptyText = ""
    static let placeholder = "Search all heroes by name..."
}

public enum AlertEnum {
    static let cancelAction = "Cancel"
    static let refreshAction = "Refresh"
    static let alertMessage = "No result matches about request: "
    static let emptyTitle = ""
}

public enum HeroAttackTypeEnum {
    static let ranged = "Ranged"
    static let range = "Range"
}

public enum HeroMainAttributeEnum {
    static let str = "str"
    static let agi = "agi"
    static let int = "int"
}

public enum AppNameLabelEnum {
    static let dota = "DOTA"
    static let wiki = "WIKI"
}

public enum CoreDataEnums {
    static let containerName = "DotaWiki"
    static let Item = "Item"
    static let predicateFormat = "heroName in %@"
    static let heroName = "heroName"
    static let heroPortraitImageURL = "heroPortraitImageURL"
}
