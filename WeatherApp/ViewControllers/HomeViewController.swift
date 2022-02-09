//
//  ViewController.swift
//  WeatherApp
//
//  Created by Panchami Shenoy on 01/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var seachBarTextField: UITextField!
    @IBOutlet weak private var locationCollectionView: UICollectionView!
    @IBOutlet weak private var searchBarView: UIView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        activityIndicator.startAnimating()
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        searchBarViewSetUp()
    }
    
    func searchBarViewSetUp() {
        //        let button = UIButton(type: .custom)
        //        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        //        button.frame = CGRect(x: seachBarTextField.frame.size.width - 30, y: 5, width: 20, height: 20)
        //        seachBarTextField.rightView = button
        // seachBarTextField.rightViewMode = .always
        searchBarView.layer.borderWidth = SearchBarBorderConstants.borderWidth.rawValue
        searchBarView.layer.borderColor = UIColor.white.cgColor
        searchBarView.layer.cornerRadius = SearchBarBorderConstants.borderRadius.rawValue
    }
    
    func getBackgroundImage(city: String)-> UIImage {
        switch city {
        case CityNames.mumbai.rawValue :
            return UIImage(named: ImageAssetName.bombay.rawValue) ?? UIImage()
        case CityNames.mangalore.rawValue :
            return UIImage(named: ImageAssetName.mangalore.rawValue) ?? UIImage()
        case CityNames.bangalore.rawValue :
            return UIImage(named: ImageAssetName.bangalore.rawValue) ?? UIImage()
        case CityNames.delhi.rawValue :
            return UIImage(named: ImageAssetName.delhi.rawValue) ?? UIImage()
        default:
            return UIImage()
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        guard let seachBarText = seachBarTextField.text else {
            return
        }
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: VcIdentifier.weatherDetailVC.rawValue) as? WeatherDetailViewController
        vc?.city = seachBarText
        guard let viewController = vc else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: UICollection view delegate and data source methods
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.locationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.locationCell.rawValue, for: indexPath) as? LocationCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.cityName.text = viewModel.locationList[indexPath.row].name
        cell.cityTime.text = getTimeInHrMin(timeZone:viewModel.locationList[indexPath.row].timezone)
        cell.cityTemp.text = "\(fahrenheitToCelsius(temperature: viewModel.locationList[indexPath.row].main.temp))\(UnicodeConstants.degree.rawValue)"
        cell.cityWeeather.text = viewModel.locationList[indexPath.row].weather[0].main
        cell.cityWeatherIcon.image = getWeatherConditionIcon(weather:"\(viewModel.locationList[indexPath.row].weather[0].main)")
        cell.backgroundImage.image = getBackgroundImage(city: viewModel.locationList[indexPath.row].name)
        cell.contentView.layer.cornerRadius = CollectionViewSizeConstants.cornerRadius.rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-CollectionViewSizeConstants.allignmentSpacing.rawValue )/2
        return CGSize(width: size , height: CollectionViewSizeConstants.height.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewSizeConstants.interItemSpacing.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: VcIdentifier.weatherDetailVC.rawValue) as? WeatherDetailViewController
        vc?.city = viewModel.locationList[indexPath.row].name
        guard let viewController = vc else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: Api call
extension HomeViewController{
    
    func fillData() {
        let dispatchGroup = DispatchGroup()
        viewModel.cityList.forEach { city in
            dispatchGroup.enter()
            viewModel.fetchData(city:city,completionHandler:{ error in
                if let error = error {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main,execute: { [weak self] in
            self?.locationCollectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        })
        
    }
    
}
