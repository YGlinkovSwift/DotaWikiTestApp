import UIKit

class TabBarViewController: UITabBarController  {
    
    let allHeroesViewController = AllHeroesViewController(dataProvider: DataProvider())
    let strangeHeroesViewController = StrangeHeroesViewController()
    let agilityHeroesViewController = AgilityHeroesViewController()
    let intelligenceHeroesViewController = IntelligenceHeroesViewController()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        configuteTabBar()
        setUpSearchBarLayout()
    }
    
    // MARK: - Private methods
    
    private func setUpSearchBarLayout() {
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = true
        searchBar.tintColor = .yellow
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Search all heroes by name..."
        searchBar.delegate = self
        searchBar.sizeToFit()
    }
    
    private func configuteTabBar() {
        self.setViewControllers([allHeroesViewController, strangeHeroesViewController, agilityHeroesViewController, intelligenceHeroesViewController], animated: false)
        setUpTabBarController()
        self.tabBar.contentMode = .scaleAspectFit
        self.tabBar.isTranslucent = false
        self.tabBar.alpha = 0.94
        self.tabBar.unselectedItemTintColor = .yellow
        self.tabBar.selectedImageTintColor = .lightGray
        self.navigationItem.titleView?.isHidden = false
    }
    
    private func setUpTabBarController() {
        allHeroesViewController.tabBarItem.badgeColor = .yellow
        [allHeroesViewController, strangeHeroesViewController, agilityHeroesViewController, intelligenceHeroesViewController].forEach {
            $0.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 6, bottom: -6, right: 6)
        }
        allHeroesViewController.tabBarItem.image = UIImage(named: "all")
        strangeHeroesViewController.tabBarItem.image = UIImage(named: "strangeImage")
        agilityHeroesViewController.tabBarItem.image = UIImage(named: "agilityImage")
        intelligenceHeroesViewController.tabBarItem.image = UIImage(named: "intelligenceImage")
        
    }
}

