//
//  ViewController.swift
//  Company_Task_Releted_To_TableView_And_CollectionView
//
//  Created by Apple on 17/12/22.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {

//Mark :- Take connection Of CollectionView and TableView
    
    @IBOutlet var CollectionView: UICollectionView!
    @IBOutlet var TableView: UITableView!
    
    var apiResult = [ProductApiResponse]()
    var apiResultFromUserModel = [userApiResponse]()
    override func viewDidLoad() {
        super.viewDidLoad()
//Mark:- Calling Methods of collectionView
        RegisterNIBForCollectionView()
        getJsonDataForCollectionView()
        InitializeDatasourceAndDelegateForCollectionView()
        
//Mark:-Calling Methods of TableView
        RegisterNIBForTableView()
        getJsonDataForTableView(){
            self.TableView.reloadData()
        }
        InitializeDatasourceAndDelegateForTableView()
    }
    
//Mark:- CollectionView Methods
    func RegisterNIBForCollectionView(){
        let uinibForCollectionView = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.CollectionView.register(uinibForCollectionView, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func InitializeDatasourceAndDelegateForCollectionView(){
        CollectionView.dataSource = self
        CollectionView.delegate = self
    }
    
    func getJsonDataForCollectionView(){
        let urlString = "https://fakestoreapi.com/products"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = ("get")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){data,response,error in
            print(data!)
            print(error as Any)
            
            let getJsonData = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            
            guard data != nil else{
                print("Data not found")
                print("error\(String(describing: error))")
                return
            }
            for dictionary in getJsonData{
                let eachDict = dictionary 
                let img = eachDict["image"] as! String
                print(img)
                self.apiResult.append(ProductApiResponse(image: img))
            }
            DispatchQueue.main.async {
                self.CollectionView.reloadData()
            }
        }
        dataTask.resume()
    }
    
//Mark:- TableView Methods
    func RegisterNIBForTableView(){
        let uinib = UINib(nibName: "TableViewCell", bundle: nil)
        self.TableView.register(uinib, forCellReuseIdentifier: "TableViewCell")
    }
    
    func InitializeDatasourceAndDelegateForTableView(){
        TableView.dataSource = self
        TableView.delegate = self
    }
    
    func getJsonDataForTableView(completed : @escaping()->()){
        let urlString = "https://fakestoreapi.com/users"
        guard let url = URL(string: urlString) else{
            print("url not created")
            return
        }
        
        URLSession.shared.dataTask(with: url){data, response, error in
            if error == nil
            {
                do
                {
                    var jsonDecoder = JSONDecoder()
                    self.apiResultFromUserModel = try! jsonDecoder.decode([userApiResponse].self, from: data!)
                    
                }
                catch
                {
                    print("error")
                }
                DispatchQueue.main.async{
                    completed()
                }
            }
        }
        .resume()
    }
    
}

//Mark:- Extension For CollectionView To Conform Datasource And Delegate Protocol

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apiResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let img1 = NSURL(string: apiResult[indexPath.row].image)
        collectionViewCell.img.sd_setImage(with: img1 as URL?)
        return collectionViewCell
    }
    
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 170, height: 172)
    }
}


//Mark:- Extension For TableView To Conform Datasource And Delegate Protocol
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apiResultFromUserModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.TableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        tableViewCell.firstNameLabel.text = apiResultFromUserModel[indexPath.row].name.firstname
        tableViewCell.lastNameLabel.text = apiResultFromUserModel[indexPath.row].name.lastname
        
        tableViewCell.firstNameLabel.textColor = .red
        tableViewCell.lastNameLabel.textColor = .red
        return tableViewCell
    }
    
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}
