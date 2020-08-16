import UIKit
import Photos

class LaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let photos = PHPhotoLibrary.authorizationStatus()
        if photos != .authorized {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("Доступ к галерее открыт")
                } else {
                    print("Доступ к галерее не предоставлен")
                }
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let map = mainStoryboard.instantiateViewController(withIdentifier: "MainMenuController") as? MainMenuController {
                self.present(map, animated: true, completion: nil)
            }
        }
    }
}
