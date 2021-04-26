//
//  MarsMosaics.swift
//  Spacing
//
//  Created by rvsm on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

public enum MarsMosaics {
    
    case VIKING, CTX_CURIOSITY_LANDING_SITE, HIRISE_CURIOSITY_LANDING_SITE, HIRISE_ESP_040776_2115, HIRISE_ESP_042252_1930_RED_B_01_ORTHO
    case HIRISE_ESP_042647_1760_RED_B_01_ORTHO, HRSC_MARTIAN_EAST, HRSC_COLOR_MC11
    case HIRISE_SPIRIT_LANDING_SITE, HIRISE_OPPORTUNITY_LANDING_SITE, ROVER_PATH_OPPORTUNITY_LANDING_SITE
    case HIRISE_PHOENIX_LANDING_SITE, HIRISE_SOJOURNER_LANDING_SITE, ALBEDO_THERMAL_EMISSION_SPECTROMETER
    case DEM_GRAYSCALE_ORBITER_LASER_ALTIMETER, COLOR_HILLSHADE_ORBITER_LASER_ALTIMETER, EXPERIENCE_CURIOSITY_LANDING_SITE
    case ATLAS_ORBITER_CAMERA, INFRARED_NIGHT_THERMAL_EMISSION_IMAGING_SYSTEM, INFRARED_DAY_THERMAL_EMISSION_IMAGING_SYSTEM
    case HRSC_MAWRTH_VALLIS, HRSC_COLOR_MAWRTH_VALLIS
    
    var layerId: String {
        switch self {
        case .VIKING: return "Mars_Viking_MDIM21_ClrMosaic_global_232m"
        case .CTX_CURIOSITY_LANDING_SITE: return "curiosity_ctx_mosaic"
        case .HIRISE_CURIOSITY_LANDING_SITE: return "curiosity_hirise_mosaic"
        case .HIRISE_ESP_040776_2115: return "ESP_040776_2115_RED_A_01_ORTHO"
        case .HIRISE_ESP_042252_1930_RED_B_01_ORTHO: return "ESP_042252_1930_RED_B_01_ORTHO"
        case .HIRISE_ESP_042647_1760_RED_B_01_ORTHO: return " ESP_042647_1760_RED_B_01_ORTHO"
        case .HRSC_MARTIAN_EAST: return "HRSC_Martian_east"
        case .HRSC_COLOR_MC11: return "MC11E_HRMOSCO_COL"
        case .HIRISE_SPIRIT_LANDING_SITE: return "spirit_hirise_mosaic"
        case .HIRISE_OPPORTUNITY_LANDING_SITE: return "opportunity_hirise_mosaic"
        case .ROVER_PATH_OPPORTUNITY_LANDING_SITE: return "opportunity_path"
        case .HIRISE_PHOENIX_LANDING_SITE: return "phoenix_hirise_mosaic"
        case .HIRISE_SOJOURNER_LANDING_SITE: return "sojourner_hirise_mosaic"
        case .ALBEDO_THERMAL_EMISSION_SPECTROMETER: return "Mars_MGS_TES_Albedo_mosaic_global_7410m"
        case .DEM_GRAYSCALE_ORBITER_LASER_ALTIMETER: return "Mars_MGS_MOLA_DEM_mosaic_global_463m_8"
        case .COLOR_HILLSHADE_ORBITER_LASER_ALTIMETER: return "Mars_MGS_MOLA_ClrShade_merge_global_463m"
        case .EXPERIENCE_CURIOSITY_LANDING_SITE: return "mars_pahrump_patch_8k_256m"
        case .ATLAS_ORBITER_CAMERA: return "msss_atlas_simp_clon"
        case .INFRARED_NIGHT_THERMAL_EMISSION_IMAGING_SYSTEM: return "Mars_MO_THEMIS-IR-Night_mosaic_60N60S_100m_v14_clon0_ly"
        case .INFRARED_DAY_THERMAL_EMISSION_IMAGING_SYSTEM: return "Mars_MO_THEMIS-IR-Day_mosaic_global_100m_v12_clon0_ly"
        case .HRSC_MAWRTH_VALLIS: return "hrsc_mawrth_vallis"
        case .HRSC_COLOR_MAWRTH_VALLIS: return "hrsc_mawrth_vallis_color"
        }
    }
    
    var tileMatrixSet: String {
        switch self {
        default: return "default028mm"
        }
    }
    
    var style: String {
        switch self {
        default: return "default"
        }
    }
    
    var wmtsEndpoint: String {
        return baseEndpoint + path
    }
    
    var baseEndpoint: String {
        switch self {
        case .ROVER_PATH_OPPORTUNITY_LANDING_SITE: return "https://api.nasa.gov/mars-wmts/arcgis/rest/services/opportunity_path/MapServer/"
        default: return "https://api.nasa.gov/mars-wmts/catalog/"
        }
    }
    
    var path: String {
        switch self {
        case .VIKING: return "Mars_Viking_MDIM21_ClrMosaic_global_232m"
        case .CTX_CURIOSITY_LANDING_SITE: return "curiosity_ctx_mosaic"
        case .HIRISE_CURIOSITY_LANDING_SITE: return "curiosity_hirise_mosaic"
        case .HIRISE_ESP_040776_2115: return "ESP_040776_2115_RED_A_01_ORTHO"
        case .HIRISE_ESP_042252_1930_RED_B_01_ORTHO: return "ESP_042252_1930_RED_B_01_ORTHO"
        case .HIRISE_ESP_042647_1760_RED_B_01_ORTHO: return "ESP_042647_1760_RED_B_01_ORTHO"
        case .HRSC_MARTIAN_EAST: return "HRSC_Martian_east"
        case .HRSC_COLOR_MC11: return "MC11E_HRMOSCO_COL"
        case .HIRISE_SPIRIT_LANDING_SITE: return "spirit_hirise_mosaic"
        case .HIRISE_OPPORTUNITY_LANDING_SITE: return "opportunity_hirise_mosaic"
        case .ROVER_PATH_OPPORTUNITY_LANDING_SITE: return "WMTS"
        case .HIRISE_PHOENIX_LANDING_SITE: return "phoenix_hirise_mosaic"
        case .HIRISE_SOJOURNER_LANDING_SITE: return "sojourner_hirise_mosaic"
        case .ALBEDO_THERMAL_EMISSION_SPECTROMETER: return "Mars_MGS_TES_Albedo_mosaic_global_7410m"
        case .DEM_GRAYSCALE_ORBITER_LASER_ALTIMETER: return "Mars_MGS_MOLA_DEM_mosaic_global_463m_8"
        case .COLOR_HILLSHADE_ORBITER_LASER_ALTIMETER: return "Mars_MGS_MOLA_ClrShade_merge_global_463m"
        case .EXPERIENCE_CURIOSITY_LANDING_SITE: return "mars_pahrump_patch_8k_256m"
        case .ATLAS_ORBITER_CAMERA: return "msss_atlas_simp_clon"
        case .INFRARED_NIGHT_THERMAL_EMISSION_IMAGING_SYSTEM: return "Mars_MO_THEMIS-IR-Night_mosaic_60N60S_100m_v14_clon0_ly"
        case .INFRARED_DAY_THERMAL_EMISSION_IMAGING_SYSTEM: return "Mars_MO_THEMIS-IR-Day_mosaic_global_100m_v12_clon0_ly"
        case .HRSC_MAWRTH_VALLIS: return "hrsc_mawrth_vallis"
        case .HRSC_COLOR_MAWRTH_VALLIS: return "hrsc_mawrth_vallis_color"
        }
    }
    
    var projection: Dictionary<String,Int> {
        switch self {
        default: return ["IAU2000":49900]
        }
    }
    
    var bBox: (Double, Double, Double, Double) {
        switch self {
        case .VIKING: return (-180.0,-90.0,180.0,90.0)
        case .CTX_CURIOSITY_LANDING_SITE: return (136.2768326,-7.2137273,139.3864225,-3.5804738)
        case .HIRISE_CURIOSITY_LANDING_SITE: return (137.1224669,-4.9254743,137.7298129,-4.2489588)
        case .HIRISE_ESP_040776_2115: return (-28.692987,31.2391925,-28.5529717,31.5262331)
        case .HIRISE_ESP_042252_1930_RED_B_01_ORTHO: return (-4.3189165,12.4509362,-4.1936811,12.8286463)
        case .HIRISE_ESP_042647_1760_RED_B_01_ORTHO: return (15.1514729,-4.1212243,15.259779,-3.8131537)
        case .HRSC_MARTIAN_EAST: return (-0.2759985,-4.0071169,16.6967639,4.1070046)
        case .HRSC_COLOR_MC11: return (-22.5003192,-0.0004218,0.0004218,30.0005662)
        case .HIRISE_SPIRIT_LANDING_SITE: return (175.4264209,-14.6918829,175.5801329,-14.5345989)
        case .HIRISE_OPPORTUNITY_LANDING_SITE: return (-5.5964391,-2.7513281,-4.9954112,-1.8994384)
        case .ROVER_PATH_OPPORTUNITY_LANDING_SITE: return (-5.5964391,-2.7513281,-4.9954112,-1.8994384)
        case .HIRISE_PHOENIX_LANDING_SITE: return (-125.8898226,68.165978,-125.6607922,68.2499439)
        case .HIRISE_SOJOURNER_LANDING_SITE: return (-33.2879718,19.0227898,-33.208734,19.1598471)
        case .ALBEDO_THERMAL_EMISSION_SPECTROMETER: return (-180,-90,180,90)
        case .DEM_GRAYSCALE_ORBITER_LASER_ALTIMETER: return (-180,-90,180,90)
        case .COLOR_HILLSHADE_ORBITER_LASER_ALTIMETER: return (-180,-90,180,90)
        case .EXPERIENCE_CURIOSITY_LANDING_SITE: return (137.3752976,-4.6651732,137.3796184,-4.6608555)
        case .ATLAS_ORBITER_CAMERA: return (-180,-90,180,90)
        case .INFRARED_NIGHT_THERMAL_EMISSION_IMAGING_SYSTEM: return (-180,-60,180,60)
        case .INFRARED_DAY_THERMAL_EMISSION_IMAGING_SYSTEM: return (-180,-90,180,90)
        case .HRSC_MAWRTH_VALLIS: return (-22.0015016,20.9957076,-16.5001079,27.0011311)
        case .HRSC_COLOR_MAWRTH_VALLIS: return (-22,20.9997983,-16.4998151,27)
        }
    }
}

