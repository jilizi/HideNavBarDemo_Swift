//
//  UINavigationBar+WCL.swift
//  WCLHideNavBar
//
//  Created by 王崇磊 on 16/7/28.
//  Copyright © 2016年 王崇磊. All rights reserved.
//

import UIKit

private var wclBackView = "wclBackView"

extension UINavigationBar {
    
    /**
     给UINavigationBar添加背景色，用runtime插入一个backView
     
     - parameter color: backView的背景颜色
     
     - returns: 返回UINavigationBar本身
     */
    func setWclBackGroundColor(_ color:UIColor) -> UINavigationBar {
        let wclBackGroundColorView = objc_getAssociatedObject(self, &wclBackView) as? UIView
        if wclBackGroundColorView == nil {
            setBackgroundImage(UIImage.init(), for: .default)
            shadowImage = UIImage.init()
            let backView = UIView.init(frame: CGRect(x: 0, y: -20, width: bounds.width, height: bounds.height+20))
            backView.backgroundColor = color
            backView.isUserInteractionEnabled = false
            backView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            insertSubview(backView, at: 0)
            objc_setAssociatedObject(self, &wclBackView, backView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else {
            wclBackGroundColorView!.backgroundColor = color
        }
        return self
    }
    
    /**
     设置backView的透明度
     
     - parameter alpha: backView的透明度
     
     - returns: 返回UINavigationBar本身
     */
    func setWclBackViewAlpha(_ alpha:CGFloat) -> UINavigationBar {
        let wclBackGroundColorView = objc_getAssociatedObject(self, &wclBackView) as? UIView
        wclBackGroundColorView?.alpha = alpha
        return self
    }
    
    /**
     向上隐藏NavigationBar
     
     - parameter progress: 隐藏的进度，默认是0，范围0~1
     
     - returns: 返回UINavigationBar本身
     */
    func setWclNavBarHide(_ progress:CGFloat) -> UINavigationBar {
        print(progress)
        if progress > 0 {
            transform = CGAffineTransform.identity.translatedBy(x: 0, y: -bounds.height*progress)
        }else {
            transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
        }
        if let leftViews = value(forKey: "_leftViews") as? [UIView] {
            for leftView in leftViews {
                leftView.alpha = 1 - progress
            }
        }
        if let rightViews = value(forKey: "_rightViews") as? [UIView] {
            for rightView in rightViews {
                rightView.alpha = 1 - progress
            }
        }
        if let titleView = value(forKey: "_titleView") as? UIView {
            titleView.alpha = 1 - progress
        }
        return self
    }
    
    /**
     向上隐藏NavigationBar和StateView
     
     - parameter progress: 隐藏的进度，默认是0，范围0~1
     
     - returns: 返回UINavigationBar本身
     */
    func setWclNavBarAndStateHide(_ progress:CGFloat) -> UINavigationBar {
        if let stateView = UIApplication.shared.value(forKey: "statusBarWindow") as? UIView {
            if progress > 0 {
                transform = CGAffineTransform.identity.translatedBy(x: 0, y: -(bounds.height+20)*progress)
                stateView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -(bounds.height+20)*progress)
            }else {
                transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
                stateView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)

            }
        }
        return self
    }
    
}
