import UIKit

final class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(with data: Current) {
        self.hourLabel.text = self.getTimeFor(timestamp: data.dt ?? 0)
        self.tempLabel.text = self.getTempFor(temp: data.temp ?? 0)
        self.iconImageView.image = LottieHelper.getWeatherIconFor(icon: data.weather?.first?.icon ?? "01d")
    }
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    private func getTimeFor(timestamp:Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getTempFor(temp: Double) -> String {
        let tempInCelsius = temp - 273.15
        let clampedTempInCelsius = max(-100.0, min(100.0, tempInCelsius))
        return String(format: "%0.1f°C", clampedTempInCelsius)
    }
}
