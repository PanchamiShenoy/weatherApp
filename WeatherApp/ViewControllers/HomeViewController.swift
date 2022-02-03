//
//  ViewController.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 01/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    let cityList = [cityNames.bangalore.rawValue,cityNames.mangalore.rawValue,cityNames.delhi.rawValue,cityNames.mumbai.rawValue]
    var viewModel = HomeViewModel()
    var dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var seachBarTextField: UITextField!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var searchBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        searchBarViewSetUp()
    }
    
    func searchBarViewSetUp() {
        searchBarView.layer.borderWidth = 0.5
        searchBarView.layer.borderColor = UIColor.white.cgColor
        searchBarView.layer.cornerRadius = 30
    }
    
    func getIconImage(weather:String)->UIImage {
        switch weather {
        case weatherCondition.smoke.rawValue :
            return UIImage(systemName: imageSystemName.smoke.rawValue)!
        case weatherCondition.clouds.rawValue :
            return UIImage(systemName: imageSystemName.cloud.rawValue)!
        case weatherCondition.clear.rawValue :
            return UIImage(systemName: imageSystemName.clear.rawValue)!
        case weatherCondition.haze.rawValue :
            return UIImage(systemName: imageSystemName.haze.rawValue)!
        default:
            return UIImage(systemName: imageSystemName.smoke.rawValue)!
        }
        
    }
    
    func getBackgroundImage(city:String)->UIImage {
        switch city {
        case cityNames.mumbai.rawValue :
            return UIImage(named: imageAssetName.bombay.rawValue)!
        case cityNames.mangalore.rawValue :
            return UIImage(named: imageAssetName.mangalore.rawValue)!
        case cityNames.bangalore.rawValue :
            return UIImage(named: imageAssetName.bangalore.rawValue)!
        case cityNames.delhi.rawValue :
            return UIImage(named: imageAssetName.delhi.rawValue)!
        default:
            return UIImage(named: imageAssetName.delhi.rawValue)!
        }
    }
    func getTimeInHrMin(interval:Int)->String{
//       let interval2 = interval/1000
//        let timeInterval = Double(interval2)
//        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        //print(myNSDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.timeZone = TimeZone(secondsFromGMT: interval)
        let dateString = formatter.string(from: Date())
        return dateString
    }

    @IBAction func onSearch(_ sender: Any) {
        guard let seachBarText = seachBarTextField.text else {
            return
        }
    }
}

//MARK: UICollection view delegate and data source methods
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.locationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.locationCell.rawValue, for: indexPath) as! LocationCollectionViewCell
        cell.cityName.text = viewModel.locationList[indexPath.row].name
        cell.cityTime.text = getTimeInHrMin(interval:viewModel.locationList[indexPath.row].timezone)
        cell.cityTemp.text = "\(viewModel.locationList[indexPath.row].main.temp)"
        cell.cityWeeather.text = "\(viewModel.locationList[indexPath.row].weather[0].main)"
        cell.cityWeatherIcon.image = getIconImage(weather:"\(viewModel.locationList[indexPath.row].weather[0].main)")
        cell.backgroundImage.image = getBackgroundImage(city: viewModel.locationList[indexPath.row].name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-90)/2
        return CGSize(width: size, height: 200)
    }
}

//MARK: Api call
extension HomeViewController{
   
    func fillData() {
        for city in cityList{
            dispatchGroup.enter()
            viewModel.fetchData(city:city,completionHandler:{ [weak self]  in
                self!.dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main,execute: {
            self.locationCollectionView.reloadData()
        })
        
    }
   
    
}
