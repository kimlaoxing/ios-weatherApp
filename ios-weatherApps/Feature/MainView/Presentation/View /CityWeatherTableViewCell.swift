import UIKit

final class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageCloud: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func getTempFor(temp: Double) -> String {
        let tempInCelsius = temp - 273.15
        let clampedTempInCelsius = max(-100.0, min(100.0, tempInCelsius))
        return String(format: "%0.1f°C", clampedTempInCelsius)
    }
    
    func setContent(with data: WeatherResult) {
        self.cityLabel.text = data.city
        self.imageCloud.image = LottieHelper.getWeatherIconFor(icon: data.icon)
        self.tempLabel.text = self.getTempFor(temp: data.temp)
    }

    
}
