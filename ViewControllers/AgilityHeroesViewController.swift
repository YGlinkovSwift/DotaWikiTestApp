import UIKit

final class AgilityHeroesViewController: UIViewController {
    
    //MARK: - Properties

    let agilityHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let backgroundIntoCollectionViewImageView = UIImageView()
    private let dataProvider = DataProvider()
    
    lazy var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.agilityHeroesCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        setUpCollectionViewLayout()
        configureCollectionView()
        dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes.filter { $0.heroMainAttribute == HeroMainAttributeEnum.agi }
            case .failure(let error):
                print("error \(error)")
            }
        }
        
    }
    
    //MARK: - Private methods

    private func setUpCollectionViewLayout() {
        view.addSubview(agilityHeroesCollectionView)
        agilityHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        agilityHeroesCollectionView.backgroundColor = .black
        agilityHeroesCollectionView.layer.borderWidth = 1
        backgroundIntoCollectionViewImageView.image = UIIMageEnum.dotaLogoImage
        backgroundIntoCollectionViewImageView.contentMode = .scaleAspectFit
        agilityHeroesCollectionView.backgroundView = backgroundIntoCollectionViewImageView
        
        NSLayoutConstraint.activate([
            agilityHeroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            agilityHeroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            agilityHeroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            agilityHeroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        agilityHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseIdentifierEnum.headerView)
        agilityHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: ReuseIdentifierEnum.customCell)
        agilityHeroesCollectionView.dataSource = self
        agilityHeroesCollectionView.delegate = self
    }
}




