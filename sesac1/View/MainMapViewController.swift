//
//  MainMapViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/24.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
    

    let customView = MainMapCustomView()
    
    override func loadView() {
        super.loadView()
        view = customView
        customView.floatingButton.addTarget(self, action: #selector(pushNav), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.customView.viewModel.requestQueue { statuscode, error, sesacs in
                guard let sesacs = sesacs else {
                    return
                }
                
                self.customView.viewModel.allSesacArray.value = sesacs
                
                self.customView.viewModel.addAnnotation(gender: nil, mapView: self.customView.mapView) {
                
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
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
    
    @objc func pushNav() {
        let svc = SearchSesacViewController()
        svc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    

}

extension MainMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
               guard let annotation = annotation as? CustomAnnotation else {
                   return nil
               }
               
        var annotationView = self.customView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
               
               if annotationView == nil {
                   annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
                   annotationView?.canShowCallout = false
                   
               } else {
                   annotationView?.annotation = annotation
               }
               
               let sesacImage: UIImage!
               
               switch annotation.sesac_image {
               case 0:
                   sesacImage = UIImage(named: "sesac_face_1")
               case 1:
                   sesacImage = UIImage(named: "sesac_face_2")
               case 2:
                   sesacImage = UIImage(named: "sesac_face_3")
               case 3:
                   sesacImage = UIImage(named: "sesac_face_4")
               case 4:
                   sesacImage = UIImage(named: "sesac_face_5")
               default:
                   sesacImage = UIImage(named: "sesac_face_1")
               }
               
        annotationView!.snp.makeConstraints { make in
            make.width.height.equalTo(110)
        }
        annotationView!.image = sesacImage
               
               return annotationView
    }
}

