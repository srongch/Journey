//
//  CarListViewController.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit
import Moya

class CarListViewController: UIViewController {

    
    @IBOutlet weak var carListCollectionView: UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var mapView: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var poolingButton: UIButton!
    
    fileprivate var viewModel: CarListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupViewModel()
    }
    
    func setupCollectionView(){
        
        self.carListCollectionView.dataSource = self
        self.carListCollectionView.delegate = self
        self.carListCollectionView.register(UINib(nibName: "CarListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarListCollectionViewCell")
        self.carListCollectionView.backgroundColor = UIColor.clear
        self.carListCollectionView.backgroundView = UIView.init(frame: CGRect.zero)

        self.taxiButton.setSelected(otherButtons: [self.poolingButton,self.taxiButton])
        
    }
    
    func setupViewModel(){
        // Map point : Derby University Area
        viewModel = CarListViewModel (carNetwork : JourneyNetwork(provider: MoyaProvider<Journey>()), mapBound: MapBound(latitude1: 52.926763991689398, longtitute1: -1.5066267848297628, latitude2: 52.948619248797378, longtitute2: -1.4898712151701829), filterType: .all)
        viewModel.delegate = self
        
        self.cityLabel.text = viewModel.mainLocation.city
        self.countryLabel.text = viewModel.mainLocation.country
        
        viewModel.fectch()
    }

    
   //  MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        if segue.identifier == "toMapView" {
            if let viewController = segue.destination as? MapViewController {
                
                let mapNetwork = MapNetwork(mapNetWork:JourneyNetwork(provider: MoyaProvider<Journey>()) )
                let mapModel = MapViewModelObj.init(mapNetWork: mapNetwork)
                viewController.viewModelObj(mapModel)
            }
        }
    }
    
    
    @IBAction func allPressed(_ sender: Any) {
        self.viewModel.changeFilter(filterType: .all)
        allButton.setSelected(otherButtons: [self.poolingButton,self.taxiButton])
    }
    @IBAction func taxiPressed(_ sender: Any) {
         self.viewModel.changeFilter(filterType: .taxi)
        taxiButton.setSelected(otherButtons: [self.allButton,self.poolingButton])
    }
    @IBAction func poolingPressed(_ sender: Any) {
         self.viewModel.changeFilter(filterType: .pooling)
        poolingButton.setSelected(otherButtons: [self.allButton,self.taxiButton])
    }
    

}

extension CarListViewController : LoadingProtocol{
    func error(error: String) {
        //TODO:
    }
    
    func refresh() {
        self.carListCollectionView.reloadData()
    }
    
    
}

extension CarListViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(for: section)}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarListCollectionViewCell = self.carListCollectionView.dequeueReusableCell(withReuseIdentifier: "CarListCollectionViewCell", for: indexPath) as! CarListCollectionViewCell
        
        cell.setupCell(for: self.viewModel.cellViewModel(for: indexPath))
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      return viewModel.collectionViewSizeForItem(with: self.view.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.viewModel.collectionViewInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.collectionViewInsets.left + 5
    }
    
    
}
