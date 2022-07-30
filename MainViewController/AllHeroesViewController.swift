import UIKit
import CoreData

class AllHeroesViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    
    let networkingManager = NetworkingManager()
    var dataProvider = DataProvider()
    let backgroundIntoCollectionViewImageView = UIImageView()
    let textField = UITextField()
    let allHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.allHeroesCollectionView.reloadData()
            }
        }
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
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        
        dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure(let error):
                print("error \(error)")
            }
        }
       
        setUpNetworkProperties()
        setUpCollectionViewLayout()
        configureCollectionView()
        fetchedResultsController.delegate = self
        
    }
    
    //MARK: - Private methods
    
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

    private func setUpNetworkProperties() {
        networkingManager.request(endpoint: HeroesAPI.heroes)  { (result: Result<[Hero], NetworkingError>)  in
            switch result {
            case .success(let dotaHeroes):
                self.heroes = dotaHeroes
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
