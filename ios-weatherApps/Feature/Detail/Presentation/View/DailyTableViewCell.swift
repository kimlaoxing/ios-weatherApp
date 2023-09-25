import UIKit

final class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    private lazy var dayFormmater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private func getDayFor(timestamp:Int) -> String {
        return dayFormmater.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getTempFor(temp: Double) -> String {
        let tempInCelsius = temp - 273.15
        let clampedTempInCelsius = max(-100.0, min(100.0, tempInCelsius))
        return String(format: "%0.1f°C", clampedTempInCelsius)
    }

    func setContent(with data: Daily) {
        self.dayLabel.text = self.getDayFor(timestamp: data.dt ?? 0)
        self.minTempLabel.text = self.getTempFor(temp: data.temp?.min ?? 0)
        self.maxTempLabel.text = self.getTempFor(temp: data.temp?.max ?? 0)
        self.iconImageView.image = LottieHelper.getWeatherIconFor(icon: data.weather?.first?.icon ?? "01d")
    }
}
