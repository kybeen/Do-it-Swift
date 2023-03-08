//
//  ViewController.swift
//  Map
//
//  Created by 김영빈 on 2023/03/08.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구함
        locationManager.startUpdatingLocation() // 위치 업데이트를 시작
        myMap.showsUserLocation = true // 위치 보기 값을 ture로 설정
    }
    
    // 위도,경도로 원하는 위치를 표시해주는 함수
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // 원하는 곳에 핀을 설치해주는 함수
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subTitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치가 업데이트 되었을 때 지도에 위치를 나타내기 위한 델리게이트 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트되면 마지막 위치 값을 찾아냄
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // delta값 작을수록 지도 확대
        CLGeocoder().reverseGeocodeLocation(pLocation!) { (placemarks, error) -> Void in
            let pm = placemarks!.first // placemarks 값의 첫부분만 pm상수로 대입
            let country = pm!.country // pm상수에서 나라 값을 country 상수에 대입
            var address:String = country!
            if pm!.locality != nil { // pm 상수에서 지역 값이 존재하면 address 문자열에 추가
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil { // pm 상수에서 도로 값이 존재하면 address 문자열에 추가
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        }
        locationManager.stopUpdatingLocation()
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 현재 위치 표시
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.551769, longitudeValue: 126.925039, delta: 1, title: "홍익대학교 서울캠퍼스", subTitle: "서울특별시 마포구 와우산로 94")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "홍익대학교 서울캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 36.013964, longitudeValue: 129.323688, delta: 1, title: "포항공과대학교", subTitle: "경상북도 포항시 남구 청암로 77")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "포항공과대학교"
        }
    }
    
}

