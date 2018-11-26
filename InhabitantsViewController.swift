//
//  ViewController.swift
//  BrastlewarkGame
//
//  Created by Hector Hernandez on 11/22/18.
//  Copyright © 2018 Hector Hernandez. All rights reserved.
//


import UIKit

class InhabitantsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    var habitants = [Inhabitant]()
    var habitansFilter = [Inhabitant]()
    var selectInhabitant: Inhabitant!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpTableView()
        loadDataFromApi()
    }
    
    private func setUpTableView() {
        self.tableView.register(UINib(nibName:"InhabitanTableViewCell", bundle: nil), forCellReuseIdentifier: "customCellIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setUpSearchBar() {
        self.searchBar.delegate = self
    }


    private func loadDataFromApi(){
        let api = InhabitantManager()
  
        setErrorMessage(false)

        self.showActivityIndicator(true)

        self.tableView.isHidden = true

        api.getInhabits() { responseObject, error in
            if responseObject != nil && responseObject!.count > 0 {
                self.habitansFilter = responseObject as! [Inhabitant]
                self.habitants = responseObject as! [Inhabitant]
                self.tableView.reloadData()
                self.setErrorMessage(false)
                self.tableView.isHidden = false
            } else {
                self.setErrorMessage(true)
            }
            self.showActivityIndicator(false)
        }
    }


    func setErrorMessage(_ enabled: Bool){
        self.errorMessage.isHidden = !enabled
        self.reloadButton.isHidden = !enabled
    }

    func showActivityIndicator(_ enabled: Bool) {
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = !enabled
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.habitants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellIdentifier", for: indexPath) as! InhabitanTableViewCell
        
        let inha = self.habitants[indexPath.row]
        cell.name.text = inha.name
        cell.age.text = "Age: \(inha.age)"
        cell.friends.text = "Friends: \(inha.friends.count)"
        cell.professions.text = "Professions: \(inha.professions.count)"
        cell.iconImage.loadImageUsingCache(withUrl: inha.thumbnailUrl)
        cell.iconImage.setRounded()
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inhabitant = self.habitants[indexPath.row]
        self.selectInhabitant = inhabitant
        performSegue(withIdentifier: "InhabitanSegueIdentifer", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "InhabitanSegueIdentifer") {
            let viewController = segue.destination as! InhabitantDetailViewController
            viewController.inhabilant = self.selectInhabitant
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text! == "" {
            habitants = habitansFilter
        } else {
            habitants = habitansFilter.filter({ (inhabitant) -> Bool in
                return inhabitant.name.lowercased().contains(searchBar.text!.lowercased())
            })
        }
       tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }


    @IBAction func reloadData(_ sender: Any) {
        loadDataFromApi()
    }
}

