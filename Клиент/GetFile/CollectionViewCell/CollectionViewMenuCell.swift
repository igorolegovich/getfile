import UIKit

class CollectionViewMenuCell: UICollectionViewCell {
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var colorBackground: UIView!
    @IBOutlet weak var imageLogoNetwork: UIImageView!
    @IBOutlet weak var labelNameNetwork: UILabel!
    
    var nameSocialNetworks : [String] = ["Instagram",
                                         "Youtube",
                                         "ВКонтакте",
                                         "Facebook"]
    
    var colorSocialNetwork : [UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0),
                                          #colorLiteral(red: 0.768627451, green: 0.1882352941, blue: 0.168627451, alpha: 1),
                                          #colorLiteral(red: 0.2745098039, green: 0.5019607843, blue: 0.7607843137, alpha: 1),
                                          #colorLiteral(red: 0.1137254902, green: 0.3607843137, blue: 0.9019607843, alpha: 1)]
    
    var MenuLogoSocialNetworks_White : [String] = ["MenuWhiteInstagram",
                                                   "MenuWhiteYoutube",
                                                   "MenuWhiteVK",
                                                   "MenuWhiteFacebook"]
    
    var MenuLogoSocialNetworks_Black : [String] = ["MenuBlackInstagram",
                                                   "MenuBlackYoutube",
                                                   "MenuBlackVK",
                                                   "MenuBlackFacebook"]
    
    func configuration(indexSocialNetwork : Int, currentIndexSocialNetwork : Int) {
        labelNameNetwork.text = nameSocialNetworks[indexSocialNetwork]
        
        if (indexSocialNetwork == currentIndexSocialNetwork) {
            if (indexSocialNetwork == 0) {
                imageBackground.image = #imageLiteral(resourceName: "backgroundInstagram")
            }
            
            colorBackground.backgroundColor = colorSocialNetwork[indexSocialNetwork]
            imageLogoNetwork.image = UIImage(named: MenuLogoSocialNetworks_White[indexSocialNetwork])
            labelNameNetwork.textColor = .white
        } else {
            if traitCollection.userInterfaceStyle == .dark {
                imageLogoNetwork.image = UIImage(named: MenuLogoSocialNetworks_White[indexSocialNetwork])
            } else {
                imageLogoNetwork.image = UIImage(named: MenuLogoSocialNetworks_Black[indexSocialNetwork])
            }
        }
    }
    
    func clearCell() {
        imageBackground.image = nil
        colorBackground.backgroundColor = nil
        imageLogoNetwork.image = nil
        labelNameNetwork.textColor = .label
        labelNameNetwork.text = nil
    }
}
