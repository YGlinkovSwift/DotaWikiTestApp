import UIKit

class HeaderView: UICollectionReusableView {
    
    //MARK: - Private properties
    
    private let headerImageView = UIImageView()
    private let leftAppNameLabel = UILabel()
    private let rightAppNameLabel = UILabel()
    
    //MARK: - Initializtion
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpAppNameTextLabelInsideHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setUpAppNameTextLabelInsideHeaderView() {
        [leftAppNameLabel, rightAppNameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .systemIndigo
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 25)
        }
        addSubview(leftAppNameLabel)
        leftAppNameLabel.text = "DOTA"
        NSLayoutConstraint.activate([
            leftAppNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftAppNameLabel.trailingAnchor.constraint(equalTo: headerImageView.leadingAnchor),
            leftAppNameLabel.widthAnchor.constraint(equalToConstant: 90),
            leftAppNameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        addSubview(rightAppNameLabel)
        rightAppNameLabel.text = "WIKI"
        NSLayoutConstraint.activate([
            rightAppNameLabel.leadingAnchor.constraint(equalTo: headerImageView.trailingAnchor),
            rightAppNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightAppNameLabel.widthAnchor.constraint(equalToConstant: 90),
            rightAppNameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpLayout() {
        headerImageView.image = UIImage(named: "dotaLogoImage")
        addSubview(headerImageView)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            headerImageView.widthAnchor.constraint(equalToConstant: 90),
            headerImageView.heightAnchor.constraint(equalToConstant: 65)

            
        ])
    }
}


