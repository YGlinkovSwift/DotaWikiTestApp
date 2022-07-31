import UIKit

final class IntelligenceHeroesViewController: UIViewController {
    
    //MARK: - Properties
    
   private let intelligenceHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   private let dataProvider = DataProvider()
   private let backgroundIntoCollectionViewImageView = UIImageView()
   lazy var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.intelligenceHeroesCollectionView.reloadData()
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
                self.heroes = heroes.filter { $0.heroMainAttribute == "int" }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    //MARK: - Private methods

    private func setUpCollectionViewLayout() {
        view.addSubview(intelligenceHeroesCollectionView)
        intelligenceHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        intelligenceHeroesCollectionView.backgroundColor = .black
        intelligenceHeroesCollectionView.layer.borderWidth = 1
        backgroundIntoCollectionViewImageView.image = UIImage(named: "dotaLogoImage")
        backgroundIntoCollectionViewImageView.contentMode = .scaleAspectFit
        intelligenceHeroesCollectionView.backgroundView = backgroundIntoCollectionViewImageView

        NSLayoutConstraint.activate([
            intelligenceHeroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            intelligenceHeroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            intelligenceHeroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            intelligenceHeroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func configureCollectionView() {
        intelligenceHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        intelligenceHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        intelligenceHeroesCollectionView.dataSource = self
        intelligenceHeroesCollectionView.delegate = self
    }
}



