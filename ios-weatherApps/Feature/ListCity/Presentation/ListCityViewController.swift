import UIKit

final class ListCityViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var fullCityList: [ListCity] = []
    private var filteredCityList: [ListCity] = []
    var viewModel: ListCityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.viewModel?.getListCity()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func bind() {
        self.viewModel?.listCity.observe(on: self, observerBlock: { [weak self] data in
            guard let self = self else { return }
            print("your data is \(data)")
            self.fullCityList = data
            self.filteredCityList = data
            self.tableView.reloadData()
        })
    }
    
    private func configureView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = true
        self.tableView.backgroundColor = .white
        self.tableView.register(
            UINib(nibName: "CityTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CityTableViewCell"
        )
        self.searchBar.delegate = self
    }
}

extension ListCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return filteredCityList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityTableViewCell",
            for: indexPath
        ) as! CityTableViewCell
        
        let city = filteredCityList[indexPath.row]
        cell.setContent(with: city)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedCity = filteredCityList[indexPath.row]
        let lat = Double(selectedCity.lat) ?? 0
        let long = Double(selectedCity.long) ?? 0
        DispatchQueue.main.async {
            self.viewModel?.saveSelectedCity(with: lat, lon: long, { bool in
                if bool {
                    self.viewModel?.delegate?.didSelectCity()
                    self.dismiss(animated: true)
                }
            })
        }  
    }
    
}

extension ListCityViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        if searchText.isEmpty {
            filteredCityList = fullCityList
        } else {
            filteredCityList = fullCityList.filter { city in
                return city.city.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
