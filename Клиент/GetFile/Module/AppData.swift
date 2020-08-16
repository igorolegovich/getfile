import Foundation
import UIKit

class AppModuleBigData {
    static let shared = AppModuleBigData()
    let defaults = UserDefaults.standard
/// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    public var currentPost = infoForHistory()
    public var currentHistory : [infoForHistory] = []
//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    public struct infoForHistory : Codable {
        var date            : String?
        var time            : String?
        
        var typePost        : String?
        var typeCell        : String?
        
        var urlPost         : String?
        var urlAvatar       : String?
        var urlImage        : String?
        
        var nicknameUser    : String?
        var idUser          : String?
        
        var titlePost       : String?
        var textPost        : String?
        
        var countLikes      : String?
        var countDislikes   : String?
        var countSubscrite  : String?
        var countComment    : String?
        var countView       : String?
        
        var typeEdges       : [String]?
        var urlImageEdges   : [String]?
        var urlVideoEdges   : [String]?
        
        var titleForVideo   : String?
        var idVideo         : String?
        
        var urlForVideo1080p    : String?
        var urlForVideo720p     : String?
        var urlForVideo480p     : String?
        var urlForVideo360p     : String?
        var urlForVideo240p     : String?
    }
/// ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///     ///
    var historyForInstagram : [infoForHistory] = []
    var historyForYoutube : [infoForHistory] = []
    var historyForVK : [infoForHistory] = []
    var historyForFacebook : [infoForHistory] = []
//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    private var nameSocialNetworks : [String] = ["Instagram",
                                                 "Youtube",
                                                 "ВКонтакте",
                                                 "Facebook"]
    
    private var urlSocialNetworks : [String] = ["https://www.instagram.com/",
                                                "https://www.youtube.com/",
                                                "https://www.vk.com/",
                                                "https://www.facebook.com/"]
    
    private var colorSocialNetwork : [UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0),
                                                  #colorLiteral(red: 0.768627451, green: 0.1882352941, blue: 0.168627451, alpha: 1),
                                                  #colorLiteral(red: 0.2745098039, green: 0.5019607843, blue: 0.7607843137, alpha: 1),
                                                  #colorLiteral(red: 0.1137254902, green: 0.3607843137, blue: 0.9019607843, alpha: 1)]
    
    private var whiteLogoSocialNetworks : [String] = ["WhiteInstagram",
                                                      "WhiteYoutube",
                                                      "WhiteVK",
                                                      "WhiteFacebook"]
    
    private var colorLogoSocialNetworks : [String] = ["ColorInstagram",
                                                      "ColorYoutube",
                                                      "ColorVK",
                                                      "ColorFacebook"]
    
    private var MenuLogoSocialNetworks_White : [String] = ["MenuWhiteInstagram",
                                                           "MenuWhiteYoutube",
                                                           "MenuWhiteVK",
                                                           "MenuWhiteFacebook"]
    
    private var MenuLogoSocialNetworks_Black : [String] = ["MenuBlackInstagram",
                                                           "MenuBlackYoutube",
                                                           "MenuBlackVK",
                                                           "MenuBlackFacebook"]
//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    public func getNameSocialNetwork(with index : Int) -> String {
        return nameSocialNetworks[index]
    }
    
    public func getCountSupportsNetworks() -> Int {
        return nameSocialNetworks.count
    }
    
    public func getURLSocialNetwork(with index : Int) -> String {
        return urlSocialNetworks[index]
    }
    
    public func getColorSocialNetwork(with index : Int) -> UIColor {
        return colorSocialNetwork[index]
    }
    
    public func getWhiteLogoSocailNetworks(with index : Int) -> String {
        return whiteLogoSocialNetworks[index]
    }
    
    public func getColorLogoSocialNetworks(with index : Int) -> String {
        return colorLogoSocialNetworks[index]
    }
    
    public func getMenuLogoSocialNetworks_White(with index : Int) -> String {
        return MenuLogoSocialNetworks_White[index]
    }
    
    public func getMenuLogoSocialNetworks_Black(with index : Int) -> String {
        return MenuLogoSocialNetworks_Black[index]
    }
//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    public func getHistoryInstagram() -> [infoForHistory] {
        if let data = defaults.value(forKey: "historyForInstagram") as? Data {
            return try! PropertyListDecoder().decode(Array<AppModuleBigData.infoForHistory>.self, from: data)
        } else {
            return []
        }
    }
    
    public func getHistoryYoutube() -> [infoForHistory] {
        if let data = defaults.value(forKey: "historyForYoutube") as? Data {
            return try! PropertyListDecoder().decode(Array<AppModuleBigData.infoForHistory>.self, from: data)
        } else {
            return []
        }
    }
    
    public func getHistoryVK() -> [infoForHistory] {
        if let data = defaults.value(forKey: "historyForVK") as? Data {
            return try! PropertyListDecoder().decode(Array<AppModuleBigData.infoForHistory>.self, from: data)
        } else {
            return []
        }
    }
    
    public func getHistoryFacebook() -> [infoForHistory] {
        if let data = defaults.value(forKey: "historyForFacebook") as? Data {
            return try! PropertyListDecoder().decode(Array<AppModuleBigData.infoForHistory>.self, from: data)
        } else {
            return []
        }
    }
//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    public func removeCurrentPost() {
        currentPost.urlPost = ""
    }
    
    public func saveHistory(with name : String) {
        switch name {
            case "Instagram":
                if (currentPost.urlPost != "") {
                    historyForInstagram.append(currentPost)
                }
                defaults.set(try? PropertyListEncoder().encode(historyForInstagram), forKey: "historyForInstagram")
                break
            case "Youtube":
                if (currentPost.urlPost != "") {
                    historyForYoutube.append(currentPost)
                }
                defaults.set(try? PropertyListEncoder().encode(historyForYoutube), forKey: "historyForYoutube")
                break
            case "ВКонтакте":
                if (currentPost.urlPost != "") {
                    historyForVK.append(currentPost)
                }
                defaults.set(try? PropertyListEncoder().encode(historyForVK), forKey: "historyForVK")
                break
            case "Facebook":
                if (currentPost.urlPost != "") {
                    historyForFacebook.append(currentPost)
                }
                defaults.set(try? PropertyListEncoder().encode(historyForFacebook), forKey: "historyForFacebook")
                break
            default:
                break
        }
    }
    
    public func loadHistory() {
        if let data = defaults.value(forKey: "historyForInstagram") as? Data {
            historyForInstagram = try! PropertyListDecoder().decode(Array<infoForHistory>.self, from: data)
        }
        if let data = defaults.value(forKey: "historyForYoutube") as? Data {
            historyForYoutube = try! PropertyListDecoder().decode(Array<infoForHistory>.self, from: data)
        }
        if let data = defaults.value(forKey: "historyForVK") as? Data {
            historyForVK = try! PropertyListDecoder().decode(Array<infoForHistory>.self, from: data)
        }
        if let data = defaults.value(forKey: "historyForFacebook") as? Data {
            historyForFacebook = try! PropertyListDecoder().decode(Array<infoForHistory>.self, from: data)
        }
    }
}
