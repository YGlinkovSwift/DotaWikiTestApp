import UIKit

final class CustomCell: UICollectionViewCell {
    
    private lazy var HeroNameTextLabel = UILabel()
    private let HeroPortraitImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeroPortraitImageViewLayout()
        setUpHeroNameTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpHeroPortraitImageViewLayout() {
        contentView.addSubview(HeroPortraitImageView)
        HeroPortraitImageView.layer.borderWidth = 0
        HeroPortraitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            HeroPortraitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HeroPortraitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HeroPortraitImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            HeroPortraitImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setUpHeroNameTextLabel() {
        contentView.addSubview(HeroNameTextLabel)
        HeroNameTextLabel.numberOfLines = 2
        HeroNameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        HeroNameTextLabel.textColor = .black
        HeroNameTextLabel.textAlignment = .center
        HeroNameTextLabel.layer.borderWidth = 0
        HeroNameTextLabel.textColor = .white
        HeroNameTextLabel.font = UIFont.systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            HeroNameTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HeroNameTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HeroNameTextLabel.topAnchor.constraint(equalTo: HeroPortraitImageView.bottomAnchor, constant: 5)
        ])
    }
    
    func configure(with model: Hero) {
        HeroPortraitImageView.contentMode = .scaleAspectFit
        HeroNameTextLabel.text = model.heroName
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + model.heroPortraitImageURL
        HeroPortraitImageView.loadImageFromUrl(urlString: completeLink)
        
        if model.heroMainAttribute == "str" {
            HeroNameTextLabel.textColor = .red
        }
        if model.heroMainAttribute == "agi" {
            HeroNameTextLabel.textColor = .green
        }
        if model.heroMainAttribute == "int" {
            HeroNameTextLabel.textColor = .tintColor
        }
    
    }
    
    override func prepareForReuse() {
        self.HeroPortraitImageView.image = HeroPortraitImageView.image
        self.HeroNameTextLabel.text = HeroNameTextLabel.text
    }
    
}

