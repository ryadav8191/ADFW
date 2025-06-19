//
//  CountryPickerViewController.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//


import UIKit

class CountryPickerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    @IBOutlet weak var chooseLabel: UILabel!
    
    

    var countries: [CountryAttributes] = []
    var filteredCountries: [CountryAttributes] = []
    var onCountrySelected: ((CountryAttributes) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        chooseLabel.font = FontManager.font(weight: .semiBold, size: 18)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        
        searchBar.delegate = self
        filteredCountries = countries
        // Make searchBar background transparent
        searchBar.backgroundColor = .clear
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.isTranslucent = true

        // Force corner radius of searchBar itself to 0
        searchBar.layer.cornerRadius = 0
        searchBar.layer.masksToBounds = false  // Optional: if masksToBounds causes visual issues

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(hex: "F0F2F5")
            
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayColor]
            )
            
            textField.textColor = .black
            textField.font = FontManager.font(weight: .semiBold, size: 14)
            
            // Remove search icon
            textField.leftView = nil
            textField.leftViewMode = .never

            // Force no corner radius on text field
            textField.layer.cornerRadius = 0
            textField.layer.masksToBounds = true
            
            // Also remove background image if any
            textField.borderStyle = .none
            
            // OPTIONAL: remove any shadow
            textField.layer.shadowOpacity = 0
            textField.layer.shadowRadius = 0
            textField.layer.shadowColor = nil
            textField.layer.shadowOffset = .zero
        }


    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CountryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let country = filteredCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCountrySelected?(filteredCountries[indexPath.row])
        dismiss(animated: true)
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                ($0.country ?? "").lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

