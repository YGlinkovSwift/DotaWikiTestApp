import UIKit

final class StrangeHeroesViewController: UIViewController {
    
    //MARK: - Properties

    let strangeHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let dataProvider = DataProvider()
    private let backgroundIntoCollectionViewImageView = UIImageView()
    lazy var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.strangeHeroesCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        setUpCollectionViewLayout()
        configureCollectionView()
        dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes.filter { $0.heroMainAttribute == HeroMainAttributeEnum.str }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    //MARK: - Private methods
    
    private func setUpCollectionViewLayout() {
        view.addSubview(strangeHeroesCollectionView)
        strangeHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        strangeHeroesCollectionView.backgroundColor = .black
        strangeHeroesCollectionView.layer.borderWidth = 1
        backgroundIntoCollectionViewImageView.image = UIIMageEnum.dotaLogoImage
        backgroundIntoCollectionViewImageView.contentMode = .scaleAspectFit
        strangeHeroesCollectionView.backgroundView = backgroundIntoCollectionViewImageView
        
        NSLayoutConstraint.activate([
            strangeHeroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            strangeHeroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            strangeHeroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            strangeHeroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        strangeHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseIdentifierEnum.headerView)
        strangeHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: ReuseIdentifierEnum.customCell)
        strangeHeroesCollectionView.dataSource = self
        strangeHeroesCollectionView.delegate = self
    }
}
