//
//  WBHTTPHeaders.swift
//  WBNetSupportDemo
//
//  Created by bi we on 2018/11/27.
//  Copyright © 2018 bi we. All rights reserved.
//

import UIKit
import WebKit

public class WBHTTPHeaders: NSObject {
    public static let shared:WBHTTPHeaders = {
        //开启定位获取
        WBLocationManager.shared.prepareLocalManger()
        let wbHeader = WBHTTPHeaders()
        return wbHeader
    }()
    
    /// 初始化用户基础信息
    ///
    /// - Parameters:
    ///   - wuid: 用户标识
    ///   - user_event: 用户行为
    public func header(wuid:String,user_event:String) -> [String:String] {
        self.wuid = wuid
        self.​user_event = user_event
        return HTTPHeaders
        //定位信息准备
    }
    /// 获取header配置信息
    ///
    /// - Returns: 返回定制的特殊header参数字典
    private var HTTPHeaders: [String:String] {
        get{
            var headers = [String:String]()
            
            if let wuid = wuid {
                headers["WUID"] = wuid
            }
            if let UserEvent = ​user_event {
                headers["User-Event"] = UserEvent
            }
            if let Geolocation = geolocation {
                headers["Geolocation"] = Geolocation
            }
            if let clienview = clien_view {
                headers["Clien-View"] = clienview
            }
            
            if let UserAgent = User_Agent {
                headers["User-Agent"] = UserAgent
            }
            
            return headers
        }
    }
    
    //​手机号,合同号,app user id
    /*   WUID=​Webi User Identity
     这里仅做传递使用，并不作为任何判断条件，因此不存在数据篡改会导致安全性问题，同时由于所有用户相关的接口，比如登录，会明文传递用户名密码，安全等级一样， 因此所有用户信息相关接口必须使用HTTPS协议，同理所有数据收集类接口，必须都使用HTTPS接口来附加这些信息。*/
    private  var wuid:String?
    /*
     
     客户端任意定制的用户端行为。可以与接口名称一致，或者更容易理解的名称，比如：​Share To Wechat，Share to QQ
     因为Log文件以空格分隔字段，所以这里保存的时候，可能会看到：​Share+To+Wechat，Share+to+QQ
     */
    //长度不超过50个字符的英文名称
    private var ​user_event:String?
    /*
     
     ​地理位置为2个double类型的数值，分别是维度，经度，准确范围，一般地理位置API均可以获得，可以参考
     https://www.w3.org/TR/geolocation-API/#coordinates_interface
     */
    //latitude,longitude,accuracy
    private  var geolocation:String?
    {
        get {
            //定位管理
            return WBLocationManager.shared.currLocation
            
        }
    }
    /*
     客户端的操作界面，有可能存在多个用户操作界面调用同一个服务器接口的情况，所以仅通过服务器接口来判断哪个客户端界面并不合适，因此增加一个path来唯一识别一个客户端的视图页面地址。例如某个推送需要打开一个客户端界面，同时会向这个界面传递参数，那么这两个标准需要统一。需要Justin给出统一定义方式
     */
    
    /// 功能层级/界面类名?param=value
    private var clien_view:String?{
        get {
            return currentViewController
        }
    }
    private var User_Agent:String?{
        get{
            //获取app名称
            let infoDictionary = Bundle.main.infoDictionary!
            let CFBundleName = infoDictionary["CFBundleName"] as? String ?? ""
            
            let CFBundleDisplayName = infoDictionary["CFBundleDisplayName"] as? String
            let appDisplayName = CFBundleDisplayName ?? CFBundleName
            
            //获取app版本号
            let currentVersion = infoDictionary["CFBundleShortVersionString"] as! String
            
            let wb = UIWebView()
            let userAgent = wb.stringByEvaluatingJavaScript(from: "navigator.userAgent") ?? ""
            let ug = "\(appDisplayName)" + "/" + "\(currentVersion)" + "+" + userAgent
            return ug
        }
    }
    
    
    /// 获取当前栈顶控制器的名称
    private  var currentViewController:String?{
        get{
            var vc = UIApplication.shared.keyWindow?.rootViewController
            if vc is UITabBarController {
                if let tvc = vc as? UITabBarController {
                    vc = tvc.selectedViewController
                }
            }
            if vc is UINavigationController {
                if let nav = vc as? UINavigationController {
                    vc =  nav.visibleViewController
                }
            }
            if vc?.presentedViewController != nil {
                vc = vc?.presentedViewController
                
                return vc?.className
            }
            return vc?.className
        }
    }
}
extension NSObject
{
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }
    
}



