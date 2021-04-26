/*
Rovers.swift
YSpace
 
Created by RVSM on 28/03/20.
 Copyright © 2020 RVSM. All rights reserved.



Rover Cameras
Abbreviation    Camera                                         Curiosity    Opportunity    Spirit
FHAZ            Front Hazard Avoidance Camera                      ✔             ✔            ✔
RHAZ            Rear Hazard Avoidance Camera                       ✔             ✔            ✔
MAST            Mast Camera                                        ✔
CHEMCAM         Chemistry and Camera Complex                       ✔
MAHLI           Mars Hand Lens Imager                              ✔
MARDI           Mars Descent Imager                                ✔
NAVCAM          Navigation Camera                                  ✔             ✔             ✔
PANCAM          Panoramic Camera                                                 ✔             ✔
MINITES         Miniature Thermal Emission Spectrometer (Mini-TES)               ✔             ✔

*/

public enum RoverName: CaseIterable {
    
    case curiosity
    case opportunity
    case spirit
    
    var name: String {
        switch self {
        case .curiosity: return "curiosity"
        case .opportunity: return "opportunity"
        case .spirit: return "spirit"
        }
    }
}

public enum RoverCamera: String, CaseIterable {
    
    case fhaz = "FHAZ"
    case rhaz = "RHAZ"
    case mast = "MAST"
    case chemcam = "CHEMCAM"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case navcam = "NAVCAM"
    case pancam = "PANCAM"
    case minites = "MINITES"
    
    var value: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .fhaz: return "Front Hazard Avoidance Camera"
        case .rhaz: return "Rear Hazard Avoidance Camera"
        case .mast: return "Mast Camera"
        case .chemcam: return "Chemistry and Camera Complex"
        case .mahli: return "Mars Hand Lens Imager "
        case .mardi: return "Mars Descent Imager"
        case .navcam: return "Navigation Camera"
        case .pancam: return "Panoramic Camera"
        case .minites: return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }
    
    func availableInRovers() -> [RoverName] {
        switch self {
        case .fhaz: return [.curiosity, .opportunity, .spirit]
        case .rhaz: return [.curiosity, .opportunity, .spirit]
        case .mast: return [.curiosity]
        case .chemcam: return [.curiosity]
        case .mahli: return [.curiosity]
        case .mardi: return [.curiosity]
        case .navcam: return [.curiosity, .opportunity, .spirit]
        case .pancam: return [.opportunity, .spirit]
        case .minites: return [.opportunity, .spirit]
        }
    }
}
