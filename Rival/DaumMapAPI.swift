//
//  DaumMapAPI.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 4. 4..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class DaumMapAPI {
    
    let daumMapApiKey = "ba31dfe7a94d5305d5821ea5b004a5c9"
    
    func setDaumMap(mapView:UIView, name:String, latitude:Double ,longitude:Double) -> MTMapView{
        let map: MTMapView = MTMapView(frame: CGRect(x: 0, y: 0, width: mapView.frame.size.width, height: mapView.frame.size.height))
        map.addPOIItems([poiItem(name: name, latitude: latitude, longitude: longitude)])
        map.fitAreaToShowAllPOIItems()  // 모든 마커가 보이게 카메라 위치/줌 조정
        map.daumMapApiKey = daumMapApiKey
        map.baseMapType = .standard
        return map
    }
    
    func openDaumMap(latitude:Double, longitude:Double){
        let daumMap = "daummaps://look?p=\(latitude),\(longitude)"
        let daumMapAppstore = "https://itunes.apple.com/us/app/id304608425?mt=8"
        let daumMapURL = NSURL(string: daumMap)
        let daumMapAppstoreURL = NSURL(string: daumMapAppstore)
        
        if UIApplication.shared.canOpenURL(daumMapURL! as URL) {
            UIApplication.shared.open(daumMapURL! as URL)
        }
        else {
            UIApplication.shared.open(daumMapAppstoreURL! as URL)
        }
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.markerType = .redPin
        item.markerSelectedType = .redPin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .dropFromHeaven
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)    // 마커 위치 조정
        
        return item
    }
}
