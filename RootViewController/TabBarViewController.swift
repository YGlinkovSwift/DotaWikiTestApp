import UIKit

final class TabBarViewController: UITabBarController  {
    
    //MARK: - Private properties
    
    private let allHeroesViewController = AllHeroesViewController(dataProvider: DataProvider())
    private let strangeHeroesViewController = StrangeHeroesViewController()
    private let agilityHeroesViewController = AgilityHeroesViewController()
    private let intelligenceHeroesViewController = IntelligenceHeroesViewController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        configureTabBar()
        configureRefreshButton()
    }
    
    // MARK: - Private methods
    
    private func configureRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    }
    
    private func configureTabBar() {
        self.setViewControllers([allHeroesViewController, strangeHeroesViewController, agilityHeroesViewController, intelligenceHeroesViewController], animated: false)
        setUpTabBarController()
        self.tabBar.contentMode = .scaleAspectFit
        self.tabBar.isTranslucent = false
        self.tabBar.alpha = 0.94
        self.tabBar.unselectedItemTintColor = .yellow
        self.tabBar.tintColor = .lightGray
        self.navigationItem.titleView?.isHidden = false
    }
    
    private func setUpTabBarController() {
        allHeroesViewController.tabBarItem.badgeColor = .yellow
        [allHeroesViewController, strangeHeroesViewController, agilityHeroesViewController, intelligenceHeroesViewController].forEach {
            $0.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 6, bottom: -6, right: 6)
        }
        allHeroesViewController.tabBarItem.image = UIIMageEnum.AllIconImage
        strangeHeroesViewController.tabBarItem.image = UIIMageEnum.strangeImage
        agilityHeroesViewController.tabBarItem.image = UIIMageEnum.agilityImage
        intelligenceHeroesViewController.tabBarItem.image = UIIMageEnum.intelligenceImage
    }
    
    //MARK: - Actions
    @objc func refreshButtonTapped() {
        allHeroesViewController.searchBar.text = SearchBarEnum.emptyText
        allHeroesViewController.dataProvider.fetchHeroes { result in
            switch result {
            case .success(let heroes):
                self.allHeroesViewController.heroes = heroes
            case .failure(let error):
                print("error \(error)")
            }
        }
        [strangeHeroesViewController.strangeHeroesCollectionView, allHeroesViewController.allHeroesCollectionView, agilityHeroesViewController.agilityHeroesCollectionView, intelligenceHeroesViewController.intelligenceHeroesCollectionView].forEach {
            $0.reloadData()
        }
    }
}
