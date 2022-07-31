import UIKit
import CoreData

class AllHeroesViewController: UIViewController {
    
    var dataProvider = DataProvider()
    let backgroundIntoCollectionViewImageView = UIImageView()
    let searchBar = UISearchBar()
    let allHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.allHeroesCollectionView.reloadData()
            }
        }
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure(let error):
                print("error \(error)")
            }
        }
        setUpSearchBarLayout()
        setUpCollectionViewLayout()
        configureCollectionView()
    }
    
    //MARK: - Private methods
    
    private func setUpSearchBarLayout() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        searchBar.tintColor = .yellow
        searchBar.searchTextField.textColor = .red
        searchBar.backgroundColor = .black
        searchBar.barTintColor = .black
        searchBar.placeholder = "Search all heroes by name..."
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            searchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
    }
    
    private func setUpCollectionViewLayout() {
        view.addSubview(allHeroesCollectionView)
        allHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        backgroundIntoCollectionViewImageView.image = UIImage(named: "dotaLogoImage")
        backgroundIntoCollectionViewImageView.contentMode = .scaleAspectFit
        allHeroesCollectionView.backgroundColor = .black
        allHeroesCollectionView.backgroundView = backgroundIntoCollectionViewImageView
        allHeroesCollectionView.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            allHeroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allHeroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allHeroesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            allHeroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        allHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        allHeroesCollectionView.dataSource = self
        allHeroesCollectionView.delegate = self
    }

}

