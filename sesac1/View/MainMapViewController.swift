//
//  MainMapViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/24.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
    
    let viewModel = MainMapViewModel()
    let customView = MainMapCustomView()
    
    override func loadView() {
        super.loadView()
        view = customView
        
        DispatchQueue.main.async {
            self.viewModel.requestQueue { statuscode, error, sesacs in
                guard let sesacs = sesacs else {
                    return
                }
                
                self.viewModel.allSesacArray.value = sesacs
                
                self.viewModel.addAnnotation(mapView: self.customView.mapView) {
                    self.customView.mapView.reloadInputViews()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        self.tabBarController?.editButtonItem.tintColor = R.color.whitegreen()
        
        customView.mapView.delegate = self
        
        
    }
    

}

extension MainMapViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
}
