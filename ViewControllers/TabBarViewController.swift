import UIKit


class TabBarViewController: UITabBarController {
    
    let allHeroesViewController = AllHeroesViewController(dataProvider: DataProvider())
    let strangeHeroesViewController = StrangeHeroesViewController()
    let agilityHeroesViewController = AgilityHeroesViewController()
    let intelligenceHeroesViewController = IntelligenceHeroesViewController()
    let searchController = UISearchController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        configuteTabBar()
        setUpSearchBarLayout()
    }
    

    private func configuteTabBar() {
        self.setViewControllers([allHeroesViewController, strangeHeroesViewController, agilityHeroesViewController, intelligenceHeroesViewController], animated: false)
        setUpTabBarController()
        self.tabBar.contentMode = .scaleAspectFit
        self.tabBar.backgroundColor = .black
        self.tabBar.unselectedItemTintColor = .yellow
        self.tabBar.selectedImageTintColor = .lightGray
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.titleView?.isHidden = false

    }
    private func setUpSearchBarLayout() {
        

        searchController.searchBar.placeholder = "Search all heroes by name..."
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.becomeFirstResponder()

        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.isUserInteractionEnabled = true
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
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


