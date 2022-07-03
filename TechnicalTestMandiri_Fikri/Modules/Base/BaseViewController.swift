//
//  BaseViewController.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    internal let screenWidth = UIScreen.main.bounds.width
    internal let screenHeight = UIScreen.main.bounds.height
    private var topBackground = UIImageView()
    private var bottomBackground = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        if #available(iOS 13.0, *){
            overrideUserInterfaceStyle = .light
        }
    }
    
    //MARK:ViewFunctions
    func addSafeBackground(top: UIColor, bottom: UIColor){
        topBackground.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight*0.5)
        topBackground.backgroundColor = top
        self.view.addSubview(topBackground)
        
        bottomBackground.frame = CGRect(x: 0, y: topBackground.frame.maxY, width: screenWidth, height: screenHeight*0.5)
        bottomBackground.backgroundColor = bottom
        self.view.addSubview(bottomBackground)
    }
    
    func addSafeAreaLayoutIn(concernedView: UIView){
        if #available(iOS 11, *){
            let guide : UILayoutGuide = self.view.safeAreaLayoutGuide
            concernedView.anchor(top: guide.topAnchor, left: guide.leadingAnchor, right: guide.trailingAnchor, bottom: guide.bottomAnchor)
        }
    }
    
    func getStatusBarHeight() -> CGFloat{
        if #available(iOS 13, *){
            let statusBarHeight: CGFloat = {
                var heightToReturn: CGFloat = 0.0
                     for window in UIApplication.shared.windows {
                         if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                             heightToReturn = height
                         }
                     }
                return heightToReturn
            }()
            return statusBarHeight
        }
        else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
