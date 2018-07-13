//
//  BasicAnnotationViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2018. 7. 13..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit
import MapKit

final class BasicAnnotationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  var index = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let center = CLLocationCoordinate2DMake(37.566308, 126.977948)
    
    // Span 단위는 1도
    // 위도 1도는 약 111킬로미터. 경도 1도는 위도에 따라 변함. 적도 약 111킬로미터 ~ 극지방 0)
    let span = MKCoordinateSpanMake(0.1, 0.1)
    let region = MKCoordinateRegionMake(center, span)
    mapView.setRegion(region, animated: true)
  }
  
  @IBAction private func addAnnotation(_ sender: Any) {
    let cityHall = MKPointAnnotation()
    cityHall.coordinate = CLLocationCoordinate2D(latitude: 37.566308, longitude: 126.977948)
    cityHall.title = "시청"
    cityHall.subtitle = "서울특별시"
    
    mapView.add(makeCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 37.566308, longitude: 126.977948), radius: 2000))
    mapView.addAnnotation(cityHall)
    
    let namsan = MKPointAnnotation()
    namsan.title = "남산"
    namsan.coordinate = CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194)
    mapView.add(makeCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194), radius: 2000))
    mapView.addAnnotation(namsan)

    let gimpoAirport = MKPointAnnotation()
    gimpoAirport.coordinate = CLLocationCoordinate2D(latitude: 37.559670, longitude: 126.794320)
    gimpoAirport.title = "김포공항"
    mapView.add(makeCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 37.559670, longitude: 126.794320), radius: 2000))
    mapView.addAnnotation(gimpoAirport)
    
    let Home = MKPointAnnotation()
    Home.coordinate = CLLocationCoordinate2D(latitude: 37.541878, longitude: 127.147429)
    Home.title = "집"
    mapView.add(makeCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 37.541878, longitude: 127.147429), radius: 2000))
    mapView.addAnnotation(Home)

    let FC = MKPointAnnotation()
    FC.coordinate = CLLocationCoordinate2D(latitude: 37.545102, longitude: 127.057094)
    FC.title = "학원"
    mapView.add(makeCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 37.545102, longitude: 127.057094), radius: 2000))
    mapView.addAnnotation(FC)
    
//    let center = mapView.centerCoordinate
//    let circle = MKCircle(center: center, radius: 40000)
//    MKCircle(center: <#T##CLLocationCoordinate2D#>, radius: <#T##CLLocationDistance#>)
//    mapView.add(circle)
}
    func makeCircle(centerCoordinate: CLLocationCoordinate2D, radius: CLLocationDistance ) -> MKCircle {
        return MKCircle(center: centerCoordinate, radius: radius)
    }
  
  
  @IBAction private func moveToRandomPin(_ sender: Any) {
    guard mapView.annotations.count > 0 else { return }
    let random = Int(arc4random_uniform(UInt32(mapView.annotations.count)))
    let annotation = mapView.annotations[random]
    let center = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: center, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  @IBAction private func removeAnnotation(_ sender: Any) {
    mapView.removeAnnotations(mapView.annotations)
    mapView.removeOverlays(mapView.overlays)
  }
  
  @IBAction private func setupCamera(_ sender: Any) {
    let camera = MKMapCamera()
    camera.centerCoordinate = CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194)
    // 고도 (미터 단위)
    camera.altitude = 200
    // 카메라 각도 (0일 때 수직으로 내려다보는 형태)
    camera.pitch = 70.0
    mapView.setCamera(camera, animated: true)
  }
}

extension BasicAnnotationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
