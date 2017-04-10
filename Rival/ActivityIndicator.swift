//
//  ActivityIndicator.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 4. 5..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation

class ActivityIndicator{
    
    func setActivityIndicator(view:UIView) -> UIActivityIndicatorView{
        var indicator = UIActivityIndicatorView()
        indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:100, height:100))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        return indicator
    }
    
}
