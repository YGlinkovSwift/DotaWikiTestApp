import UIKit

class HeaderView: UICollectionReusableView {
    
    var headerImageView = UIImageView()
    let searchBar = UISearchBar()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setUpLayout()
   
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        //headerImageView.image = UIImage(named: "dotaLogoImage")
        addSubview(headerImageView)
        headerImageView.contentMode = .scaleAspectFit

        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            headerImageView.widthAnchor.constraint(equalToConstant: 80),
            headerImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}

