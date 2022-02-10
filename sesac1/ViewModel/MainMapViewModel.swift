//
//  MainMapViewModel.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/10.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MainMapViewModel {
    let repo = Repository()
    let genderType: Observable<Int> = Observable(0)
    let region: Observable<Int> = Observable(1275130688)
    let long: Observable<Double> = Observable(126.88647317074734)
    let lat: Observable<Double> = Observable(37.517819364682694)
    let hobbyArray: Observable<[String]> = Observable(["Coding", "Reading"])
    var allSesacArray: Observable<NearSeSAC?> = Observable(NearSeSAC(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    var maleSesacArray: Observable<[FromQueueDB]?> = Observable([])
    var femaleSesacArray: Observable<[FromQueueDB]?> = Observable([])
    var annotations: [CustomAnnotation] = []
    
    
    
    
    
    

    func requestQueue(completion: @escaping (Int?, APIError?, NearSeSAC?) -> Void) {
        repo.postQueue(genderType: genderType.value, region: region.value, long: long.value, lat: lat.value, hobbyArray: hobbyArray.value) { [self] statuscode, error, nearSesac in
            print(#function)
            if statuscode == 200 {
                completion(200, nil, nearSesac)
                self.allSesacArray.value = nearSesac
                self.allSesacArray.value?.fromQueueDB.forEach { sesacs in
                    switch sesacs.gender {
                    case 0:
                        self.maleSesacArray.value?.append(sesacs)
                    case 1:
                        self.femaleSesacArray.value?.append(sesacs)
                    default:
                        print("this sesac has no gender")
                    }
                }
            } else {
                completion(statuscode, .failed, nil)
            }
         
        }

    }
    
    func addAnnotation(gender: Int?, mapView: MKMapView, completion: @escaping() -> Void) {
        
        self.annotations = []
        
        switch gender {
        case 0:
            maleSesacArray.value?.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
        case 1:
            femaleSesacArray.value?.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
            
            
        case 2:
            allSesacArray.value?.fromQueueDB.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
        case .none:
            allSesacArray.value?.fromQueueDB.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
        case .some(_):
            allSesacArray.value?.fromQueueDB.forEach({ sesacs in
                let anno = CustomAnnotation(sesac_image: sesacs.sesac, coordinate: CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long))
                
                self.annotations.append(anno)
            })
        }
        
        mapView.addAnnotations(self.annotations)

    }
    
    func removeAnnotations(mapView: MKMapView, completion: @escaping () -> Void) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    
    
    
}

class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
}


class CustomAnnotation: NSObject, MKAnnotation {
  let sesac_image: Int?
  let coordinate: CLLocationCoordinate2D

  init(
    sesac_image: Int?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.sesac_image = sesac_image
    self.coordinate = coordinate

    super.init()
  }

}

