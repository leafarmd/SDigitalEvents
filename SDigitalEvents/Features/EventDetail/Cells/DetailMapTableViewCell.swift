//
//  DetailMapTableViewCell.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit
import MapKit

typealias DetailMapCellConfig = TableCellConfigurator<DetailMapTableViewCell, (latitude: Double, longitude: Double)>

class DetailMapTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var mapLocation: MKMapView!
    
    func configure(data: (latitude: Double, longitude: Double)) {
        
        let initialLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        mapLocation.addAnnotation(annotation)
        
        mapLocation.setRegion(coordinateRegion, animated: true)
    }
}
