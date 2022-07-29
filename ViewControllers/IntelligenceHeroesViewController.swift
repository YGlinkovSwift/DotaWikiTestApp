import UIKit
//
class IntelligenceHeroesViewController: UIViewController {
    
    let textField = UITextField()

    let intelligenceHeroesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let networkingManager = NetworkingManager()

    var heroes: [Hero] = [] {
        didSet {
            DispatchQueue.main.async {
                self.intelligenceHeroesCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        view.backgroundColor = .red
        setUpCollectionViewLayout()
        configureCollectionView()
        setUpTextField()
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

    private func setUpCollectionViewLayout() {
        view.addSubview(intelligenceHeroesCollectionView)
        intelligenceHeroesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        intelligenceHeroesCollectionView.backgroundColor = .black
        intelligenceHeroesCollectionView.layer.borderWidth = 1

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

extension IntelligenceHeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sortedStrangeHeroes = heroes.filter { $0.heroMainAttribute == "int"}
        return sortedStrangeHeroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else { return UICollectionViewCell() }
        let sortedHeroesAlphabetically = heroes.filter { $0.heroMainAttribute == "int"}
        let cellModel = sortedHeroesAlphabetically[indexPath.row]
        cell.configure(with: cellModel)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let sortedHeroAlphabetically = allHeroesViewController.heroes.sorted { $0.heroName < $1.heroName }
//        let hero = sortedHeroAlphabetically[indexPath.row]
//        let heroDetailsViewController = HeroDetailsViewController(hero: allHeroesViewController.heroes)
//        heroDetailsViewController.hero = [hero].self
//        self.navigationController?.pushViewController(heroDetailsViewController, animated: true)
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

extension IntelligenceHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }

}

