import UIKit

final class HeroDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var hero: [Hero]
    private let heroPictureImageView = UIImageView()
    private let heroNameLabel = UILabel()
    private var heroImage = UIImage()
    private var heroIconImageView = UIImageView()
    private let heroAttributeStrangeLabel = UILabel()
    private let heroAttributeAgilityLabel = UILabel()
    private let heroAttributeIntelligenceLabel = UILabel()
    private let heroGameRolesLabel = UILabel()
    private let strangeAttributeIconImageView = UIImageView()
    private let agilityAttributeIconImageView = UIImageView()
    private let intelligenceAttributeIconImageView = UIImageView()
    private let heroMainAttributeImageView = UIImageView()
    private var heroMoveSpeedImageView = UIImageView()
    private let heroMoveSpeedLabel = UILabel()
    private let heroAttackTypeImageView = UIImageView()
    private let heroAttackTypeLabel = UILabel()
    private let heroAttackRangeImageView = UIImageView()
    private let heroAttackRangeLabel = UILabel()

    //MARK: - Initialization
    
    init(hero: [Hero]) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpHeroPictureImageViewLayout()
        setUpHeroNameLabelLayout()
        setUpHeroIconImageViewLayout()
        setUpHeroMainAttributeImageView()
        setUpStrangeAttributePictureImageViewLayout()
        setUpBaseStrangeLabelLayout()
        setUpHeroMoveSpeedImageViewLayout()
        setUpHeroMoveSpeedLabelLayout()
        setUpAgilityAttributePictureImageViewLayout()
        setUpBaseAgilityLabelLayout()
        setUpIntelligenceAttributePictureImageViewLayout()
        setUpBaseIntLabelLayout()
        setUpHeroRolesLabelLayout()
        setUpHeroAttackTypeImageViewLayout()
        setUpHeroAttackTypeLabelLayout()
        setUpHeroAttackRangeImageViewLayout()
        setUpHeroAttackRangeLabelLayout()
        forEachIntoElementsOptimizeCodeMethod()
    }
    
    //MARK: Private methods
    
    private func forEachIntoElementsOptimizeCodeMethod() {
        [heroPictureImageView, heroIconImageView, heroAttackTypeImageView, heroAttackRangeImageView,strangeAttributeIconImageView, agilityAttributeIconImageView, intelligenceAttributeIconImageView].forEach {
            $0.contentMode = .scaleAspectFit
        }
        
        [heroPictureImageView, heroNameLabel, heroIconImageView, heroAttributeStrangeLabel, heroAttributeAgilityLabel, heroAttributeIntelligenceLabel, heroGameRolesLabel, strangeAttributeIconImageView, agilityAttributeIconImageView, intelligenceAttributeIconImageView, heroMainAttributeImageView, heroMoveSpeedImageView, heroMoveSpeedLabel,heroAttackTypeImageView, heroAttackTypeLabel, heroAttackRangeImageView,heroAttackRangeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [heroNameLabel, heroAttributeStrangeLabel, heroAttributeAgilityLabel, heroAttributeIntelligenceLabel, heroGameRolesLabel].forEach {
            $0.textAlignment = .center
        }
        
        [heroAttackRangeLabel,heroAttackTypeLabel,heroMoveSpeedLabel].forEach {
            $0.textColor = .yellow
        }
        
        [heroAttributeIntelligenceLabel, heroAttributeAgilityLabel, heroAttributeStrangeLabel,  heroAttackRangeLabel, heroMoveSpeedLabel].forEach {
            $0.font = UIFontEnum.ancientTulipWithSize23
        }

    }

    private func setUpHeroPictureImageViewLayout() {
        view.addSubview(heroPictureImageView)
        let baseLink = BaseLinkEnum.baseLinkURL
        let fullHeroPortraitImageLink = baseLink + hero[0].heroPortraitImageURL
        let fullHeroIconImageLink = baseLink + hero[0].heroIconImageURL
        heroPictureImageView.loadImageFromUrl(urlString: fullHeroPortraitImageLink)
        heroIconImageView.loadImageFromUrl(urlString: fullHeroIconImageLink)
        NSLayoutConstraint.activate([
            heroPictureImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            heroPictureImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroPictureImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            heroPictureImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.175)
        ])
    }
    
    private func setUpHeroIconImageViewLayout() {
        view.addSubview(heroIconImageView)
        NSLayoutConstraint.activate([
            heroIconImageView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor),
            heroIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroIconImageView.widthAnchor.constraint(equalToConstant: 40),
            heroIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroMoveSpeedImageViewLayout() {
        view.addSubview(heroMoveSpeedImageView)
        heroMoveSpeedImageView.image = UIIMageEnum.heroMoveSpeedImage
        heroMoveSpeedImageView.contentMode = .scaleAspectFill
        heroMoveSpeedImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroMoveSpeedImageView.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            heroMoveSpeedImageView.leadingAnchor.constraint(equalTo: heroAttributeStrangeLabel.trailingAnchor, constant: 40),
            heroMoveSpeedImageView.heightAnchor.constraint(equalToConstant: 40),
            heroMoveSpeedImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroMoveSpeedLabelLayout() {
        view.addSubview(heroMoveSpeedLabel)
        heroMoveSpeedLabel.text = String(hero[0].heroMoveSpeed)
        NSLayoutConstraint.activate([
            heroMoveSpeedLabel.leadingAnchor.constraint(equalTo: heroMoveSpeedImageView.trailingAnchor, constant: 10),
            heroMoveSpeedLabel.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            heroMoveSpeedLabel.widthAnchor.constraint(equalToConstant: 60),
            heroMoveSpeedLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackTypeImageViewLayout() {
        view.addSubview(heroAttackTypeImageView)
        heroAttackTypeImageView.image = UIIMageEnum.heroTypeAttackImage
        NSLayoutConstraint.activate([
            heroAttackTypeImageView.leadingAnchor.constraint(equalTo: heroAttributeAgilityLabel.trailingAnchor, constant: 30),
            heroAttackTypeImageView.topAnchor.constraint(equalTo: heroMoveSpeedImageView.bottomAnchor, constant: 10),
            heroAttackTypeImageView.widthAnchor.constraint(equalToConstant: 60),
            heroAttackTypeImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackTypeLabelLayout() {
        view.addSubview(heroAttackTypeLabel)
        
        if hero[0].heroAttackType == HeroAttackTypeEnum.ranged  {
            heroAttackTypeLabel.text = HeroAttackTypeEnum.range
        } else {
            heroAttackTypeLabel.text = hero[0].heroAttackType
        }
        
        heroAttackTypeLabel.font = UIFontEnum.warriorBrushWithSize23
        NSLayoutConstraint.activate([
            heroAttackTypeLabel.leadingAnchor.constraint(equalTo: heroAttackTypeImageView.trailingAnchor),
            heroAttackTypeLabel.topAnchor.constraint(equalTo: heroMoveSpeedLabel.bottomAnchor, constant: 10),
            heroAttackTypeLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttackTypeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackRangeImageViewLayout() {
        view.addSubview(heroAttackRangeImageView)
        heroAttackRangeImageView.image = UIIMageEnum.heroAttackRangeImage
        NSLayoutConstraint.activate([
            heroAttackRangeImageView.leadingAnchor.constraint(equalTo: heroAttributeIntelligenceLabel.trailingAnchor, constant: 30),
            heroAttackRangeImageView.topAnchor.constraint(equalTo: heroAttackTypeImageView.bottomAnchor, constant: 10),
            heroAttackRangeImageView.widthAnchor.constraint(equalToConstant: 50),
            heroAttackRangeImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackRangeLabelLayout() {
        view.addSubview(heroAttackRangeLabel)
        heroAttackRangeLabel.text = String(hero[0].heroAttackRange)
        NSLayoutConstraint.activate([
            heroAttackRangeLabel.leadingAnchor.constraint(equalTo: heroAttackRangeImageView.trailingAnchor, constant: 10),
            heroAttackRangeLabel.topAnchor.constraint(equalTo: heroAttackTypeLabel.bottomAnchor, constant: 10),
            heroAttackRangeLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttackRangeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroNameLabelLayout() {
        view.addSubview(heroNameLabel)
        heroNameLabel.text = hero[0].heroName
        heroNameLabel.textColor = .yellow
        heroNameLabel.font = UIFontEnum.warriorBrushWithSize25
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.str {
            heroNameLabel.textColor = .red
        }
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.agi {
            heroNameLabel.textColor = .green
        }
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.int {
            heroNameLabel.textColor = .cyan
        }
        
        NSLayoutConstraint.activate([
            heroNameLabel.topAnchor.constraint(equalTo: heroPictureImageView.bottomAnchor, constant: 10),
            heroNameLabel.centerXAnchor.constraint(equalTo: heroPictureImageView.centerXAnchor),
            heroNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            heroNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroMainAttributeImageView() {
        view.addSubview(heroMainAttributeImageView)
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.str {
            heroMainAttributeImageView.image = UIIMageEnum.strangeImage
        }
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.agi {
            heroMainAttributeImageView.image = UIIMageEnum.agilityImage
        }
        if hero[0].heroMainAttribute == HeroMainAttributeEnum.int {
            heroMainAttributeImageView.image = UIIMageEnum.intelligenceImage
        }
        NSLayoutConstraint.activate([
            heroMainAttributeImageView.topAnchor.constraint(equalTo: heroIconImageView.bottomAnchor, constant: 5),
            heroMainAttributeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroMainAttributeImageView.widthAnchor.constraint(equalToConstant: 40),
            heroMainAttributeImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpStrangeAttributePictureImageViewLayout() {
        view.addSubview(strangeAttributeIconImageView)
        strangeAttributeIconImageView.image = UIIMageEnum.strangeImage
        NSLayoutConstraint.activate([
            strangeAttributeIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            strangeAttributeIconImageView.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            strangeAttributeIconImageView.widthAnchor.constraint(equalToConstant: 37),
            strangeAttributeIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpBaseStrangeLabelLayout() {
        view.addSubview(heroAttributeStrangeLabel)
        heroAttributeStrangeLabel.text = "\(hero[0].heroBaseStrange) + \(hero[0].heroStrangePerLevel)"
        heroAttributeStrangeLabel.textColor = .red
        NSLayoutConstraint.activate([
            heroAttributeStrangeLabel.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            heroAttributeStrangeLabel.leadingAnchor.constraint(equalTo: strangeAttributeIconImageView.trailingAnchor),
            heroAttributeStrangeLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttributeStrangeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpAgilityAttributePictureImageViewLayout() {
        view.addSubview(agilityAttributeIconImageView)
        agilityAttributeIconImageView.image = UIIMageEnum.agilityImage
        NSLayoutConstraint.activate([
            agilityAttributeIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            agilityAttributeIconImageView.topAnchor.constraint(equalTo: strangeAttributeIconImageView.bottomAnchor, constant: 10),
            agilityAttributeIconImageView.widthAnchor.constraint(equalToConstant: 37),
            agilityAttributeIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpBaseAgilityLabelLayout() {
        view.addSubview(heroAttributeAgilityLabel)
        heroAttributeAgilityLabel.text = "\(hero[0].heroBaseAgility) + \(hero[0].heroAgilityPerLevel)"
        heroAttributeAgilityLabel.textColor = .green
        NSLayoutConstraint.activate([
            heroAttributeAgilityLabel.topAnchor.constraint(equalTo: heroAttributeStrangeLabel.bottomAnchor, constant: 10),
            heroAttributeAgilityLabel.leadingAnchor.constraint(equalTo: agilityAttributeIconImageView.trailingAnchor),
            heroAttributeAgilityLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttributeAgilityLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpIntelligenceAttributePictureImageViewLayout() {
        view.addSubview(intelligenceAttributeIconImageView)
        intelligenceAttributeIconImageView.image = UIIMageEnum.intelligenceImage
        NSLayoutConstraint.activate([
            intelligenceAttributeIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            intelligenceAttributeIconImageView.topAnchor.constraint(equalTo: agilityAttributeIconImageView.bottomAnchor, constant: 10),
            intelligenceAttributeIconImageView.widthAnchor.constraint(equalToConstant: 37),
            intelligenceAttributeIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpBaseIntLabelLayout() {
        view.addSubview(heroAttributeIntelligenceLabel)
        heroAttributeIntelligenceLabel.text = "\(hero[0].heroBaseIntelligence) + \(hero[0].heroIntelligencePerLevel)"
        heroAttributeIntelligenceLabel.textColor = .tintColor
        NSLayoutConstraint.activate([
            heroAttributeIntelligenceLabel.topAnchor.constraint(equalTo: heroAttributeAgilityLabel.bottomAnchor, constant: 10),
            heroAttributeIntelligenceLabel.leadingAnchor.constraint(equalTo: intelligenceAttributeIconImageView.trailingAnchor),
            heroAttributeIntelligenceLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttributeIntelligenceLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpHeroRolesLabelLayout() {
        view.addSubview(heroGameRolesLabel)
        heroGameRolesLabel.text = "\(hero[0].heroGameRoles.joined(separator: ", "))"
        heroGameRolesLabel.textColor = .white
        heroGameRolesLabel.font = UIFontEnum.warriorBrushWithSize20
        heroGameRolesLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            heroGameRolesLabel.topAnchor.constraint(equalTo: heroAttributeIntelligenceLabel.bottomAnchor, constant: 10),
            heroGameRolesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroGameRolesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroGameRolesLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
    
}
