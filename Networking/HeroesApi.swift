import Foundation

enum HeroesAPI: API {
    case heroes
    
    var scheme: HTTPScheme {
        switch self {
        case .heroes:
            return .https
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .heroes:
            return .get
        }
    }
    
    var baseURL: String {
        switch self {
        case .heroes:
            return "api.opendota.com"
       
        }
    }
    
    var patch: String {
        switch self {
        case .heroes:
            return "/api/heroStats"
        }
    }
    
}
