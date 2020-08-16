import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backgroundForInstagram: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var logoSocialNetwork: UIImageView!
    
    @IBOutlet weak var viewCountDownloads: UIView!
    @IBOutlet weak var labelCountDownloads: UILabel!
    
    var name = String()
    
    // Формирования строкового значения числа записей в истории
    func getText(Count : Int) -> String {
        var textDownloads = String()
        var ostCount : Int = Count % 100
        
        ostCount = ostCount % 10
        switch ostCount {
            case 1:
                textDownloads = "запись"
                break
            case 2:
                textDownloads = "записи"
                break
            case 3:
                textDownloads = "записи"
                break
            case 4:
                textDownloads = "записи"
                break
            default:
                textDownloads = "записей"
                break
        }
        
        return "\(Count) \(textDownloads)"
    }
    
    func configuration(indexSocialNetwork : Int, Data : AppModuleBigData) {
        let localData = AppModuleBigData.shared
        shadowView.removeShadowSublayers()
        shadowView.addShadow()
        
        backgroundColorView.backgroundColor = localData.getColorSocialNetwork(with: indexSocialNetwork)
        logoSocialNetwork.image = UIImage(named: Data.getWhiteLogoSocailNetworks(with: indexSocialNetwork))
        name = Data.getNameSocialNetwork(with: indexSocialNetwork)
        
        switch indexSocialNetwork {
            case 0:
                labelCountDownloads.text = getText(Count: Data.historyForInstagram.count)
                break
            case 1:
                labelCountDownloads.text = getText(Count: Data.historyForYoutube.count)
                break
            case 2:
                labelCountDownloads.text = getText(Count: Data.historyForVK.count)
                break
            case 3:
                labelCountDownloads.text = getText(Count: Data.historyForFacebook.count)
                break
            default:
                break
        }
    }
}
