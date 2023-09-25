import Foundation
import UIKit
import Declayout

final class DetailViewController: UIViewController {
    
    private lazy var header = DetailHeaderView()
    private lazy var collectionView = DefaultCollectionView(frame: .zero)
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.horizontalPadding(to: view)
        $0.top(to: view, Padding.double * 2)
        $0.bottom(to: view)
        $0.backgroundColor = .white
    }
    
    private lazy var dailyTableView = UITableView.make {
        $0.delegate = self
        $0.dataSource = self
        $0.register(
            UINib(
                nibName: "DailyTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "DailyTableViewCell"
        )
        $0.allowsMultipleSelectionDuringEditing = false
        $0.isScrollEnabled = false
    }
    
    private var dailyTableViewHeight: NSLayoutConstraint? {
        didSet { dailyTableViewHeight?.activated() }
    }
    
    private var collectionHeight: NSLayoutConstraint? {
        didSet { collectionHeight?.activated() }
    }
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCollectionView()
        subViews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dailyTableView.addObserver(
            self,
            forKeyPath: UITableView.contentSizeKeyPath,
            options: .new,
            context: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dailyTableView.removeObserver(
            self,
            forKeyPath: UITableView.contentSizeKeyPath,
            context: nil
        )
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if let newvalue = change?[.newKey], keyPath == UITableView.contentSizeKeyPath {
            let newsize  = newvalue as! CGSize
            
            self.dailyTableViewHeight?.constant = newsize.height
            self.scrollView.layoutIfNeeded()
        }
    }
    
    private func bind() {
        self.viewModel.weatherResult.observe(on: self) { [weak self] data in
            guard let self = self, let data = data else { return }
            self.header.setContent(with: data)
            self.collectionView.reloadData()
            self.dailyTableView.reloadData()
        }
    }
    
    private func subViews() {
        scrollView.addArrangedSubViews([
            header,
            collectionView,
            dailyTableView
        ])
    }
    
    private func configureTableView() {
        dailyTableViewHeight = dailyTableView.heightAnchor.constraint(equalToConstant: 1)
        dailyTableViewHeight?.priority = UILayoutPriority.init(999)
        dailyTableViewHeight?.isActive = true
    }
    
    private func configureCollectionView() {
        self.collectionView.register(
            UINib(
                nibName: "HourlyCollectionViewCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "HourlyCollectionViewCell"
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionHeight = collectionView.heightAnchor.constraint(equalToConstant: 91)
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        layout.scrollDirection = .horizontal
    }
    
    
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.viewModel.weatherResult.value?.daily.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DailyTableViewCell",
            for: indexPath
        ) as! DailyTableViewCell
        if let daily = self.viewModel.weatherResult.value?.daily {
            cell.setContent(with: daily[indexPath.row])
        }
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.viewModel.weatherResult.value?.hourly.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HourlyCollectionViewCell",
            for: indexPath
        ) as! HourlyCollectionViewCell
        guard let data = self.viewModel.weatherResult.value?.hourly[indexPath.row] else { return UICollectionViewCell() }
        cell.setContent(with: data)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return self.UICollectionViewFiveItemPerWidth()
    }
}

