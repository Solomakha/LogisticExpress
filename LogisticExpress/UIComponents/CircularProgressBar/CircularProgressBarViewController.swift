//
//  CircularProgressBarViewController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 05.03.2024.
//

import UIKit

class CircularProgressBarViewController: UIViewController {
    weak var coordinator: CircularProgressBarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view, typically from a nib.
        let circularProgress = CircularProgressBarView(frame: CGRect(x: 10.0, y: 30.0, width: 200.0, height: 200.0))
        circularProgress.progressColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        circularProgress.trackColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 0.6)
        circularProgress.tag = 101
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        
        //animate progress
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.3)
    }
    
    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! CircularProgressBarView
        cp.setProgressWithAnimation(duration: 2.0, value: 1) //value указываем на сколько заполняеться наш прогресс бар
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.coordinator?.showRouteMapPage()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
