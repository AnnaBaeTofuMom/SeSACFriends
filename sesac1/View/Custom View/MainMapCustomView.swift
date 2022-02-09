//
//  MainMapCustomView.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/09.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import RxSwift
import SnapKit

class MainMapCustomView: UIView {
    
    let mapView = MKMapView()
    let stackShadowView = UIView()
    let buttonStackView = UIStackView()
    let maleButton = UIButton()
    let femaleButton = UIButton()
    let allButton = UIButton()
    let gpsButton = UIButton()
    let floatingButton = UIButton()
    let centerAnnotation = UIImageView()
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        let locationManager = CLLocationManager()
        
        [mapView, stackShadowView, gpsButton, floatingButton, centerAnnotation].forEach {
            self.addSubview($0)
        }
        
        stackShadowView.addSubview(buttonStackView)
        
        [allButton, maleButton, femaleButton].forEach {
            buttonStackView.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(onSearchGenderButtonClicked(sender:)), for: .touchUpInside)
        }
        
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        mapView.setRegion(MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 37.51793850084744,  longitude: 126.88631223877245), span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)), animated: true)
        
        
        centerAnnotation.image = UIImage(named: "centerAnnotation")
        
        stackShadowView.layer.cornerRadius = 8
        stackShadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        stackShadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        stackShadowView.layer.shadowRadius = 3
        stackShadowView.layer.shadowOpacity = 0.9
        
        buttonStackView.layer.cornerRadius = 8
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 0
        buttonStackView.clipsToBounds = true
        
        
        maleButton.setTitle("남자", for: .normal)
        maleButton.setTitleColor(R.color.black(), for: .normal)
        maleButton.setTitleColor(R.color.white(), for: .selected)
        maleButton.setBackgroundColor(R.color.white()!, for: .normal)
        maleButton.setBackgroundColor(R.color.green()!, for: .selected)
        maleButton.titleLabel!.font = R.font.notoSansCJKkrRegular(size: 14)
        
        femaleButton.setTitle("여자", for: .normal)
        femaleButton.setTitleColor(R.color.black(), for: .normal)
        femaleButton.setTitleColor(R.color.white(), for: .selected)
        femaleButton.setBackgroundColor(R.color.white()!, for: .normal)
        femaleButton.setBackgroundColor(R.color.green()!, for: .selected)
        femaleButton.titleLabel!.font = R.font.notoSansCJKkrRegular(size: 14)
        
        floatingButton.setImage(UIImage(named: "before_search_btn"), for: .normal)
        
        allButton.setTitle("전체", for: .normal)
        allButton.setTitleColor(R.color.black(), for: .normal)
        allButton.setTitleColor(R.color.white(), for: .selected)
        allButton.setBackgroundColor(R.color.white()!, for: .normal)
        allButton.setBackgroundColor(R.color.green()!, for: .selected)
        allButton.titleLabel!.font = R.font.notoSansCJKkrRegular(size: 14)
        
        gpsButton.setImage(UIImage(named: "gps_btn"), for: .normal)
        
    }
        
    func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackShadowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        [allButton, maleButton, femaleButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.height.equalTo(49)
            }
        }
        
        gpsButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(buttonStackView.snp.bottom).offset(16)
        }
        
        centerAnnotation.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        
    }
    
    @objc func onSearchGenderButtonClicked(sender: UIButton) {
            allButton.isSelected = false
            femaleButton.isSelected = false
            maleButton.isSelected = false
            
            sender.isSelected = true
          
        }
    
    
}

extension MainMapCustomView: MKMapViewDelegate {
    
}
