//
//  UUIDKey.swift
//  BLETest
//
//  Created by  DARFON on 2019/9/2.
//  Copyright © 2019  DARFON. All rights reserved.
//

import CoreBluetooth

// UUID marge
fileprivate func getMargeUUID(withBaseFormat baseFormat: String, withIdentifier identifier: String) -> CBUUID {
    let margeUUID = String(format: baseFormat, identifier)
    return CBUUID(string: margeUUID)
}

// Base UUID formats
let baseUUID: String = "EF68%@-9B35-4933-9B10-52FFA9740042"


// ConfigurationService UUIDs
func getConfigurationServiceUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0100")
}
//let connectUUID = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")


// EnvironmentService UUIDs
func getEnvironmentServiceUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0200")
}
func getTemperatureCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0201")
}
func getPressureCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0202")
}
func getHumidityCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0203")
}
func getAirQualityCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0204")
}
func getLightIntensityCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0205")
}
func getEnvironmentConfigurationCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0206")
}


// MotionService UUIDs
func getMotionServiceUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0400")
}
func getMotionConfigurationCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0401")
}
func getTapCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0402")
}
func getOrientationCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0403")
}
func getQuaternionCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0404")
}
func getPedometerCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0405")
}
func getRawDataCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0406")
}
func getEulerCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0407")
}
func getRotationMatrixCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0408")
}
func getHeadingCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0409")
}
func getGravityVectorCharacteristicUUID() -> CBUUID {
    return getMargeUUID(withBaseFormat: baseUUID, withIdentifier: "0410")
}


// Returns All Services UUIDs
func getAllServices() -> [CBUUID] {
    return [
        getEnvironmentServiceUUID(),
        getMotionServiceUUID()
    ]
}
