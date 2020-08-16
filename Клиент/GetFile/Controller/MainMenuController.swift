import UIKit
import AVKit
import Photos
import WebKit

class MainMenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Объявление элементов экрана
    @IBOutlet weak var viewMainContent: UIView!
    @IBOutlet weak var constraintTopForViewMainContent: NSLayoutConstraint!
    @IBOutlet weak var constraintLeadingForViewMainContent: NSLayoutConstraint!
    @IBOutlet weak var constraintTrailingForViewMainContent: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomForViewMainContent: NSLayoutConstraint!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewColorPaletteSocialNetwork: UIView!
    @IBOutlet weak var constraintTopForViewColorPaletteSocialNetwork: NSLayoutConstraint!
    @IBOutlet weak var constraintLeadingForViewColorPaletteSocialNetwork: NSLayoutConstraint!
    @IBOutlet weak var constraintTrailingForViewColorPaletteSocialNetwork: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomForViewColorPaletteSocialNetwork: NSLayoutConstraint!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewInstagramBackground: UIImageView!
    @IBOutlet weak var constraintTopForViewInstagramBackground: NSLayoutConstraint!
    @IBOutlet weak var constraintLeadingForViewInstagramBackground: NSLayoutConstraint!
    @IBOutlet weak var constraintTrailingForViewInstagramBackground: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomForViewInstagramBackground: NSLayoutConstraint!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet var gestureSwipeToRight: UISwipeGestureRecognizer!
    @IBOutlet var gestureSwipeToLeft: UISwipeGestureRecognizer!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewTitleView: UIView!
    @IBOutlet weak var constraintheightForViewTitlePage: NSLayoutConstraint!
    @IBOutlet weak var labelTitleView: UILabel!
    @IBOutlet weak var bottomSeparatorTitleView: UIView!
    //// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewButtonMenu: UIVisualEffectView!
    @IBOutlet weak var buttonMenuList: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonDownload: UIButton!
    @IBOutlet weak var buttonHistory: UIButton!
    @IBOutlet weak var constraintWidthForButtonMenuList: NSLayoutConstraint!
    @IBOutlet weak var constraintWidthForButtonDownload: NSLayoutConstraint!
    @IBOutlet weak var constraintWidthForButtonHistory: NSLayoutConstraint!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var imageSocialNetworkLogo: UIButton!
    @IBOutlet weak var labelSocialNetworkName: UIButton!
    @IBOutlet weak var indicatorLoadData: UIActivityIndicatorView!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewStatusLoad: UIView!
    @IBOutlet weak var constraintTopViewStatusLoad: NSLayoutConstraint!
    @IBOutlet weak var labedStatusLoad: UILabel!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var viewSearchContent: UIView!
    
    @IBOutlet weak var imageAvatarUser: UIImageView!
    @IBOutlet weak var labelNicknameUser: UILabel!
    @IBOutlet weak var labelCountSubscribesUser: UILabel!
    @IBOutlet weak var buttonNicknameUser: UIButton!
    @IBOutlet weak var buttonOpenPost: UIButton!
    @IBOutlet weak var constraintWidthButtonOpenPost: NSLayoutConstraint!
    @IBOutlet weak var viewNumbersForPost: UIView!
    
    @IBOutlet weak var viewSwipeContentPost: UIView!
    
    @IBOutlet weak var image1ContentPost: UIImageView!
    @IBOutlet weak var constraintCenterForImage1: NSLayoutConstraint!
    
    @IBOutlet weak var image2ContentPost: UIImageView!
    @IBOutlet weak var constraintCenterForImage2: NSLayoutConstraint!
    
    @IBOutlet weak var image3ContentPost: UIImageView!
    @IBOutlet weak var constraintCenterForImage3: NSLayoutConstraint!
    
    @IBOutlet weak var imageIconPlayVideo: UIImageView!
    @IBOutlet var gesturePanForSwipeImageEdges: UIPanGestureRecognizer!
    @IBOutlet var gestureTapForPlayVideo: UITapGestureRecognizer!
    
    @IBOutlet weak var viewCountEdgesPost: UIView!
    @IBOutlet weak var textCountEdgesPost: UILabel!
    
    @IBOutlet weak var viewLikes: UIView!
    @IBOutlet weak var imageLikes: UIImageView!
    @IBOutlet weak var labelCountLikes: UILabel!
    
    @IBOutlet weak var viewViews: UIView!
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var labelCountViews: UILabel!
    
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var imageComments: UIImageView!
    @IBOutlet weak var labelCountComments: UILabel!
    
    @IBOutlet weak var labelTextPost: UILabel!
    /// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    // MARK: - Объявление используемых переменных   //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    var statusLoadData : Bool = false
    var statusViewPost : Bool = false
    var currentSocialNetwork = Int()
    var currentEdgesPost : Int = 1
    var showedListMenu = Bool()
    
    var AppModuleData = AppModuleBigData()
    var URLAddress = String()
    
    let date = Date()
    let formatDate = DateFormatter()
    let formatTime = DateFormatter()
// MARK: - Жизненного цикла окна //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Первая загрузка окна
    override func viewDidLoad() {
        super.viewDidLoad()
        AppModuleData = AppModuleBigData.shared
        
        formatDate.dateFormat = "dd.MM.yyyy"
        formatTime.dateFormat = "HH:mm:ss"
        
        constraintWidthForButtonMenuList.constant = viewButtonMenu.frame.width / 4
        constraintWidthForButtonHistory.constant = viewButtonMenu.frame.width / 4
        changeColor()
    }
    // Каждое последующие открытие окна
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        AppModuleData.loadHistory()
        changeColor()
    }
    // Изменение темы устройтсва (Светлая/Темная)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        changeColor()
        collectionViewMenu.reloadData()
    }
    // Отклик при изменении системной темы устройства
    func changeColor() {
        if traitCollection.userInterfaceStyle == .dark {
            bottomSeparatorTitleView.isHidden = true
        } else {
            bottomSeparatorTitleView.isHidden = false
        }
        
        viewLikes.removeShadowSublayers()
        viewLikes.addShadow()
        
        viewViews.removeShadowSublayers()
        viewViews.addShadow()
        
        viewComments.removeShadowSublayers()
        viewComments.addShadow()
    }
    // Анимирования экрана
    func animation(count : Double) {
        UIView.animate(withDuration: count, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
// MARK: - Вывод сообщений //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Вывод окна с сообщением для пользователя
    func ShowAlert(Title : String, Message : String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Хорошо", style: .default) { (alert) in

        }
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Вывод окна с сообщением для перехода к социальной сети.
    func actionShowAlertForOpenApp(url : String) {
        let alert = UIAlertController(title: "Ошибка", message: "Не верный URL-адрес.\nХотите перейти на сайт?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            UIApplication.shared.open(URL(string: url)!)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel) { (alert) in }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Вывод сообщений о успешной или не успешной загрузке данных на устройство
    func showAlertDownload(status : Bool) {
        viewStatusLoad.isHidden = false
        
        if (status) {
            viewStatusLoad.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            labedStatusLoad.text = "Загрузка завершена"
        } else {
            viewStatusLoad.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labedStatusLoad.text = "Ошибка загрузки"
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
    // Вывод сообщений о ошибке, если запись не удалось скопировать
    func errorSearch() {
        ShowAlert(Title: "Ошибка \(AppModuleData.currentPost.titlePost!)", Message: AppModuleData.currentPost.textPost!)
        changeStatusLoadData(with: !statusLoadData)
    }
    // Вывода окна с выбором качества видеоролика
    private func showAlertDownloadVideo() {
        let alert = UIAlertController(title: nil, message: "Выберите доступное качество видео", preferredStyle: .actionSheet)
        if ((self.AppModuleData.currentPost.urlForVideo1080p ?? "").length > 10) {
            let action1080p = UIAlertAction(title: "1080p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentPost.urlForVideo1080p!)
                self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                self.changeStatusLoadData(with: false)
            }
            
            alert.addAction(action1080p)
        }
        if ((self.AppModuleData.currentPost.urlForVideo720p ?? "").length > 10) {
            let action720p = UIAlertAction(title: "720p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentPost.urlForVideo720p!)
                self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                self.changeStatusLoadData(with: false)
            }
            
            alert.addAction(action720p)
        }
        if ((self.AppModuleData.currentPost.urlForVideo480p ?? "").length > 10) {
            let action480p = UIAlertAction(title: "480p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentPost.urlForVideo480p!)
                self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                self.changeStatusLoadData(with: false)
            }
            
            alert.addAction(action480p)
        }
        if ((self.AppModuleData.currentPost.urlForVideo360p ?? "").length > 10) {
            let action360p = UIAlertAction(title: "360p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentPost.urlForVideo360p!)
                self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                self.changeStatusLoadData(with: false)
            }
            
            alert.addAction(action360p)
        }
        if ((self.AppModuleData.currentPost.urlForVideo240p ?? "").length > 10) {
            let action240p = UIAlertAction(title: "240p", style: .default) { (alert) in
                self.downloadVideo(url: self.AppModuleData.currentPost.urlForVideo240p!)
                self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                self.changeStatusLoadData(with: false)
            }
            
            alert.addAction(action240p)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (alert) in }
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    // Проверка валидности ссылки
    func isValidLink(link : String) -> Bool {
        if (link.range(of: "https://+[A-Z0-9a-z._%+-]{2,128}", options: .regularExpression) != nil)
        {
            if  (currentSocialNetwork == 0 && (URLAddress.lowercased().range(of: "instagram") != nil)) ||
                (currentSocialNetwork == 1 && (URLAddress.lowercased().range(of: "youtu")     != nil)) ||
                (currentSocialNetwork == 2 && (URLAddress.lowercased().range(of: "vk")        != nil)) ||
                (currentSocialNetwork == 3 && (URLAddress.lowercased().range(of: "facebook")  != nil)) {
                return true
            } else {
                return false
            }
        }   else    {
            return false
        }
    }
// MARK: - Взаимодействие пользователя с выбором социальной сети //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Жест "Назад"
    @IBAction func actionSwipeToRight(_ sender: Any) {
        if (showedListMenu) {
            return
        }

        if (currentSocialNetwork > 0) {
            currentSocialNetwork -= 1
        } else {
            currentSocialNetwork = AppModuleData.getCountSupportsNetworks() - 1
        }
        
        changeSocialNetwork()
    }
    // Жест "Вперед"
    @IBAction func actionSwipeToLeft(_ sender: Any) {
        if (showedListMenu) {
            actionOpenMenuList(self)
            return
        }
        
        if (currentSocialNetwork < AppModuleData.getCountSupportsNetworks() - 1) {
            currentSocialNetwork += 1
        } else {
            currentSocialNetwork = 0
        }
        
        changeSocialNetwork()
    }
    // Выбор социaльной сети через меню быстрого доступа
    func changeSocialNetwork() {
        if (showedListMenu) {
            actionOpenMenuList(self)
        }
        
        imageSocialNetworkLogo.setBackgroundImage(UIImage(named: AppModuleData.getWhiteLogoSocailNetworks(with: currentSocialNetwork)), for: .normal)
        labelSocialNetworkName.setTitle(AppModuleData.getNameSocialNetwork(with: currentSocialNetwork), for: .normal)
        
        UIView.animate(withDuration: 0.75) {
            self.viewColorPaletteSocialNetwork.backgroundColor = self.AppModuleData.getColorSocialNetwork(with: self.currentSocialNetwork)
        }
    }
// MARK: - Установление параметров для меню быстрого доступа к соц. сетям //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Установление ширины ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewMenu.frame.width, height: 56)
    }
    // Установление количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppModuleData.getCountSupportsNetworks()
    }
    // Отображение ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewMenuCell", for: indexPath as IndexPath) as! CollectionViewMenuCell
        
        cell.clearCell()
        if (showedListMenu){
            cell.configuration(indexSocialNetwork: indexPath.row, currentIndexSocialNetwork: currentSocialNetwork)
        }
        
        return cell
    }
    // Отклик нажатия по ячейкам
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSocialNetwork = indexPath.row
        changeSocialNetwork()
    }
// MARK: - Нижняя панель меню //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Кнопка открытия панели быстрого доступа к социальным сетям
    @IBAction func actionOpenMenuList(_ sender: Any) {
        showedListMenu = !showedListMenu
        var cornerRadius = CGFloat()
        var constraintView = CGFloat()
        var leadingView = CGFloat()
        
        if (showedListMenu) {
            buttonMenuList.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            
            cornerRadius = 20.0
            constraintView = 100.0
            leadingView = view.frame.width / 2 + view.frame.width / 5
            
            collectionViewMenu.reloadData()
        } else {
            buttonMenuList.setImage(UIImage(systemName: "list.dash"), for: .normal)
            
            cornerRadius = 0.0
            constraintView = 0.0
            leadingView = 0.0
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.collectionViewMenu.reloadData()
            }
        }
        
        viewInstagramBackground.layer.cornerRadius = cornerRadius
        viewColorPaletteSocialNetwork.layer.cornerRadius = cornerRadius
        
        constraintTopForViewInstagramBackground.constant = constraintView
        constraintLeadingForViewInstagramBackground.constant = leadingView
        constraintTrailingForViewInstagramBackground.constant = leadingView
        constraintBottomForViewInstagramBackground.constant = constraintView
        
        constraintTopForViewColorPaletteSocialNetwork.constant = constraintView
        constraintLeadingForViewColorPaletteSocialNetwork.constant = leadingView
        constraintTrailingForViewColorPaletteSocialNetwork.constant = leadingView
        constraintBottomForViewColorPaletteSocialNetwork.constant = constraintView
        
        constraintTopForViewMainContent.constant = constraintView
        constraintLeadingForViewMainContent.constant = leadingView
        constraintTrailingForViewMainContent.constant = leadingView
        constraintBottomForViewMainContent.constant = constraintView
        
        animation(count: 0.75)
    }
    // Кнопка поиска
    @IBAction func actionSearchData(_ sender: Any) {
        if (showedListMenu) {
            showedListMenu = !showedListMenu
            buttonMenuList.setImage(UIImage(systemName: "square.grid.3x2.fill"), for: .normal)
            constraintBottomForViewMainContent.constant = 0
            constraintBottomForViewInstagramBackground.constant = 0
            constraintBottomForViewColorPaletteSocialNetwork.constant = 0
            animation(count: 0.75)
        }
        
        if (statusViewPost) {
            statusViewPost = false
            changeStatusLoadData(with: false)
            return
        }
        
        URLAddress = UIPasteboard.general.string ?? ""
        if (isValidLink(link: URLAddress)) {
            changeStatusLoadData(with: !statusLoadData)
            if (statusLoadData) {
                DispatchQueue.global(qos: .utility).async {
                    // print("https://getfile.space/file.php?link=\(self.URLAddress)&mobile=true")
                    if let url = URL(string: "https://getfile.space/file.php?link=\(self.URLAddress)&mobile=true") {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let downloadData = data {
                                do {
                                    let parsedJSON = try JSONDecoder().decode(AppModuleBigData.infoForHistory.self, from: downloadData)
                                    self.AppModuleData.currentPost = parsedJSON
                                    // print(self.AppModuleData.currentPost)
                                    DispatchQueue.main.async {
                                        if (self.statusLoadData) {
                                            if (self.AppModuleData.currentPost.titlePost == " 400 " ||
                                                self.AppModuleData.currentPost.titlePost == " 403 " ||
                                                self.AppModuleData.currentPost.titlePost == " 404 " ||
                                                self.AppModuleData.currentPost.titlePost == " 408 " ||
                                                self.AppModuleData.currentPost.titlePost == " 499 " ||
                                                self.AppModuleData.currentPost.titlePost == " 503 ") {
                                                self.statusViewPost = false
                                                self.errorSearch()
                                            } else {
                                                self.statusViewPost = true
                                                self.completeSearch()
                                            }
                                        }
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }.resume()
                    }
                }
            }
        } else {
            actionShowAlertForOpenApp(url: AppModuleData.getURLSocialNetwork(with: currentSocialNetwork))
        }
    }
    // Кнопка перехода к окну "История"
    @IBAction func actionOpenHistoryController(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let map = mainStoryboard.instantiateViewController(withIdentifier: "HistoryController") as? HistoryController {
            self.present(map, animated: true, completion: nil)
        }
    }
    // Изменения главного окна при парсинге данных
    func changeStatusLoadData(with status : Bool) {
        statusLoadData = status
        
        gestureSwipeToLeft.isEnabled = !statusLoadData
        gestureSwipeToRight.isEnabled = !statusLoadData
        
        buttonHistory.isUserInteractionEnabled = !statusLoadData
        buttonHistory.isHighlighted = statusLoadData
        buttonMenuList.isUserInteractionEnabled = !statusLoadData
        buttonMenuList.isHighlighted = statusLoadData
        
        labelSocialNetworkName.isHidden = statusLoadData
        indicatorLoadData.isHidden = !statusLoadData
        
        if (statusLoadData) {
            imageSocialNetworkLogo.setBackgroundImage(UIImage(named: AppModuleData.getColorLogoSocialNetworks(with: currentSocialNetwork)), for: .normal)
            viewColorPaletteSocialNetwork.backgroundColor = UIColor.init(named: "customMainBackground")
            
            buttonSearch.setImage(UIImage(systemName: "xmark"), for: .normal)
            labelTitleView.text = "Загрузка..."
            constraintheightForViewTitlePage.constant = 88
        } else {
            AppModuleData.removeCurrentPost()
            
            imageSocialNetworkLogo.isHidden = false
            imageSocialNetworkLogo.setBackgroundImage(UIImage(named: AppModuleData.getWhiteLogoSocailNetworks(with: currentSocialNetwork)), for: .normal)
            constraintWidthForButtonDownload.constant = 0
            
            viewColorPaletteSocialNetwork.backgroundColor = AppModuleData.getColorSocialNetwork(with: currentSocialNetwork)
            
            labelTextPost.text = ""
            image1ContentPost.image = nil
            
            viewSearchContent.isHidden = true
            imageIconPlayVideo.isHidden = true
            viewCountEdgesPost.isHidden = true
            
            constraintCenterForImage1.constant = 0
            constraintCenterForImage2.constant = view.frame.width
            constraintCenterForImage3.constant = view.frame.width
            
            buttonSearch.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            constraintheightForViewTitlePage.constant = 0
            constraintWidthButtonOpenPost.constant = 0
        }
        
        animation(count: 0.75)
    }
// MARK: - Взаимодействие пользователя с элементами усправления на странице отображения записи //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Кнопка перехода к учетной записи
    @IBAction func actionButtonNicknameUser(_ sender: Any) {
        var urlAddressUser = String()
        switch currentSocialNetwork {
            case 0 :
                urlAddressUser = "https://www.instagram.com/\(AppModuleData.currentPost.nicknameUser!)"
                break
            case 1 :
                urlAddressUser = "https://www.youtube.com/channel/\(AppModuleData.currentPost.idUser!)"
                break
            case 2 :
                urlAddressUser = "https://www.vk.com/\(AppModuleData.currentPost.idUser!)"
                break
            case 3 :
                urlAddressUser = "https://www.facebook.com/profile.php?id=\(AppModuleData.currentPost.idUser!)"
                break
            default :
                break
        }
        
        let alert = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите перейти к \(AppModuleData.currentPost.nicknameUser!)?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            UIApplication.shared.open(URL(string: urlAddressUser)!)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel) { (alert) in }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Кнопка перехода по скопированной ссылке
    @IBAction func actionButtonOpenPost(_ sender: Any) {
        let alert = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите перейти к записи?", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Да", style: .destructive) { (alert) in
            UIApplication.shared.open(URL(string: self.AppModuleData.currentPost.urlPost!)!)
        }
        
        let actionCancel = UIAlertAction(title: "Нет", style: .cancel) { (alert) in }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    // Отклик нажатия по элементу воиспроизведения видеоролика
    @IBAction func actionGestureTapPlayVideo(_ sender: Any) {
        var urlVideo = String()
        
        if (AppModuleData.currentPost.typePost == "GraphVideo") {
            if (AppModuleData.currentPost.urlForVideo1080p != nil) {
                urlVideo = AppModuleData.currentPost.urlForVideo1080p!
            } else
            if (AppModuleData.currentPost.urlForVideo720p != nil) {
                urlVideo = AppModuleData.currentPost.urlForVideo720p!
            } else
            if (AppModuleData.currentPost.urlForVideo480p != nil) {
                urlVideo = AppModuleData.currentPost.urlForVideo480p!
            } else
            if (AppModuleData.currentPost.urlForVideo360p != nil) {
                urlVideo = AppModuleData.currentPost.urlForVideo360p!
            } else
            if (AppModuleData.currentPost.urlForVideo240p != nil) {
                urlVideo = AppModuleData.currentPost.urlForVideo240p!
            }
        } else {
            urlVideo = AppModuleData.currentPost.urlVideoEdges![currentEdgesPost - 1]
        }
        
        let player = AVPlayer(url: URL(string: urlVideo)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    // Отклик движения элементов изображений (если их n-множество, но <= 10 элементов)
    @IBAction func actionGesturePanSwipeImageEdges(_ sender: UIPanGestureRecognizer) {
        let translation = gesturePanForSwipeImageEdges.translation(in: self.view)
        let border : CGFloat = 100.0
        let animationDuration : Double = 0.75
        
        if (gesturePanForSwipeImageEdges.state == UIGestureRecognizer.State.changed) {
            if (currentEdgesPost == 1) {
                constraintCenterForImage1.constant += translation.x
                constraintCenterForImage2.constant += translation.x
            } else if (currentEdgesPost == 10) {
                constraintCenterForImage1.constant += translation.x
                constraintCenterForImage3.constant += translation.x
            } else {
                constraintCenterForImage1.constant += translation.x
                constraintCenterForImage2.constant += translation.x
                if (AppModuleData.currentPost.typeEdges!.count != 2) {
                    constraintCenterForImage3.constant += translation.x
                }
            }
        }
        
        if (gesturePanForSwipeImageEdges.state == UIGestureRecognizer.State.ended) {
            if (currentEdgesPost == 1) {
// 1 -> 2
                if (constraintCenterForImage1.constant <= -1 * border) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage2.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    constraintCenterForImage3.constant = view.frame.width
                    
                    currentEdgesPost += 1
                    setEdgesPost(with: true)
// Без изменений
                } else {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = 0
                        self.constraintCenterForImage2.constant = self.view.frame.width
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            } else if (currentEdgesPost == 2 || currentEdgesPost == 5 || currentEdgesPost == 8) {
// 2 -> 3 | 5 -> 6 | 8 -> 9
                if (constraintCenterForImage2.constant <= -1 * border && currentEdgesPost != AppModuleData.currentPost.typeEdges!.count) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage2.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage3.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    
                    if (currentEdgesPost + 1 != AppModuleData.currentPost.typeEdges!.count) {
                        constraintCenterForImage1.constant = view.frame.width
                    }
                    currentEdgesPost += 1
                    setEdgesPost(with: true)
// 2 -> 1 | 5 -> 4 | 8 -> 7
                } else if (constraintCenterForImage2.constant >= border) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage2.constant = self.view.frame.width
                        self.constraintCenterForImage1.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    
                    if (currentEdgesPost != 2) {
                        constraintCenterForImage3.constant = -1 * view.frame.width
                    }
                    
                    currentEdgesPost -= 1
                    setEdgesPost(with: false)
// Без изменений
                } else {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage2.constant = 0
                        if (self.currentEdgesPost != self.AppModuleData.currentPost.typeEdges!.count) {
                            self.constraintCenterForImage3.constant = self.view.frame.width
                        }
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            } else if (currentEdgesPost == 3 || currentEdgesPost == 6 || currentEdgesPost == 9) {
// 3 -> 4 | 6 -> 7 | 9 -> 10
                if (constraintCenterForImage3.constant <= -1 * border && currentEdgesPost != AppModuleData.currentPost.typeEdges!.count) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage3.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage1.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    if (currentEdgesPost + 1 != AppModuleData.currentPost.typeEdges!.count) {
                        constraintCenterForImage2.constant = view.frame.width
                    }
                    currentEdgesPost += 1
                    setEdgesPost(with: true)
// 3 -> 2 | 6 -> 5 | 9 -> 8
                } else if (constraintCenterForImage3.constant >= border) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage3.constant = self.view.frame.width
                        self.constraintCenterForImage2.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    constraintCenterForImage1.constant = -1 * view.frame.width
                    
                    currentEdgesPost -= 1
                    setEdgesPost(with: false)
// Без изменений
                } else {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage2.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage3.constant = 0
                        if (self.currentEdgesPost != self.AppModuleData.currentPost.typeEdges!.count) {
                            self.constraintCenterForImage1.constant = self.view.frame.width
                        }
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            } else if (currentEdgesPost == 4 || currentEdgesPost == 7) {
// 4 -> 5 | 7 -> 8
                if (constraintCenterForImage1.constant <= -1 * border && currentEdgesPost != AppModuleData.currentPost.typeEdges!.count) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage2.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    if (currentEdgesPost + 1 != AppModuleData.currentPost.typeEdges!.count) {
                        constraintCenterForImage3.constant = view.frame.width
                    }
                    currentEdgesPost += 1
                    setEdgesPost(with: true)
// 4 -> 3 | 7 -> 6
                } else if (constraintCenterForImage1.constant >= border) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = self.view.frame.width
                        self.constraintCenterForImage3.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    constraintCenterForImage2.constant = -1 * view.frame.width
                    
                    currentEdgesPost -= 1
                    setEdgesPost(with: false)
// Без изменений
                } else {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage3.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage1.constant = 0
                        if (self.currentEdgesPost != self.AppModuleData.currentPost.typeEdges!.count) {
                            self.constraintCenterForImage2.constant = self.view.frame.width
                        }
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            } else if (currentEdgesPost == 10) {
// 10 -> 9
                if (constraintCenterForImage1.constant >= border) {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage1.constant = self.view.frame.width
                        self.constraintCenterForImage3.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    constraintCenterForImage2.constant = -1 * view.frame.width
                    
                    currentEdgesPost -= 1
                    setEdgesPost(with: false)
// Без изменений
                } else {
                    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.constraintCenterForImage3.constant = -1 * self.view.frame.width
                        self.constraintCenterForImage1.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
        }
        
        gesturePanForSwipeImageEdges.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    // Изменения численного значения текущего изображения (в счетчике). Загрузка новых изображений
    func setEdgesPost(with direction : Bool) {
        // true - Следующий элемент
        // false - Предыдущий элемент
        textCountEdgesPost.text = "\(currentEdgesPost) / \(AppModuleData.currentPost.typeEdges!.count)"
        
        if (AppModuleData.currentPost.typeEdges![currentEdgesPost - 1] == "GraphVideo") {
            imageIconPlayVideo.isHidden = false
            gestureTapForPlayVideo.isEnabled = true
        } else {
            imageIconPlayVideo.isHidden = true
            gestureTapForPlayVideo.isEnabled = false
        }
        
        if (currentEdgesPost == 1) {
            DispatchQueue.global(qos: .utility).async {
                let image1Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost - 1])!)
                DispatchQueue.main.async {
                    self.image1ContentPost.image = UIImage(data: image1Post!)
                }
            }
            
            DispatchQueue.global(qos: .utility).async {
                let image2Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost])!)
                DispatchQueue.main.async {
                    self.image2ContentPost.image = UIImage(data: image2Post!)
                }
            }
        } else if (currentEdgesPost == 2 || currentEdgesPost == 5 || currentEdgesPost == 8) {
            if (direction) {
                if (currentEdgesPost != AppModuleData.currentPost.typeEdges?.count) {
                    DispatchQueue.global(qos: .utility).async {
                        let image3Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost])!)
                        DispatchQueue.main.async {
                            self.image3ContentPost.image = UIImage(data: image3Post!)
                        }
                    }
                }
            } else {
                DispatchQueue.global(qos: .utility).async {
                    let image1Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost - 2])!)
                    DispatchQueue.main.async {
                        self.image1ContentPost.image = UIImage(data: image1Post!)
                    }
                }
            }
        } else if (currentEdgesPost == 3 || currentEdgesPost == 6 || currentEdgesPost == 9) {
            if (direction) {
                if (currentEdgesPost != AppModuleData.currentPost.typeEdges?.count) {
                    DispatchQueue.global(qos: .utility).async {
                        let image1Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost])!)
                        DispatchQueue.main.async {
                            self.image1ContentPost.image = UIImage(data: image1Post!)
                        }
                    }
                }
            } else {
                DispatchQueue.global(qos: .utility).async {
                    let image2Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost - 2])!)
                    DispatchQueue.main.async {
                        self.image2ContentPost.image = UIImage(data: image2Post!)
                    }
                }
            }
        } else if (currentEdgesPost == 4 || currentEdgesPost == 7) {
            if (direction) {
                if (currentEdgesPost != AppModuleData.currentPost.typeEdges?.count) {
                    DispatchQueue.global(qos: .utility).async {
                        let image2Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost])!)
                        DispatchQueue.main.async {
                            self.image2ContentPost.image = UIImage(data: image2Post!)
                        }
                    }
                }
            } else {
                DispatchQueue.global(qos: .utility).async {
                    let image3Post = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![self.currentEdgesPost - 2])!)
                    DispatchQueue.main.async {
                        self.image3ContentPost.image = UIImage(data: image3Post!)
                    }
                }
            }
        }
    }
// MARK: - Установление численных значений из записи //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Формирования строкового значения числа подписчиков
    func translateNumbers(with count : String) -> String {
        var newCount : String = count
        while newCount.contains(find: " ") {
            newCount = newCount.replace(target: " ", withString: "")
        }
        
        var strCount = String()
        var indexInsert = Int()
        
        if (newCount.length >= 4 && newCount.length <= 6) {
            strCount = " тыс"
        } else if (newCount.length >= 7 && newCount.length <= 9) {
            strCount = " млн"
        } else if (newCount.length >= 10 && newCount.length <= 12) {
            strCount = " млрд"
        } else if (newCount.length >= 13 && newCount.length <= 15) {
            strCount = " трлн"
        }
        
        if (newCount.length == 4 || newCount.length == 7 || newCount.length == 10 || newCount.length == 13) {
            indexInsert = 1
        } else if (newCount.length == 5 || newCount.length == 8 || newCount.length == 11 || newCount.length == 14) {
            indexInsert = 2
        } else if (newCount.length == 6 || newCount.length == 9 || newCount.length == 12 || newCount.length == 15) {
            indexInsert = 3
        } else {
            return newCount
        }
        
        newCount = newCount.substring(to: indexInsert)
        newCount.insert(",", at: newCount.index(newCount.startIndex, offsetBy: indexInsert))
        newCount += strCount
        return newCount
    }
    // Установление значений числа подписчиков
    func setCountSubscrite(with count : String) {
        if (count != "") {
            if (currentSocialNetwork == 1) {
                labelCountSubscribesUser.text = "\(count) подписчиков"
            } else {
                labelCountSubscribesUser.text = "\(translateNumbers(with: count)) подписчиков"
            }
            labelCountSubscribesUser.isHidden = false
        } else {
            labelCountSubscribesUser.isHidden = true
        }
    }
    // Установление значения числа положительных оценок (лайков)
    func setCountLikes(with count : String) {
        if (count != "") {
            labelCountLikes.text = translateNumbers(with: count)
            viewLikes.isHidden = false
        } else {
            viewLikes.isHidden = true
        }
    }
    // Установление значения числа отрицательных оценок (дизлайков)
    func setCountDislikes(with count : String) {
        if (count != "") {
            imageComments.image = UIImage(systemName: "heart.slash.fill")
            labelCountComments.text = translateNumbers(with: count)
            viewComments.isHidden = false
        } else {
            viewComments.isHidden = true
        }
    }
    // Установление значения числа просмотров записи или видео
    func setCountViews(with count : String) {
        if (count != "") {
            labelCountViews.text = translateNumbers(with: count)
            viewViews.isHidden = false
        } else {
            viewViews.isHidden = true
        }
    }
    // Установление значения числа оставленных комментариев
    func setCountComments(with count : String) {
        if (count != "") {
            imageComments.image = UIImage(systemName: "message.fill")
            labelCountComments.text = translateNumbers(with: count)
            viewComments.isHidden = false
        } else {
            viewComments.isHidden = true
        }
    }
    // Установление значения числа людей, которые поделились записью у себя на странице
    func setCountShare(with count : String) {
        if (count != "") {
            imageComments.image = UIImage(systemName: "arrowshape.turn.up.right.fill")
            labelCountComments.text = translateNumbers(with: count)
            viewComments.isHidden = false
        } else {
            viewComments.isHidden = true
        }
    }
// MARK: - Формирование страницы отображения записи //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Копирование значений записи в элементы управления и чтения страницы
    func completeSearch() {
        indicatorLoadData.isHidden = true
        viewSearchContent.isHidden = false
        imageSocialNetworkLogo.isHidden = true
        labelTitleView.text = AppModuleData.getNameSocialNetwork(with: currentSocialNetwork)
        constraintWidthForButtonDownload.constant = viewButtonMenu.frame.width / 4
        
        AppModuleData.currentPost.urlPost = URLAddress
        
        let avatar = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlAvatar!)!)
        imageAvatarUser.image = UIImage(data: avatar!)
        
        labelNicknameUser.text = AppModuleData.currentPost.nicknameUser!
        setCountSubscrite(with: AppModuleData.currentPost.countSubscrite ?? "")
        
        if (currentSocialNetwork == 1) {
            setCountLikes(with: "\(AppModuleData.currentPost.countLikes!)")
            setCountViews(with: "\(AppModuleData.currentPost.countView!)")
            setCountDislikes(with: "\(AppModuleData.currentPost.countDislikes!)")
        } else {
            if (currentSocialNetwork == 2) {
                setCountLikes(with: "\(AppModuleData.currentPost.countLikes!)")
                setCountViews(with: "\(AppModuleData.currentPost.countView!)")
                setCountShare(with: "\(AppModuleData.currentPost.countComment!)")
            } else {
                setCountLikes(with: "\(AppModuleData.currentPost.countLikes!)")
                setCountViews(with: "")
                setCountComments(with: "\(AppModuleData.currentPost.countComment!)")
            }
        }
        labelTextPost.text = AppModuleData.currentPost.textPost ?? AppModuleData.currentPost.titlePost ?? ""
        
        switch AppModuleData.currentPost.typePost {
            case "GraphImage":
                let imagePost = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImage!)!)
                image1ContentPost.image = UIImage(data: imagePost!)
                
                gestureTapForPlayVideo.isEnabled = false
                gesturePanForSwipeImageEdges.isEnabled = false
                break
            case "GraphSidecar":
                currentEdgesPost = 1
                setEdgesPost(with: true)
                
                viewCountEdgesPost.isHidden = false
                gestureTapForPlayVideo.isEnabled = false
                gesturePanForSwipeImageEdges.isEnabled = true
                break
            case "GraphVideo":
                setCountViews(with: "\(AppModuleData.currentPost.countView!)")
                let imagePost = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImage!)!)
                image1ContentPost.image = UIImage(data: imagePost!)
                
                imageIconPlayVideo.isHidden = false
                gestureTapForPlayVideo.isEnabled = true
                gesturePanForSwipeImageEdges.isEnabled = false
                break
            default:
                break
        }
        
        constraintWidthButtonOpenPost.constant = 32
        animation(count: 0.75)
    }
// MARK: - Скачивание изображений и/или видеороликов //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    // Кнопка для скачивания
    @IBAction func actionDownloadData(_ sender: Any) {
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
            AppModuleData.currentPost.date = formatDate.string(from: date)
            AppModuleData.currentPost.time = formatTime.string(from: date)
            
            switch AppModuleData.currentPost.typePost {
                case "GraphImage":
                    UIImageWriteToSavedPhotosAlbum(image1ContentPost.image!, self, nil, nil)
                    showAlertDownload(status: true)
                    AppModuleData.saveHistory(with: AppModuleData.getNameSocialNetwork(with: currentSocialNetwork))
                    changeStatusLoadData(with: false)
                    break
                case "GraphVideo":
                    showAlertDownloadVideo()
                    break
                case "GraphSidecar":
                    var titleFirstButtonAlert = String()
                    let alert = UIAlertController(title: nil, message: "Выберите тип скачивания:", preferredStyle: .actionSheet)
                    
                    if (AppModuleData.currentPost.typeEdges![currentEdgesPost - 1] == "GraphVideo") {
                        titleFirstButtonAlert = "Текущее видео"
                    } else {
                        titleFirstButtonAlert = "Текущее изображение"
                    }
                    
                    let actionSelected = UIAlertAction(title: titleFirstButtonAlert, style: .default) { (alert) in
                        if (self.AppModuleData.currentPost.typeEdges![self.currentEdgesPost - 1] == "GraphVideo") {
                            self.downloadVideo(url: self.AppModuleData.currentPost.urlVideoEdges![self.currentEdgesPost - 1])
                        } else {
                            if (self.currentEdgesPost == 1 || self.currentEdgesPost == 4 || self.currentEdgesPost == 7 || self.currentEdgesPost == 10) {
                                UIImageWriteToSavedPhotosAlbum(self.image1ContentPost.image!, self, nil, nil)
                            } else if (self.currentEdgesPost == 2 || self.currentEdgesPost == 5 || self.currentEdgesPost == 8) {
                                UIImageWriteToSavedPhotosAlbum(self.image2ContentPost.image!, self, nil, nil)
                            } else if (self.currentEdgesPost == 3 || self.currentEdgesPost == 6 || self.currentEdgesPost == 9) {
                                UIImageWriteToSavedPhotosAlbum(self.image3ContentPost.image!, self, nil, nil)
                            }
                        }
                        self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                        self.showAlertDownload(status: true)
                        self.changeStatusLoadData(with: false)
                    }
                    alert.addAction(actionSelected)
                    
                    let actionImage = UIAlertAction(title: "Только изображения", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentPost.typeEdges!.count - 1 {
                            if (self.AppModuleData.currentPost.typeEdges![i] == "GraphImage") {
                                let imageData = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![i])!)
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, self, nil, nil)
                            }
                        }
                        self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                        self.showAlertDownload(status: true)
                        self.changeStatusLoadData(with: false)
                    }
                    alert.addAction(actionImage)
                    
                    let actionVideo = UIAlertAction(title: "Только видеоролики", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentPost.typeEdges!.count - 1 {
                            if (self.AppModuleData.currentPost.typeEdges![i] == "GraphVideo") {
                                self.downloadVideo(url: self.AppModuleData.currentPost.urlVideoEdges![i])
                            }
                        }
                        self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                        self.showAlertDownload(status: true)
                        self.changeStatusLoadData(with: false)
                    }
                    alert.addAction(actionVideo)
                    
                    let actionAll = UIAlertAction(title: "Всё", style: .default) { (alert) in
                        for i in 0...self.AppModuleData.currentPost.typeEdges!.count - 1 {
                            if (self.AppModuleData.currentPost.typeEdges![i] == "GraphImage") {
                                let imageData = try? Data(contentsOf: URL(string: self.AppModuleData.currentPost.urlImageEdges![i])!)
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, self, nil, nil)
                            } else {
                                self.downloadVideo(url: self.AppModuleData.currentPost.urlVideoEdges![i])
                            }
                        }
                        self.AppModuleData.saveHistory(with: self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))
                        self.showAlertDownload(status: true)
                        self.changeStatusLoadData(with: false)
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
    // Скачивания видеоролика по ссылке
    private func downloadVideo(url : String) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url), let urlData = NSData(contentsOf: url) {
                let filePath = self.documentsPath + "/\(self.AppModuleData.getNameSocialNetwork(with: self.currentSocialNetwork))-\(self.formatDate.string(from: self.date)):\(self.formatTime.string(from: self.date)).mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    
                    if (self.AppModuleData.currentPost.typePost == "GraphVideo") {
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
}
// MARK: - Установление теней эффекта 3D для визуальных элементов //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
extension UIView {
    func addShadow() {
        let position : CGFloat = 3.0
        // Верхняя тень
        let layer1 = CALayer()
        layer1.name = "topShadow"
        layer1.frame = self.bounds
        layer1.shadowColor = UIColor.init(named: "customTopShadow")?.cgColor
        layer1.shadowRadius = position
        layer1.shadowOpacity = 1
        layer1.shadowOffset = CGSize(width: -1 * position, height: -1 * position)
        layer1.needsDisplayOnBoundsChange = true
        layer1.cornerRadius = 16.0
        layer1.backgroundColor = UIColor.init(named: "customMainBackground")?.cgColor
        // Нижняя тень
        let layer2 = CALayer()
        layer2.name = "bottomShadow"
        layer2.frame = self.bounds
        layer2.shadowColor = UIColor.init(named: "customBottomShadow")?.cgColor
        layer2.shadowRadius = position
        layer2.shadowOpacity = 1
        layer2.shadowOffset = CGSize(width: position, height: position)
        layer2.needsDisplayOnBoundsChange = true
        layer2.cornerRadius = 16.0
        layer2.backgroundColor = UIColor.init(named: "customMainBackground")?.cgColor
        
        self.layer.backgroundColor = UIColor.init(named: "customMainBackground")?.cgColor
        self.layer.insertSublayer(layer1, at: 0)
        self.layer.insertSublayer(layer2, at: 0)
    }
    // Удаление теней
    func removeShadowSublayers(){
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers{
                if (sublayer.name == "topShadow" || sublayer.name == "bottomShadow") {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
    // Округление краев
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
// MARK: - Взаимодействия с строками //-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
extension String {
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards), leftRange.upperBound <= rightRange.lowerBound
            else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }
    
    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    func lastIndexOfCharacter(_ c: Character) -> Int? {
        return range(of: String(c), options: .backwards)?.lowerBound.utf16Offset(in: self)
    }
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
