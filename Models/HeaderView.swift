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
        //setUpLayout()
        setUpSearchBarLayout()
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func getItemsPredicate(with name: String) {
//        dataProvider.fetchHeroesPredicate(for: name) { result in
//            switch result {
//            case .success(_):
//                self.getItemsPredicate(with: name)
//                self.allHeroesViewController.allHeroesCollectionView.reloadData()
//            case.failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func setUpSearchBarLayout() {
        addSubview(searchBar)
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        searchBar.tintColor = .yellow
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Search all heroes by name..."
        searchBar.delegate = self
        searchBar.sizeToFit()
    }
    
    private func setUpLayout() {
        addSubview(headerImageView)
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            headerImageView.widthAnchor.constraint(equalToConstant: 80),
            headerImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}

extension HeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataProvider.fetchHeroesPredicate(for: searchText) { result in
            switch result {
            case .success(_):
                
                DispatchQueue.main.async {
                    self.allHeroesViewController.allHeroesCollectionView.reloadData()
                }
            case .failure(_):
                print("error, can't reload data")
            }
        }
        allHeroesViewController.allHeroesCollectionView.reloadData()
    }
    
}

extension HeaderView: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        allHeroesViewController.allHeroesCollectionView.reloadData()
    }
    
}
