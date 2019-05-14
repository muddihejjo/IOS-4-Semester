import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    var last: CLLocation?
    var speed:Double = 0;
    let speedo = AccelerometerSpeedoMeter()
    var displayLink:CADisplayLink?
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var Speedometer: UILabel!
   
  
    
    func processLocation(_ current:CLLocation) {
        guard last != nil else {
            last = current
            return
        }
        var speed = current.speed
       
        if (speed > 0) {
            print(speed) // or whatever
        } else {
            speed = last!.distance(from: current) / (current.timestamp.timeIntervalSince(last!.timestamp))
            print(speed)
        }
        last = current
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            processLocation(location)
        }
    Speedometer.text = String(speed)
    }
    

    
    
    
    @objc func update() {
        if let xLabelu = xLabel {xLabelu.text = String(format: "x: %.02f", self.speedo.getAccelerationValues().x)}
        else {print("nil2")}
        if let yLabelu = yLabel {yLabelu.text = String(format: "y: %.02f", self.speedo.getAccelerationValues().y)}
        else {print("nil3")}
        if let zLabelu = zLabel {zLabelu.text = String(format: "z: %.02f", self.speedo.getAccelerationValues().z)}
        else {print("nil4")}
    
    
       
    
        let total = abs(speedo.getAccelerationValues().x + speedo.getAccelerationValues().y + speedo.getAccelerationValues().z)
        totalLabel.text = String(format: "total: %.1.2f", speed)
        
        speed = speed+total-1
        sumLabel.text = String(speed)
        
        print(speed)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("4")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        displayLink = CADisplayLink(target: self, selector: #selector(self.update))
        if let displayLinku = displayLink {displayLinku.add(to: RunLoop.current, forMode: RunLoop.Mode.common)} else {print("nil1")}
        print("2")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
