import Foundation
import UIKit
import MapKit

class SGMap: MKMapView {
    
    init() {
        super.init(frame: .zero)
        setupMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mkMapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    private func setupMapView() {
        addSubview(mkMapView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mkMapView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mkMapView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mkMapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mkMapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mkMapView.topAnchor.constraint(equalTo: self.topAnchor),
            mkMapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
