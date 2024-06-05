import Foundation

enum AlphabeticalOrder: String {
    case forward, reversed
}

enum FavouriteArticlesSortType: CaseIterable, Hashable {
    
    case createdAt
    case alphabetical(AlphabeticalOrder)
    
    static var allCases: [FavouriteArticlesSortType] {
        [.createdAt, .alphabetical(.forward), .alphabetical(.reversed)]
    }
    
    var rawValue: String {
        switch self {
        case .createdAt:
            return "lastModified"
        case .alphabetical(let alphabeticalOrder):
            switch alphabeticalOrder {
            case .forward:
                return "alphabetical_forward"
            case .reversed:
                return "alphabetical_reversed"
            }
        }
    }
    
    var title: String {
        switch self {
        case .createdAt:
            return "Data utworzenia"
        case .alphabetical(let alphabeticalOrder):
            switch alphabeticalOrder {
            case .forward:
                return "Alfabetycznie od A do Z"
            case .reversed:
                return "Alfabetycznie od Z do A"
            }
        }
    }
}
