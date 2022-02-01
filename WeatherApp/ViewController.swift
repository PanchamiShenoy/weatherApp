//
//  ViewController.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 01/02/22.
//

import UIKit

class ViewController: UIViewController {

    var list =  [WeatherDetail]()
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        searchBarView.layer.borderWidth = 0.5
        searchBarView.layer.borderColor = UIColor.white.cgColor
        searchBarView.layer.cornerRadius = 30
        fillData()
    }

    func fillData(){
        let city1 = WeatherDetail(name: "mangalore", time: "12:00", temp: "4C", weather: "cold")
        list.append(city1)
        let city2 = WeatherDetail(name: "Bangalore", time: "12:00", temp: "4C", weather: "cold")
        list.append(city2)
        let city3 = WeatherDetail(name: "delhi", time: "12:00", temp: "4C", weather: "cold")
        list.append(city3)
        let city4 = WeatherDetail(name: "mumbai", time: "12:00", temp: "4C", weather: "cold")
        list.append(city4)
        print(list)
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as! LocationCollectionViewCell
        cell.cityName.text = list[indexPath.row].cityName
        cell.cityTime.text = list[indexPath.row].cityTime
        cell.cityTemp.text = list[indexPath.row].cityTemperature
        cell.cityWeeather.text = list[indexPath.row].cityWeather
        cell.cityWeatherIcon.image = UIImage(systemName: "cloud.drizzle")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-90)/2
        return CGSize(width: size, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
    }
}
