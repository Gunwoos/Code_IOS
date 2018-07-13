//
//  GeocodeViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2018. 7. 12..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit
import MapKit

/***************************************************
 맵뷰 터치 시 해당 좌표에 맞는 위경도 값을 통해 주소값 확인하기
 ***************************************************/

final class GeocodeViewController: UIViewController {

  @IBOutlet private weak var mapView: MKMapView!
  
  @IBAction func recognizeTap(gesture: UITapGestureRecognizer) {
    let touchPoint = gesture.location(in: gesture.view)
    let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    let geocoder = CLGeocoder()
    
    // 비동기로 요청 후 그 결과 (completionHandler) 는 MainThread 에서 처리됨
    // Geocoding 요청 중에는 또 다른 Geocoding 작업을 요청하지 말 것
    geocoder.reverseGeocodeLocation(location) { placeMark, error in
      if error != nil {
        print(error!.localizedDescription)
        return
      }
      guard let address = placeMark?.first,
        let country = address.country,
        let administrativeArea = address.administrativeArea,
        let name = address.name,
        let postalCode = address.postalCode
        else { return }
      print("\n---------- [ 터치 좌표 주소 ] ----------")
      print("- \(country) \(administrativeArea) \(name) \(postalCode)")
        
        
    }
  }
}

