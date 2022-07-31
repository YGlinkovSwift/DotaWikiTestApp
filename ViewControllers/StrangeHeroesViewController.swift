import UIKit

class StrangeHeroesViewController: UIViewController {

    let strangeHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let networkingManager = NetworkingManager()
    var dataProvider = DataProvider()
    let backgroundIntoCollectionViewImageView = UIImageView()
    
    var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.strangeHeroesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        setUpCollectionViewLayout()
        configureCollectionView()
        print("there are \(heroes.count)")
        
        dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes.filter { $0.heroMainAttribute == "str" }
            case .failure(let error):
                print("error \(error)")
            }
        }
        
        
    }
    
    private func setUpCollectionViewLayout() {
        view.addSubview(strangeHeroesCollectionView)
        strangeHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        strangeHeroesCollectionView.backgroundColor = .black
        strangeHeroesCollectionView.layer.borderWidth = 1
        backgroundIntoCollectionViewImageView.image = UIImage(named: "dotaLogoImage")
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
        strangeHeroesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        strangeHeroesCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        strangeHeroesCollectionView.dataSource = self
        strangeHeroesCollectionView.delegate = self
    }
}

extension StrangeHeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else { return UICollectionViewCell() }
        let sortedHeroesAlphabetically = heroes.sorted { $0.heroName < $1.heroName }
        let cellModel = sortedHeroesAlphabetically[indexPath.row]
        cell.configure(with: cellModel)
        return cell
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sortedHeroAlphabetically = heroes.sorted { $0.heroName < $1.heroName }
        let hero = sortedHeroAlphabetically[indexPath.row]
        let heroDetailsViewController = HeroDetailsViewController(hero: heroes)
        heroDetailsViewController.hero = [hero].self
        self.navigationController?.pushViewController(heroDetailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let leftAndRightPaddings: CGFloat = 45.0
            let numberOfItemsPerRow: CGFloat = 3.0
            let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        return view
        
    }
}

extension StrangeHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 0 , height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}

