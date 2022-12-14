import UIKit

final class CustomCell: UICollectionViewCell {
    
    //MARK: - Private properties
    
    private lazy var HeroNameTextLabel = UILabel()
    private let HeroPortraitImageView = UIImageView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeroPortraitImageViewLayout()
        setUpHeroNameTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setUpHeroPortraitImageViewLayout() {
        contentView.addSubview(HeroPortraitImageView)
        HeroPortraitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            HeroPortraitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HeroPortraitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HeroPortraitImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
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
        HeroNameTextLabel.font = UIFontEnum.warriorBrushWithSize15
        
        NSLayoutConstraint.activate([
            HeroNameTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HeroNameTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HeroNameTextLabel.topAnchor.constraint(equalTo: HeroPortraitImageView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with model: Hero) {
        HeroPortraitImageView.contentMode = .scaleAspectFit
        HeroNameTextLabel.text = model.heroName
        
        let defaultLink = BaseLinkEnum.baseLinkURL
        let completeLink = defaultLink + model.heroPortraitImageURL
        HeroPortraitImageView.loadImageFromUrl(urlString: completeLink)
        
        if model.heroMainAttribute == HeroMainAttributeEnum.str {
            HeroNameTextLabel.textColor = .red
        }
        if model.heroMainAttribute == HeroMainAttributeEnum.agi {
            HeroNameTextLabel.textColor = .green
        }
        if model.heroMainAttribute == HeroMainAttributeEnum.int {
            HeroNameTextLabel.textColor = .cyan
        }
    
    }
    
    override func prepareForReuse() {
        self.HeroPortraitImageView.image = HeroPortraitImageView.image
        self.HeroNameTextLabel.text = HeroNameTextLabel.text
    }
    
}

