import UIKit

class HeroDetailsViewController: UIViewController {
    
    var hero: [Hero]
    
    let heroPictureImageView = UIImageView()
    let heroNameLabel = UILabel()
    var heroImage = UIImage()
    var heroIconImageView = UIImageView()
    let heroAttributeStrangeLabel = UILabel()
    let heroAttributeAgilityLabel = UILabel()
    let heroAttributeIntelligenceLabel = UILabel()
    let heroGameRolesLabel = UILabel()
    let strangeAttributeIconImageView = UIImageView()
    let agilityAttributeIconImageView = UIImageView()
    let intelligenceAttributeIconImageView = UIImageView()
    let heroMainAttributeImageView = UIImageView()
    var heroMoveSpeedImageView = UIImageView()
    let heroMoveSpeedLabel = UILabel()
    let heroAttackTypeImageView = UIImageView()
    let heroAttackTypeLabel = UILabel()
    let heroAttackRangeImageView = UIImageView()
    let heroAttackRangeLabel = UILabel()
    let currentPatchLabel = UILabel()
    let textField = UITextField()

    
    init(hero: [Hero]) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setUpCurrentPatchLabel()
        setUpTextField()
        
    }
    
    private func setUpTextField() {
        view.addSubview(textField)
        textField.backgroundColor = .blue
        textField.textColor = .red
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func setUpHeroPictureImageViewLayout() {
        view.addSubview(heroPictureImageView)
        heroPictureImageView.contentMode = .scaleAspectFit
        heroPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let baseLink = "https://api.opendota.com"
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
        heroIconImageView.contentMode = .scaleAspectFit
        heroIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroIconImageView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor),
            heroIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroIconImageView.widthAnchor.constraint(equalToConstant: 40),
            heroIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroMoveSpeedImageViewLayout() {
        view.addSubview(heroMoveSpeedImageView)
        heroMoveSpeedImageView.image = UIImage(named: "heroMoveSpeedImage")
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
        heroMoveSpeedLabel.textColor = .yellow
        heroMoveSpeedLabel.font = .systemFont(ofSize: 25)
        heroMoveSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroMoveSpeedLabel.leadingAnchor.constraint(equalTo: heroMoveSpeedImageView.trailingAnchor, constant: 10),
            heroMoveSpeedLabel.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            heroMoveSpeedLabel.widthAnchor.constraint(equalToConstant: 60),
            heroMoveSpeedLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackTypeImageViewLayout() {
        view.addSubview(heroAttackTypeImageView)
        heroAttackTypeImageView.image = UIImage(named: "heroTypeAttackImage")
        heroAttackTypeImageView.contentMode = .scaleAspectFit
        heroAttackTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroAttackTypeImageView.leadingAnchor.constraint(equalTo: heroAttributeAgilityLabel.trailingAnchor, constant: 30),
            heroAttackTypeImageView.topAnchor.constraint(equalTo: heroMoveSpeedImageView.bottomAnchor, constant: 10),
            heroAttackTypeImageView.widthAnchor.constraint(equalToConstant: 60),
            heroAttackTypeImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackTypeLabelLayout() {
        view.addSubview(heroAttackTypeLabel)
        
        if hero[0].heroAttackType == "Ranged" {
            heroAttackTypeLabel.text = "Range"
        } else {
            heroAttackTypeLabel.text = hero[0].heroAttackType
        }
        
        heroAttackTypeLabel.textColor = .yellow
        heroAttackTypeLabel.font = .systemFont(ofSize: 25)
        heroAttackTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroAttackTypeLabel.leadingAnchor.constraint(equalTo: heroAttackTypeImageView.trailingAnchor),
            heroAttackTypeLabel.topAnchor.constraint(equalTo: heroMoveSpeedLabel.bottomAnchor, constant: 10),
            heroAttackTypeLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttackTypeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroAttackRangeImageViewLayout() {
        view.addSubview(heroAttackRangeImageView)
        heroAttackRangeImageView.image = UIImage(named: "heroAttackRangeImage")
        heroAttackRangeImageView.contentMode = .scaleAspectFill
        heroAttackRangeImageView.translatesAutoresizingMaskIntoConstraints = false
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
        heroAttackRangeLabel.font = .systemFont(ofSize: 25)
        heroAttackRangeLabel.textColor = .yellow
        heroAttackRangeLabel.translatesAutoresizingMaskIntoConstraints = false
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
        if hero[0].heroMainAttribute == "str" {
            heroNameLabel.textColor = .red
        }
        if hero[0].heroMainAttribute == "agi" {
            heroNameLabel.textColor = .green
        }
        if hero[0].heroMainAttribute == "int" {
            heroNameLabel.textColor = .tintColor
        }
        heroNameLabel.textAlignment = .center
        heroNameLabel.font = .systemFont(ofSize: 25)
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroNameLabel.topAnchor.constraint(equalTo: heroPictureImageView.bottomAnchor, constant: 10),
            heroNameLabel.centerXAnchor.constraint(equalTo: heroPictureImageView.centerXAnchor),
            heroNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            heroNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpHeroMainAttributeImageView() {
        view.addSubview(heroMainAttributeImageView)
        heroMainAttributeImageView.contentMode = .scaleAspectFit
        if hero[0].heroMainAttribute == "str" {
            heroMainAttributeImageView.image = UIImage(named: "strangeImage")
        }
        if hero[0].heroMainAttribute == "agi" {
            heroMainAttributeImageView.image = UIImage(named: "agilityImage")
        }
        if hero[0].heroMainAttribute == "int" {
            heroMainAttributeImageView.image = UIImage(named: "intelligenceImage")
        }
        
        heroMainAttributeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroMainAttributeImageView.topAnchor.constraint(equalTo: heroIconImageView.bottomAnchor, constant: 5),
            heroMainAttributeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroMainAttributeImageView.widthAnchor.constraint(equalToConstant: 40),
            heroMainAttributeImageView.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
    
    private func setUpStrangeAttributePictureImageViewLayout() {
        view.addSubview(strangeAttributeIconImageView)
        strangeAttributeIconImageView.image = UIImage(named: "strangeImage")
        strangeAttributeIconImageView.contentMode = .scaleAspectFit
        strangeAttributeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        heroAttributeStrangeLabel.textAlignment = .center
        heroAttributeStrangeLabel.textColor = .red
        heroAttributeStrangeLabel.font = .systemFont(ofSize: 25)
        heroAttributeStrangeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroAttributeStrangeLabel.topAnchor.constraint(equalTo: heroMainAttributeImageView.bottomAnchor, constant: 10),
            heroAttributeStrangeLabel.leadingAnchor.constraint(equalTo: strangeAttributeIconImageView.trailingAnchor),
            heroAttributeStrangeLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttributeStrangeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpAgilityAttributePictureImageViewLayout() {
        view.addSubview(agilityAttributeIconImageView)
        agilityAttributeIconImageView.image = UIImage(named: "agilityImage")
        agilityAttributeIconImageView.contentMode = .scaleAspectFit
        agilityAttributeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        heroAttributeAgilityLabel.textAlignment = .center
        heroAttributeAgilityLabel.textColor = .green
        heroAttributeAgilityLabel.font = .systemFont(ofSize: 25)
        heroAttributeAgilityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroAttributeAgilityLabel.topAnchor.constraint(equalTo: heroAttributeStrangeLabel.bottomAnchor, constant: 10),
            heroAttributeAgilityLabel.leadingAnchor.constraint(equalTo: agilityAttributeIconImageView.trailingAnchor),
            heroAttributeAgilityLabel.widthAnchor.constraint(equalToConstant: 100),
            heroAttributeAgilityLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    

    private func setUpIntelligenceAttributePictureImageViewLayout() {
        view.addSubview(intelligenceAttributeIconImageView)
        intelligenceAttributeIconImageView.image = UIImage(named: "intelligenceImage")
        intelligenceAttributeIconImageView.contentMode = .scaleAspectFit
        intelligenceAttributeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        heroAttributeIntelligenceLabel.textAlignment = .center
        heroAttributeIntelligenceLabel.textColor = .tintColor
        heroAttributeIntelligenceLabel.font = .systemFont(ofSize: 25)
        heroAttributeIntelligenceLabel.translatesAutoresizingMaskIntoConstraints = false
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
        heroGameRolesLabel.textAlignment = .center
        heroGameRolesLabel.font = .systemFont(ofSize: 20)
        heroGameRolesLabel.numberOfLines = 2
        heroGameRolesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heroGameRolesLabel.topAnchor.constraint(equalTo: heroAttributeIntelligenceLabel.bottomAnchor, constant: 10),
            heroGameRolesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroGameRolesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroGameRolesLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setUpCurrentPatchLabel() {
        view.addSubview(currentPatchLabel)
        currentPatchLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPatchLabel.text = "7.31d"
        currentPatchLabel.textColor = .red
        currentPatchLabel.font = .systemFont(ofSize: 25)
        NSLayoutConstraint.activate([
            currentPatchLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currentPatchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentPatchLabel.widthAnchor.constraint(equalToConstant: 60),
            currentPatchLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
