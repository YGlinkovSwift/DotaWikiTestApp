import UIKit
import CoreData

final class AllHeroesViewController: UIViewController {
    
    //MARK: - Properties
    
    var dataProvider = DataProvider()
    private let backgroundIntoCollectionViewImageView = UIImageView()
    let searchBar = UISearchBar()
    let allHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.allHeroesCollectionView.reloadData()
            }
        }
    }

    //MARK: - Initialization

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
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
        hideKeyboardWhenTappedAround()
    }

    //MARK: - Private methods
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AllHeroesViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func setUpSearchBarLayout() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        searchBar.tintColor = .yellow
        searchBar.endEditing(true)
        searchBar.keyboardType = .default
        searchBar.searchTextField.textColor = .yellow
        searchBar.backgroundColor = .black
        searchBar.barTintColor = .black
        searchBar.returnKeyType = .search
        searchBar.placeholder = SearchBarEnum.placeholder
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setUpCollectionViewLayout() {
        view.addSubview(allHeroesCollectionView)
        allHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        backgroundIntoCollectionViewImageView.image = UIIMageEnum.dotaLogoImage
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
        allHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseIdentifierEnum.headerView)
        allHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: ReuseIdentifierEnum.customCell)
        allHeroesCollectionView.dataSource = self
        allHeroesCollectionView.delegate = self
    }
    
    func showAlert() {
        let alert = UIAlertController(title: AlertEnum.emptyTitle, message: AlertEnum.alertMessage + searchBar.text!, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AlertEnum.cancelAction, style: .destructive)
        let refreshAction = UIAlertAction(title: AlertEnum.refreshAction, style: .default) { _ in
            self.searchBar.text = SearchBarEnum.emptyText
            self.dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure(let error):
                print("error \(error)")
            }
        }
            self.allHeroesCollectionView.reloadData()
        }
        
        alert.addAction(refreshAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    //MARK: - Actions
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }

}
