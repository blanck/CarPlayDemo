//
//  CarPlaySceneDelegate.swift
//  CarPlayTutorial
//
//

import CarPlay
class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
        let pm1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.333233, longitude: 18.116278))
        let p1 = CPPointOfInterest(location: MKMapItem(placemark: pm1),
                                   title:  "Sjöhistoriska Museet",
                                   subtitle: "2 x 11 kW Type 2",
                                   summary: "3 SEK/kWh",
                                   detailTitle: "",
                                   detailSubtitle: "Djurgårdsbrunnsvägen 24 , Stockholm",
                                   detailSummary: "",
                                   pinImage: nil)

        let information = CPInformationTemplate(title: "Recent stations", layout:CPInformationTemplateLayout.leading, items: [], actions: [])
        let poi = CPPointOfInterestTemplate(title: "Nearby", pointsOfInterest: [p1], selectedIndex: 0)
        poi.pointOfInterestDelegate = self
        

        let list = getListTemplate()

        let tabBar = CPTabBarTemplate(templates: [poi, list, information])
        interfaceController.setRootTemplate(tabBar, animated: true, completion: {_, _ in })
        
        poi.tabTitle = "Nearby"
        poi.tabImage = UIImage(systemName: "mappin.and.ellipse")

        information.tabTitle = "Recent"
        information.tabImage = UIImage(systemName: "clock")

        list.tabTitle = "Favorites"
        list.tabImage = UIImage(systemName: "heart.fill")

        tabBar.updateTemplates([poi, list, information])

        
    }
    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
    
    func getListTemplate() -> CPListTemplate {
      let item = CPListItem(text: "Sjöhistoriska Museet", detailText: "450 m away - 2 x 11 kW Type 2")

      let section = CPListSection(items: [item])
      let listTemplate = CPListTemplate(title: "First page", sections: [section])

      return listTemplate
    }

}

extension CarPlaySceneDelegate: CPPointOfInterestTemplateDelegate {

  func pointOfInterestTemplate(_ aTemplate: CPPointOfInterestTemplate, didChangeMapRegion region: MKCoordinateRegion) {
    debugPrint("didChangeRegion")
  }
}
