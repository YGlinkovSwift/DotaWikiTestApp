import UIKit
import CoreData

class HeaderView: UICollectionReusableView {
    
    var headerImageView = UIImageView()
    let searchBar = UISearchBar()
    let allHeroesViewController = AllHeroesViewController(dataProvider: DataProvider())
    let dataProvider = DataProvider()
    let networkingManager = NetworkingManager()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
