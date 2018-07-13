//
//  MyLocationViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2018. 7. 13..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

final class MyLocationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  private let locationManager = CLLocationManager() // ARC 관리 때문에 viewDidLoad 밖에 선언
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.showsUserLocation = true // 사용자 위치
    locationManager.delegate = self
    checkAuthorizationStatus()
  }
  
  
  private func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
      // Disable location features
      break
    case .authorizedWhenInUse:
      // Enable basic location features
      // enableMyWhenInUseFeatures()
      fallthrough
    case .authorizedAlways:
      // Enable any of your app's location features
      // enableMyAlwaysFeatures()
      startUpdatingLocation()
    }
  }
  
  private func startUpdatingLocation() {
    let status = CLLocationManager.authorizationStatus()
    guard status == .authorizedAlways || status == .authorizedWhenInUse,
      CLLocationManager.locationServicesEnabled()
      else { return }
    
//    locationManager.desiredAccuracy = kCLLocation
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.distanceFilter = 10.0
    locationManager.startUpdatingLocation()
  }
  
  @IBAction private func mornitoringHeading(_ sender: Any) {
    guard CLLocationManager.headingAvailable() else { return }
    locationManager.startUpdatingHeading()
  }
  
  @IBAction private func stopMornitoring(_ sender: Any) {
    locationManager.stopUpdatingHeading()
  }
}


// MARK: - CLLocationManagerDelegate

extension MyLocationViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let current = locations.last!

    
    if (abs(current.timestamp.timeIntervalSinceNow) < 10) {
      let coordinate = current.coordinate//
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      mapView.setRegion(region, animated: true)
      
      let annotation = Annotation(title: "MyLocation", coordinate: coordinate)
      if let anno = mapView.annotations.first {
        mapView.removeAnnotation(anno)
      }
      mapView.addAnnotation(annotation)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("\n---------- [ status ] ----------\n")
    print(status)
    
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      print("Authorized")
    default:
      print("Unauthorized")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let error = error as? CLError, error.code == .denied {
      // Location updates are not authorized.
      // Stop Requesting Location Service
      return
    }
    // Notify the user of any errors.
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    print("\n---------- [ didUpdateHeading ] ----------")
    print("trueHeading :", newHeading.trueHeading)
    print("magneticHeading :", newHeading.magneticHeading)
    print("values \(newHeading.x), \(newHeading.y), \(newHeading.z)")
  }
}



class Annotation: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  
  init(title: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
  }
}
