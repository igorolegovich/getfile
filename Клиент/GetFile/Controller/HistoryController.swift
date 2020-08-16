import UIKit
import AVKit
import Photos
import WebKit

class HistoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Объявление элементов экрана
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonTrash: UIButton!
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    //  //  //  //  //  //
    @IBOutlet weak var constraintTopViewOptionsPostHistory: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomViewOptionsPostHistory: NSLayoutConstraint!
    @IBOutlet weak var viewOptionsPostHistory: UIView!
    
    @IBOutlet weak var imageAccountOptions: UIImageView!
    @IBOutlet weak var buttonNicknameOptions: UIButton!
    @IBOutlet weak var imagePostOptions: UIImageView!
    @IBOutlet weak var buttonPlayVideoOptions: UIButton!
    @IBOutlet weak var imageButtonPlayVideoOptions: UIImageView!
    
    @IBOutlet weak var buttonOpenPostOptions: UIButton!
    @IBOutlet weak var buttonCopyURLPostOptions: UIButton!
    @IBOutlet weak var buttonDownloadPostOptions: UIButton!
    @IBOutlet weak var buttonDeleteePostOptions: UIButton!
    
    @IBOutlet weak var buttonCancelOptions: UIButton!
    //  //  //  //  //  //
    @IBOutlet weak var constraintTopViewStatusLoad: NSLayoutConstraint!
    @IBOutlet weak var viewStatusLoad: UIView!
    @IBOutlet weak var labelStatusLoad: UILabel!
// MARK: - Объявление используемых переменных   //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    var AppModuleData = AppModuleBigData()
    
    var indexCurrentSN = Int()
    var currentSocialNetwork = String()
    let defaults = UserDefaults.standard
    
    let date = Date()
    let formatDate = DateFormatter()
    let formatTime = DateFormatter()
// MARK: - Жизненного цикла окна //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Первая загрузка окна
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatDate.dateFormat = "dd.MM.yyyy"
        formatTime.dateFormat = "HH:mm:ss"
        
        AppModuleData = AppModuleBigData.shared
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        AppModuleData.loadHistory()
        AppModuleData.removeCurrentPost()
    }
    // Изменение темы устройтсва (Светлая/Темная)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        historyCollectionView.reloadData()
    }
    // Анимирования экрана
    func animation(count : Double) {
        UIView.animate(withDuration: count, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
// MARK: - Верхняя панель меню //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Кнопка возвращения назад
    @IBAction func actionButtonBack(_ sender: Any) {
        if (!selectedSocialNetwork) {
            dismiss(animated: true, completion: nil)
        } else {
            AppModuleData.currentHistory = []
            titleName.text = nil
            buttonTrash.isHidden = true
            selectedSocialNetwork = false
            historyCollectionView.reloadData()
            animation(count: 0.75)
        }
    }
    // Кнопка очистки истории для выбранной социальной сети
    @IBAction func actionButtonTrash(_ sender: Any) {
        let alert = UIAlertController(title: "Внимание", message: "Вы уверены, что хотите очистить историю для \(currentSocialNetwork)?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            self.actionButtonBack(self)
            
            switch self.currentSocialNetwork {
            case "Instagram":
                self.AppModuleData.historyForInstagram.removeAll()
                break
            case "Youtube":
                self.AppModuleData.historyForYoutube.removeAll()
                break
            case "ВКонтакте":
                self.AppModuleData.historyForVK.removeAll()
                break
            case "Facebook":
                self.AppModuleData.historyForFacebook.removeAll()
                break
            default:
                break
            }
            
            self.AppModuleData.currentHistory.removeAll()
            self.saveSocialNetwork()
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel)
        
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
// MARK: - Вывод сообщений //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Вывод окна с сообщением для пользователя
    func ShowAlert(Title : String, Message : String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Вывод сообщений о загрузке
    func showAlertDownload(status : Bool) {
        viewStatusLoad.isHidden = false
        
        if (status) {
            viewStatusLoad.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            labelStatusLoad.text = "Загрузка завершена"
        } else {
            viewStatusLoad.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelStatusLoad.text = "Ошибка загрузки"
        }
        
        constraintTopViewStatusLoad.constant = 16
        animation(count: 0.75)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.constraintTopViewStatusLoad.constant = -100
            self.animation(count: 0.75)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.viewStatusLoad.isHidden = true
        }
    }
    // Вывод окна с выбором качества видеоролика
    private func showAlertDownloadVideo() {
        let alert = UIAlertController(title: nil, message: "Выберите доступное качество видео", preferredStyle: .actionSheet)
        if ((self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo1080p ?? "").length > 10) {
            let action1080p = UIAlertAction(title: "1080p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo1080p!)
            }
            
            alert.addAction(action1080p)
        }
        if ((self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo720p ?? "").length > 10) {
            let action720p = UIAlertAction(title: "720p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo720p!)
            }
            
            alert.addAction(action720p)
        }
        if ((self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo480p ?? "").length > 10) {
            let action480p = UIAlertAction(title: "480p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo480p!)
            }
            
            alert.addAction(action480p)
        }
        if ((self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo360p ?? "").length > 10) {
            let action360p = UIAlertAction(title: "360p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo360p!)
            }
            
            alert.addAction(action360p)
        }
        if ((self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo240p ?? "").length > 10) {
            let action240p = UIAlertAction(title: "240p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlForVideo240p!)
            }
            
            alert.addAction(action240p)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (alert) in }
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
// MARK: - Установление параметров для меню быстрого доступа к соц. сетям //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    var selectedSocialNetwork : Bool = false
    // Установление ширины и высоты ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(view.frame.size.width / 2 - 16), height: Int(view.frame.size.width / 2 - 16))
    }
    // Установление количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (!selectedSocialNetwork) {
            return AppModuleData.getCountSupportsNetworks()
        } else {
            return AppModuleData.currentHistory.count
        }
    }
    // Отображение ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (!selectedSocialNetwork) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionViewCell", for: indexPath as IndexPath) as! HistoryCollectionViewCell
            cell.configuration(indexSocialNetwork: indexPath.item, Data: AppModuleData)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryItemCollectionViewCell", for: indexPath as IndexPath) as! HistoryItemCollectionViewCell
            
            cell.configuration(url: AppModuleData.currentHistory[indexPath.row].urlImage ?? AppModuleData.currentHistory[indexPath.row].urlImageEdges![0], type: AppModuleData.currentHistory[indexPath.row].typePost!)
            
            return cell
        }
    }
    // Отклик нажатия по ячейкам
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (!selectedSocialNetwork) {
            let collectionCell = collectionView.cellForItem(at: indexPath) as! HistoryCollectionViewCell
            getSocialNetworkHistory(name : collectionCell.name)
        } else {
            indexCurrentSN = indexPath.item
            showViewOptions()
        }
    }
// MARK: - Взаимодействие с историей в памяти устройства //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Загрузка истории из памяти устройства
    func getSocialNetworkHistory(name : String) {
        switch name {
            case "Instagram":
                AppModuleData.currentHistory = AppModuleData.getHistoryInstagram()
                break
            case "Youtube":
                AppModuleData.currentHistory = AppModuleData.getHistoryYoutube()
                break
            case "ВКонтакте":
                AppModuleData.currentHistory = AppModuleData.getHistoryVK()
                break
            case "Facebook":
                AppModuleData.currentHistory = AppModuleData.getHistoryFacebook()
                break
            default:
                break
        }
        
        currentSocialNetwork = name
        
        if (AppModuleData.currentHistory.count > 0) {
            selectedSocialNetwork = true
            titleName.text = currentSocialNetwork
            buttonTrash.isHidden = false
            historyCollectionView.reloadData()
            animation(count: 0.75)
        } else {
            ShowAlert(Title: "Внимание", Message: "Истории скачиваний для \(name) нет.")
        }
    }
    // Функция для пересохранения записи внутри приложения
    func saveSocialNetwork() {
        AppModuleData.removeCurrentPost()
        AppModuleData.saveHistory(with: currentSocialNetwork)
        AppModuleData.loadHistory()
        historyCollectionView.reloadData()
    }
// MARK: - Пункты меню для окна взаимодействия с элементов из истории скачивания //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Отображение пунктов меню
    func showViewOptions() {
        buttonNicknameOptions.setTitle(AppModuleData.currentHistory[indexCurrentSN].nicknameUser, for: .normal)
        
        if (AppModuleData.currentHistory[indexCurrentSN].typePost == "GraphVideo") {
            buttonPlayVideoOptions.isHidden = false
            imageButtonPlayVideoOptions.isHidden = false
        } else {
            buttonPlayVideoOptions.isHidden = true
            imageButtonPlayVideoOptions.isHidden = true
        }
        
        DispatchQueue.global(qos: .utility).async {
            let imgAvatar = try? Data(contentsOf: URL(string: self.AppModuleData.currentHistory[self.indexCurrentSN].urlAvatar!)!)
            var imgPost = Data()
            if (self.AppModuleData.currentHistory[self.indexCurrentSN].typePost == "GraphSidecar") {
                imgPost = try! Data(contentsOf: URL(string: self.AppModuleData.currentHistory[self.indexCurrentSN].urlImageEdges![0])!)
            } else {
                imgPost = try! Data(contentsOf: URL(string: self.AppModuleData.currentHistory[self.indexCurrentSN].urlImage!)!)
            }
            
            DispatchQueue.main.async {
                self.imageAccountOptions.image = UIImage(data: imgAvatar!)
                self.imagePostOptions.image = UIImage(data: imgPost)
                self.imagePostOptions.isHidden = false
            }
        }
        
        constraintTopViewOptionsPostHistory.constant = 0
        constraintBottomViewOptionsPostHistory.constant = 0
        animation(count: 0.75)
    }
    // Кнопка перехода к учетной записи
    @IBAction func actionButtonOpenProfile(_ sender: Any) {
        var nickname = String()
        var urlAddressUser = String()
        
        nickname = AppModuleData.currentHistory[indexCurrentSN].nicknameUser ?? ""
        
        switch currentSocialNetwork {
            case "Instagram" :
                urlAddressUser = "https://www.instagram.com/\(nickname)"
                break
            case "Youtube" :
                urlAddressUser = "https://www.youtube.com/channel/\(AppModuleData.currentHistory[indexCurrentSN].idUser ?? "")"
                break
            case "ВКонтакте" :
                urlAddressUser = "https://www.vk.com/\(AppModuleData.currentHistory[indexCurrentSN].idUser ?? "")"
                break
            case "Facebook" :
                urlAddressUser = "https://www.facebook.com/profile.php?id=\(AppModuleData.currentHistory[indexCurrentSN].idUser ?? "")"
                break
            default :
                break
        }
        
        let alert = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите перейти к \(nickname)?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            UIApplication.shared.open(URL(string: urlAddressUser)!)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel) { (alert) in }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Отклик нажатия по элементу воиспроизведения видеоролика
    @IBAction func actionButtonPlayVideo(_ sender: Any) {
        var urlVideo = String()
        
        if (AppModuleData.currentHistory[indexCurrentSN].urlForVideo1080p != nil) {
            urlVideo = AppModuleData.currentHistory[indexCurrentSN].urlForVideo1080p!
        } else
        if (AppModuleData.currentHistory[indexCurrentSN].urlForVideo720p != nil) {
            urlVideo = AppModuleData.currentHistory[indexCurrentSN].urlForVideo720p!
        } else
        if (AppModuleData.currentHistory[indexCurrentSN].urlForVideo480p != nil) {
            urlVideo = AppModuleData.currentHistory[indexCurrentSN].urlForVideo480p!
        } else
        if (AppModuleData.currentHistory[indexCurrentSN].urlForVideo360p != nil) {
            urlVideo = AppModuleData.currentHistory[indexCurrentSN].urlForVideo360p!
        } else
        if (AppModuleData.currentHistory[indexCurrentSN].urlForVideo240p != nil) {
            urlVideo = AppModuleData.currentHistory[indexCurrentSN].urlForVideo240p!
        }
        
        let player = AVPlayer(url: URL(string: urlVideo)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    // Кнопка перехода по скопированной ссылке
    @IBAction func actionButtonOpenPost(_ sender: Any) {
        let url = URL(string: AppModuleData.currentHistory[indexCurrentSN].urlPost ?? "")
        
        if UIApplication.shared.canOpenURL(url!) {
            historyCollectionView.reloadData()
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            self.ShowAlert(Title: "Ошибка", Message: "Запись не может быть открыта.")
        }
    }
    // Кнопка копирования ссылки записи в память устройства
    @IBAction func actionButtonCopyURLPost(_ sender: Any) {
        UIPasteboard.general.string = AppModuleData.currentHistory[indexCurrentSN].urlPost
        actionHiddenViewOptions(self)
    }
    // Кнопка для скачивания
    @IBAction func actionButtonDownloadPost(_ sender: Any) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos != .authorized {
            PHPhotoLibrary.requestAuthorization({status in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Разрешите доступ", message: "Чтобы Вы могли сохранять фотографии и видео, GetFile нужен доступ к галерее.\n\nПожалуйста, включите доступ для GetFile в настройках устройства > Конфиденциальность > Фотографии.", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "Не сейчас", style: .cancel) { (alert) in }
                    let actionOK = UIAlertAction(title: "Настройки", style: .default) { (alert) in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    
                    alert.addAction(actionCancel)
                    alert.addAction(actionOK)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else {
            switch AppModuleData.currentHistory[indexCurrentSN].typePost {
                case "GraphImage":
                    UIImageWriteToSavedPhotosAlbum(imagePostOptions.image!, self, nil, nil)
                    self.showAlertDownload(status: true)
                    break
                case "GraphVideo":
                    showAlertDownloadVideo()
                    break
                case "GraphSidecar":
                    let alert = UIAlertController(title: nil, message: "Выберите тип скачивания:", preferredStyle: .actionSheet)
                    
                    let actionImage = UIAlertAction(title: "Только изображения", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges!.count - 1 {
                            if (self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges![i] == "GraphImage") {
                                let imageData = try? Data(contentsOf: URL(string: self.AppModuleData.currentHistory[self.indexCurrentSN].urlImageEdges![i])!)
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, self, nil, nil)
                            }
                        }
                        self.showAlertDownload(status: true)
                    }
                    alert.addAction(actionImage)
                    
                    let actionVideo = UIAlertAction(title: "Только видеоролики", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges!.count - 1 {
                            if (self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges![i] == "GraphVideo") {
                                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlVideoEdges![i])
                            }
                        }
                        self.showAlertDownload(status: true)
                    }
                    alert.addAction(actionVideo)
                    
                    let actionAll = UIAlertAction(title: "Всё", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges!.count - 1 {
                            if (self.AppModuleData.currentHistory[self.indexCurrentSN].typeEdges![i] == "GraphImage") {
                                let imageData = try? Data(contentsOf: URL(string: self.AppModuleData.currentHistory[self.indexCurrentSN].urlImageEdges![i])!)
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, self, nil, nil)
                            } else {
                                self.downloadVideo(url: self.AppModuleData.currentHistory[self.indexCurrentSN].urlVideoEdges![i])
                            }
                        }
                        self.showAlertDownload(status: true)
                    }
                    alert.addAction(actionAll)
                    
                    let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (alert) in }
                    alert.addAction(actionCancel)
                    
                    present(alert, animated: true, completion: nil)
                    break
                default:
                    break
            }
        }
    }
    // Кнопка для скачивания видеоролика
    private func downloadVideo(url : String) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url), let urlData = NSData(contentsOf: url) {
                let filePath = self.documentsPath + "/\(self.currentSocialNetwork)-\(self.formatDate.string(from: self.date)):\(self.formatTime.string(from: self.date)).mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    
                    if (self.AppModuleData.currentHistory[self.indexCurrentSN].typePost == "GraphVideo") {
                        self.showAlertDownload(status: true)
                    }
                    
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed { } else { }
                    }
                }
            }
        }
    }
    // Кнопка удаления записи из истории
    @IBAction func actionButtonDeletePost(_ sender: Any) {
        let alert = UIAlertController(title: "Внимание", message: "Вы уверены, что хотите удалить запись?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            self.AppModuleData.currentHistory.remove(at: self.indexCurrentSN)
            if (self.AppModuleData.currentHistory.count == 0) {
                self.actionButtonBack(self)
            }
            self.saveSocialNetwork()
            self.actionHiddenViewOptions(self)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel) { (alert) in }
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    // Кнопка для скрытия меню взаимодействия с записью
    @IBAction func actionHiddenViewOptions(_ sender: Any) {
        constraintTopViewOptionsPostHistory.constant = view.frame.height + 50
        constraintBottomViewOptionsPostHistory.constant = -1 * view.frame.height + 50
        animation(count: 0.75)
        
        imageAccountOptions.image = nil
        imagePostOptions.image = nil
        buttonNicknameOptions.setTitle(nil, for: .normal)
    }
}
