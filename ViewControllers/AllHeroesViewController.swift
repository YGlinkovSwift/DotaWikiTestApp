import UIKit
import CoreData

class AllHeroesViewController: UIViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    

    let networkingManager = NetworkingManager()
    var dataProvider = DataProvider()
    let backgroundIntoCollectionViewImageView = UIImageView()
    let textField = UITextField()
    let allHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let searchBar = UISearchBar()
    let searchController = UISearchController()
    let strangeHeroesViewController = StrangeHeroesViewController()

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
    

     lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
         let fetchRequest = Item.fetchRequest()
         //let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
         //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "heroName", ascending: true)]
         
         let sort = [NSSortDescriptor(key: #keyPath(Item.heroName), ascending: false), NSSortDescriptor(key: #keyPath(Item.heroPortraitImageURL), ascending: false)]
        fetchRequest.sortDescriptors = sort
        let fetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataProvider.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedController.delegate = self

        do {
            try fetchedController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("\(nserror)")
        }

        return fetchedController
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        dataProvider.fetchHeroes { error in
            print("can't fetch heroes!!!")
        }
        setUpSearchBarLayoutX()
        setUpNetworkProperties()
        setUpCollectionViewLayout()
        configureCollectionView()
        fetchedResultsController.delegate = self
        //setUpSearchBarLayout()
        
    }
    
    
    private func setUpTextField() {
        view.addSubview(textField)
        textField.backgroundColor = .blue
        textField.textColor = .green
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpSearchBarLayoutX() {
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        searchBar.tintColor = .yellow
        //searchBar.searchTextField.isUserInteractionEnabled = true
        //searchBar.searchTextField.becomeFirstResponder()
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Search all heroes by name..."
        searchBar.delegate = self
        searchBar.sizeToFit()
    }
    
//    private func setUpSearchBarLayout() {
//        self.navigationItem.titleView = self.searchController.searchBar
//        self.navigationItem.titleView?.isHidden = false
//        searchController.searchBar.placeholder = "Search all heroes by name..."
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.definesPresentationContext = true
//        searchController.searchBar.becomeFirstResponder()
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        navigationItem.hidesSearchBarWhenScrolling = true
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.isUserInteractionEnabled = true
//        searchController.searchBar.isTranslucent = true
//        searchController.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
//    }
    
    private func setUpNetworkProperties() {
        networkingManager.request(endpoint: HeroesAPI.heroes)  { (result: Result<[Hero], NetworkingError>)  in
            switch result {
            case .success(let dotaHeroes):
                self.heroes = dotaHeroes
                self.strangeHeroesViewController.heroes = dotaHeroes.filter { $0.heroMainAttribute == "str" }
            case .failure(let error):
                print(error)
            }
        }
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
            allHeroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            allHeroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        allHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        allHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        allHeroesCollectionView.dataSource = self
        allHeroesCollectionView.delegate = self
    }

}
