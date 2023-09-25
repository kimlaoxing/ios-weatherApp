import UIKit

final class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(with data: ListCity) {
        self.cityNameLabel.text = data.city
        self.countyNameLabel.text = data.country
    }
    
}
