//
//  MapKit+GoogleStyle.swift
//  Pods
//
//  Created by Fernando on 1/2/17.
//
//

import UIKit
import MapKit

public enum MapKitGoogleStylerError: Error {
    case invalidJSONFormat
}

public struct MapKitGoogleStyler {
    public static func buildOverlay<T: MKTileOverlay>(with jsonArray: [[String: Any]]) -> T {
        let mapStyle = MapStyle(json: jsonArray)
        let overlay = T(urlTemplate: mapStyle.urlString)
        overlay.canReplaceMapContent = true
        return overlay
    }
     
    public static func buildOverlay<T: MKTileOverlay>(with jsonFileURL: URL) throws -> T {
        let data = try Data(contentsOf: jsonFileURL)
        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let array = object as? [[String: Any]] {
            return MapKitGoogleStyler.buildOverlay(with: array)
        } else {
            throw MapKitGoogleStylerError.invalidJSONFormat
        }
    }
}
