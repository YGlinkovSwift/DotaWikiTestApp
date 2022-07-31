import UIKit
import CoreData

extension AllHeroesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
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
    
}

extension AllHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16 , height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension AllHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataProvider.fetchHeroesPredicate(for: searchText) { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
                print("sucesss!!! I found your heroes!!! here they are -\(heroes)")
                DispatchQueue.main.async {
                    self.allHeroesCollectionView.reloadData()
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
        self.allHeroesCollectionView.reloadData()
    }
}

extension AllHeroesViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.allHeroesCollectionView.reloadData()
    }

}


