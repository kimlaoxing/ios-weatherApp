import UIKit

final class MainViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MainViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.bind()
        self.viewModel?.loadAllWeatherResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initRightBarButtonItem()
    }
    
    private func bind() {
        self.viewModel?.weatherResult.observe(on: self, observerBlock: { [weak self] data in
            self?.tableView.reloadData()
        })
    }
    
    private func configureTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.register(
            UINib(nibName: "CityWeatherTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CityWeatherTableViewCell"
        )
        self.tableView.delegate = self
        self.tableView.separatorColor = .black
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = false
    }
    
    private func initRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(presentListCity)
        )
    }
    
    @objc private func presentListCity() {
        self.viewModel?.presentListCity()
    }
    
}

extension MainViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        if let data = self.viewModel?.weatherResult.value[indexPath.row] {
            cell.setContent(with: data)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.viewModel?.weatherResult.value.count ?? 0
    }
    
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let lat = self.viewModel?.weatherResult.value[indexPath.row]?.lat ?? 0
        let lon = self.viewModel?.weatherResult.value[indexPath.row]?.lon ?? 0
        self.viewModel?.toDetailView(with: lat, lon: lon)
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            guard let resultToDelete = self.viewModel?.weatherResult.value[indexPath.row] else {
                return
            }
            
            self.viewModel?.deleteWeatherResult(for: resultToDelete.lat, lon: resultToDelete.lon)
            self.tableView.beginUpdates()
            self.viewModel?.weatherResult.value.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}

