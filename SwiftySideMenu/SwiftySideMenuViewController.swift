//
//  SwiftySideMenuViewController.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

open class SwiftySideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak open var dataSource:SwiftySideMenuDataSource?
    
    private let mainView = UIView()
    private let sideView = UIView()
    private let sideViewTopBanner = UIView()
    private let sideViewBottomView = UIView()
    private let dismissView = UIView()
    
    private var navigationTableView: UITableView!
    private var navigationTableViewCell: UIView!
    private let menuButtonImageView: UIImageView = UIImageView()
    
    private enum Direction {
        case Up
        case Down
        case Left
        case Right
    }
    
    private var buttonImageName: String = "menuButton"
    private let navigationBarHeight: CGFloat = 60.0
    private let menuClicableButtonHeight: CGFloat = 37.0
    private let menuClicableButtonWidth: CGFloat = 57.0
    private var sideViewWidth: CGFloat!
    private var childVC: [SwiftySideMenuChildViewControllers] = []
    
    private var selectedIndexPathRow: Int = 0
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.loadDismissView()
        self.loadSideView()
        self.loadMainView()
        
        self.view.bringSubview(toFront: self.sideView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        self.childVC = self.dataSource!.menuNavigationTabs(self.navigationTableView)
        let controller = storyboard!.instantiateViewController(withIdentifier: (self.childVC.first?.viewControllerIdentifier!)!)
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: mainView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            ])
        controller.didMove(toParentViewController: self)
        
        self.changeTableViewAttributes()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setControllerDefaultValues() {
        self.sideViewWidth = self.view.frame.size.width * 8/10
        
    }
    
    func changeTableViewAttributes() {
        self.navigationTableView.tableFooterView = UIView()
        
        if (self.dataSource?.responds(to: #selector(self.dataSource?.menuNavigationTabs(backgroundImagefor:))))! {
            if let image = self.dataSource?.menuNavigationTabs!(backgroundImagefor: self.sideView) {
                let imageView = UIImageView(image: image)
                
                imageView.frame = CGRect(x: 0, y: 0, width: self.sideView.frame.size.width, height: self.sideView.frame.size.height)
                self.sideView.addSubview(imageView)
                self.sideView.sendSubview(toBack: imageView)
                imageView.clipsToBounds = true
            }
        }
        
        if (self.dataSource?.responds(to: #selector(self.dataSource?.menuNavigationTabs(subviewFor:))))! {
            if let topView = self.dataSource?.menuNavigationTabs!(subviewFor: self.sideViewTopBanner) {
                self.sideViewTopBanner.addSubview(topView)
                topView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    topView.leadingAnchor.constraint(equalTo: self.sideViewTopBanner.leadingAnchor, constant: 0),
                    topView.trailingAnchor.constraint(equalTo: self.sideViewTopBanner.trailingAnchor, constant: 0),
                    topView.topAnchor.constraint(equalTo: self.sideViewTopBanner.topAnchor, constant: 0),
                    topView.bottomAnchor.constraint(equalTo: self.sideViewTopBanner.bottomAnchor, constant: 0),
                    ])
                topView.clipsToBounds = true
            }
        }
    }
    
    private func loadMainView() {
        //Add container view
        mainView.backgroundColor = UIColor.yellow // Add background color
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
    }
    
    private func loadSideView() {
        //Add container view
        sideView.backgroundColor = UIColor.white // Add background color
        sideView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(sideView)
        self.sideView.clipsToBounds = true
        self.sideView.frame.size.width = self.view.frame.size.width * 8/10
        self.sideView.frame.size.height = self.view.frame.size.height
        SwiftySideMenuHelper.menuWidth = self.view.frame.size.width * 8/10
        self.sideView.center.x = -self.view.frame.size.width / 2
        
        self.loadSideViewTopBanner()
        self.loadSideViewBottomView()
        
        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(guestureStateRecogniser(_:)))
        self.sideView.addGestureRecognizer(panGuesture)
        
    }
    
    private func loadSideViewTopBanner() {
        //Add container view
        sideViewTopBanner.backgroundColor = UIColor.clear // Add background color
        sideViewTopBanner.translatesAutoresizingMaskIntoConstraints = false
        sideView.addSubview(sideViewTopBanner)
        self.sideView.clipsToBounds = true
        NSLayoutConstraint.activate([
            sideViewTopBanner.leadingAnchor.constraint(equalTo: sideView.leadingAnchor, constant: 0),
            sideViewTopBanner.trailingAnchor.constraint(equalTo: sideView.trailingAnchor, constant: 0),
            sideViewTopBanner.topAnchor.constraint(equalTo: sideView.topAnchor, constant: 0),
            sideViewTopBanner.heightAnchor.constraint(equalToConstant: self.view.frame.size.height*3/10),
            ])
    }
    
    private func loadSideViewBottomView() {
        //Add container view
        sideViewBottomView.backgroundColor = UIColor.clear // Add background color
        sideViewBottomView.translatesAutoresizingMaskIntoConstraints = false
        sideView.addSubview(sideViewBottomView)
        self.sideView.clipsToBounds = true
        NSLayoutConstraint.activate([
            sideViewBottomView.leadingAnchor.constraint(equalTo: sideView.leadingAnchor, constant: 0),
            sideViewBottomView.trailingAnchor.constraint(equalTo: sideView.trailingAnchor, constant: 0),
            sideViewBottomView.topAnchor.constraint(equalTo: self.sideViewTopBanner.bottomAnchor, constant: 0),
            sideViewBottomView.bottomAnchor.constraint(equalTo: self.sideView.bottomAnchor, constant: 0),
            ])
        
        
        navigationTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width * 8/10, height: self.view.frame.size.height * 7/10))
//        navigationTableView.register(UINib(nibName: "SwiftySideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SwiftySideMenuTableViewCell")
        
        let podBundle = Bundle(for: SwiftySideMenuViewController.self)
        if let bundleURL = podBundle.url(forResource: "SwiftySideMenu", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let cellNib = UINib(nibName: "SwiftySideMenuTableViewCell", bundle: bundle)
                navigationTableView.register(cellNib, forCellReuseIdentifier: "SwiftySideMenuTableViewCell")
            } else {
                assertionFailure("Could not load the bundle")
            }
        } else {
            assertionFailure("Could not create a path to the bundle")
        }
        
        navigationTableView.dataSource = self
        navigationTableView.delegate = self
        self.sideViewBottomView.addSubview(navigationTableView)
    }
    
    private func loadDismissView() {
        //Add container view
        dismissView.backgroundColor = UIColor.clear // Add background color
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissView)
        dismissView.alpha = 0.0
        NSLayoutConstraint.activate([
            dismissView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            dismissView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dismissView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            dismissView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
        
        let menueButton = UIButton()
        menueButton.backgroundColor = UIColor.clear
        menueButton.setBackgroundImage(UIImage(named: "dismissViewOverlay"), for: UIControlState.normal)
        menueButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        menueButton.addTarget(self, action:#selector(self.menuClose), for: .touchUpInside)
        self.dismissView.addSubview(menueButton)
        
        self.view.sendSubview(toBack: self.dismissView)
    }
    
    private func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .Right, .Down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Up, .Left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    func mapGestureStateToInteractor(gestureState:UIGestureRecognizerState, progress:CGFloat, velocity: CGFloat, triggerFunc: () -> Void) {
        switch gestureState {
        case .began:
            triggerFunc()
        case .changed:
            self.sideView.center.x = self.sideView.frame.size.width / 2 - ((self.view.frame.size.width) * progress)
            self.dismissView.alpha = 1.0 - (1.0 * progress)
            SwiftySideMenuHelper.currentMenuWidth = (self.sideView.frame.size.width) * progress
        case .ended:
            if velocity < CGFloat(-1000.00) {
                self.menuClose(isUserForceClose: true)
            } else {
                if SwiftySideMenuHelper.shouldCloseMenu() {
                    self.menuClose(isUserForceClose: false)
                } else {
                    self.menuOpen()
                }
            }
        default:
            break
        }
    }
    
    @objc private func guestureStateRecogniser(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let progress = self.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        self.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            velocity: sender.velocity(in: view).x) {
                //                    print(self.sideView.frame.origin.x)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.childVC.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftySideMenuTableViewCell", for: indexPath) as! SwiftySideMenuTableViewCell
        cell.tabName.text =  self.childVC[indexPath.row].tabName
        cell.tabIcon.image = UIImage(named: self.childVC[indexPath.row].tabIconName!)
        cell.selectionStyle = .none
        
        if (self.dataSource?.responds(to: #selector(self.dataSource?.menuNavigationTabs(_:backgroundColorFor:indexPath:))))! {
            cell.backgroundColor = self.dataSource!.menuNavigationTabs!(self.navigationTableView, backgroundColorFor: cell, indexPath: indexPath)
        }
        
        if selectedIndexPathRow == indexPath.row {
            UIView.animate(withDuration: 0.3) {
                cell.tabName.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                cell.tabIcon.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                cell.backgroundView = UIImageView(image: UIImage(named: "dismissViewOverlay"))
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                cell.tabName.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                cell.tabIcon.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                cell.backgroundView = nil
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (self.dataSource?.responds(to: #selector(self.dataSource?.menuNavigationTabs(_:heightForRowAt:))))! {
            return (self.dataSource?.menuNavigationTabs!(self.navigationTableView, heightForRowAt: indexPath))!
        } else {
            return 60.00
        }
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedIndexPathRow != indexPath.row {
            self.selectedIndexPathRow = indexPath.row
            let previousView: UIView! = self.mainView.subviews.first
            
            let controller = storyboard!.instantiateViewController(withIdentifier: self.childVC[indexPath.row].viewControllerIdentifier!)
            addChildViewController(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(controller.view)
            
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: mainView.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
                ])
            controller.didMove(toParentViewController: self)
            
            if previousView != nil {
                previousView.removeFromSuperview()
            }
        }
        
        self.navigationTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.menuClose(isUserForceClose: false)
        })
        
    }
    
    func menuButtonClicked() {
        self.view.insertSubview(self.dismissView, belowSubview: self.sideView)
        UIView.animate(withDuration: 0.5) {
            self.sideView.center.x = +self.sideView.frame.size.width / 2
            self.dismissView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
        
    }
    
    func menuOpen() {
        UIView.animate(withDuration: 0.3) {
            self.sideView.center.x = +self.sideView.frame.size.width / 2
            self.view.layoutIfNeeded()
        }
        
    }
    
    func menuClose(isUserForceClose: Bool) {
        if isUserForceClose {
            UIView.animate(withDuration: 0.2, animations: {
                self.sideView.center.x = -self.sideView.frame.size.width / 2
                self.view.layoutIfNeeded()
                self.dismissView.alpha = 0.0
            }, completion: { completed in
                self.view.sendSubview(toBack: self.dismissView)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.sideView.center.x = -self.sideView.frame.size.width / 2
                self.view.layoutIfNeeded()
                self.dismissView.alpha = 0.0
            }, completion: { completed in
                self.view.sendSubview(toBack: self.dismissView)
            })
        }
        
    }
    
}
