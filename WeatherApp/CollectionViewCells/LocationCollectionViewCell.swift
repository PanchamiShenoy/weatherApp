//
//  LocationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 01/02/22.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityWeatherIcon: UIImageView!
    @IBOutlet weak var cityWeeather: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityTime: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
}
