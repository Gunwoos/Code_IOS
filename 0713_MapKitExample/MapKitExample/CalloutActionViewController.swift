//
//  CalloutActionViewController.swift
//  MapKitExample
//
//  Created by 임건우 on 2018. 7. 13..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

final class MuseumInfo: MKPointAnnotation{
    var exhibition : [String]!
    var phoneNumber : String!
    var url : URL!
}

final class CalloutActionViewController: UIViewController {

    @IBOutlet private weak var mapView : MKMapView!
    private let museumAnnotationID = "kMuseumAnnotationViewIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRegionToSeoul()
        addMuseumAnnotations()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func setRegionToSeoul(){
        let center = CLLocationCoordinate2DMake(37.5514, 126.9880)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: true)
    }
    func addMuseumAnnotations(){
        let museum1 = MuseumInfo()
        museum1.title = "국립중앙박물관"
        museum1.coordinate = CLLocationCoordinate2DMake(37.523984, 126.980355)
        museum1.phoneNumber = "02-2077-9000"
        museum1.exhibition = ["고려 견국 1100주년", "칸의 제국 몽골", "외규장각 의궤"]
        museum1.url = URL(string: "http://www.museum.go.kr")!
        
        let museum2 = MuseumInfo()
        museum2.title = "세종문화회관"
        museum2.coordinate = CLLocationCoordinate2DMake(37.572618, 126.975203)
        museum2.phoneNumber = "02-399-1000"
        museum2.exhibition = ["2018 그랜드 summer 클래식", "사랑의 묘약"]
        museum2.url = URL(string: "http://www.sejongpac.or.kr")!
        
        mapView.addAnnotations([museum1, museum2])
    }
}
extension CalloutActionViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MuseumInfo{
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: museumAnnotationID)
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: museumAnnotationID)
            }
            else{
                annotationView?.annotation = annotation
            }
            annotationView!.image = UIImage(named: "museum")
            annotationView!.canShowCallout = true
            
            let addButton = UIButton(type: UIButtonType.contactAdd)
            addButton.tag = 0
            annotationView!.leftCalloutAccessoryView = addButton
            
            let infoButton = UIButton(type: UIButtonType.infoDark)
            infoButton.tag = 1
            annotationView!.rightCalloutAccessoryView = infoButton
            return annotationView
        }
        return MKAnnotationView(frame: .zero)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MuseumInfo else { return }
        print("Annotation Info : \(annotation.title ?? ""), \(annotation.exhibition), \(annotation.phoneNumber)")
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let museum = view.annotation as? MuseumInfo else { return }
        print("title : \(museum.title ?? ""), tag :", control.tag)
        
        if control.tag == 1{
            let safariVC = SFSafariViewController(url: museum.url)
            present(safariVC, animated: true)
        }
    }
}
