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
    
    
    

    func requestQueue(completion: @escaping (Int?, APIError?, NearSeSAC?) -> Void) {
        repo.postQueue(genderType: genderType.value, region: region.value, long: long.value, lat: lat.value, hobbyArray: hobbyArray.value) { statuscode, error, nearSesac in
            print(#function)
            if statuscode == 200 {
                completion(200, nil, nearSesac)
                self.allSesacArray.value = nearSesac
                print(nearSesac)
                
            } else {
                completion(statuscode, .failed, nil)
            }
        }

    }
    
    func addAnnotation(mapView: MKMapView, completion: @escaping() -> Void) {
        var annotations: [MKPointAnnotation] = []
        allSesacArray.value?.fromQueueDB.forEach({ sesacs in
            let anno = MKPointAnnotation()
            anno.coordinate = CLLocationCoordinate2D(latitude: sesacs.lat, longitude: sesacs.long)
            annotations.append(anno)
        })
        
        mapView.addAnnotations(annotations)

    }
    
    
    
    
    
}

