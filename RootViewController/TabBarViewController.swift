import UIKit

final class TabBarViewController: UITabBarController  {
    
    //MARK: - Private properties
    
    private let allHeroesViewController = AllHeroesViewController(dataProvider: DataProvider())
    private let strangeHeroesViewController = StrangeHeroesViewController()
    private let agilityHeroesViewController = AgilityHeroesViewController()
    private let intelligenceHeroesViewController = IntelligenceHeroesViewController()
    private let refreshButton = UIButton()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        configuteTabBar()
        configureRefreshButton()
    }
    
    // MARK: - Private methods
    
    private func configureRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    }
    
    private func configuteTabBar() {
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
        allHeroesViewController.tabBarItem.image = UIImage(named: "all")
        strangeHeroesViewController.tabBarItem.image = UIImage(named: "strangeImage")
        agilityHeroesViewController.tabBarItem.image = UIImage(named: "agilityImage")
        intelligenceHeroesViewController.tabBarItem.image = UIImage(named: "intelligenceImage")
    }
    
    //MARK: - Actions
    @objc func refreshButtonTapped() {
        allHeroesViewController.allHeroesCollectionView.reloadData()
    }
}


