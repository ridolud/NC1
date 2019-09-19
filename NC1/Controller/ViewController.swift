//
//  ViewController.swift
//  NC1
//
//  Created by Faridho Luedfi on 19/09/19.
//  Copyright © 2019 ridolud. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var testLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let networkManager = NCNetworkManager.shared
        print( isIosdaTraningWifi() )

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            setUpGeofenceForIosda()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        testLabel.text = locValue.longitude.description
    }
    
    func setUpGeofenceForIosda() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(-6.302336, 106.652397);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 120, identifier: "IosdaClass");
        geofenceRegion.notifyOnExit = true;
        geofenceRegion.notifyOnEntry = true;
        self.locationManager.startMonitoring(for: geofenceRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Welcome to Playa Grande! If the waves are good, you can try surfing!")
        
        let alert = UIAlertController(title: "Alert", message: "Welcome to Playa Grande! If the waves are good, you can try surfing!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        // Good place to schedule a local notification
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Bye! Hope you had a great day at the beach!")
        // Good place to schedule a local notification
        
        let alert = UIAlertController(title: "Alert", message: "Bye! Hope you had a great day at the beach!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

