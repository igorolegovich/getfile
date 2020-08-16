import UIKit

class HistoryItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var typePostImage: UIImageView!
    
    func configuration(url : String, type : String) {
        shadowView.removeShadowSublayers()
        shadowView.addShadow()
        
        switch type {
            case "GraphSidecar":
                typePostImage.image = UIImage.init(systemName: "rectangle.fill.on.rectangle.fill")
                break
            case "GraphVideo":
                typePostImage.image = UIImage.init(systemName: "play.fill")
                break
            default:
                typePostImage.image = nil
        }
        DispatchQueue.global(qos: .background).async {
            let imgPost = try? Data(contentsOf: URL(string: url)!)
            
            DispatchQueue.main.async {
                if (imgPost != nil) {
                    self.mainImage.image = UIImage(data: imgPost!)
                }
            }
        }
    }
}
