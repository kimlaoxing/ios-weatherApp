import UIKit

final class LottieHelper {
    static func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatteredClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstrom"
        case "11n":
            return "nightThunderstrom"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayMist"
        case "50n":
            return "nightMist"
        default:
            return "dayClearSky"
        }
    }

    static func getWeatherIconFor(icon: String) -> UIImage {
        switch icon {
        case "01d":
            return UIImage(systemName: "sun.max.fill") ?? UIImage()
        case "01n":
            return UIImage(systemName: "moon.fill") ?? UIImage()
        case "02d":
            return UIImage(systemName: "cloud.sun.fill") ?? UIImage()
        case "02n":
            return UIImage(systemName: "cloud.moon.fill") ?? UIImage()
        case "03d":
            return UIImage(systemName: "cloud.fill") ?? UIImage()
        case "03n":
            return UIImage(systemName: "cloud.fill") ?? UIImage()
        case "04d":
            return UIImage(systemName: "cloud.fill") ?? UIImage()
        case "04n":
            return UIImage(systemName: "cloud.fill") ?? UIImage()
        case "09d":
            return UIImage(systemName: "cloud.drizzle.fill") ?? UIImage()
        case "09n":
            return UIImage(systemName: "cloud.drizzle.fill") ?? UIImage()
        case "10d":
            return UIImage(systemName: "cloud.heavyrain.fill") ?? UIImage()
        case "10n":
            return UIImage(systemName: "cloud.heavyrain.fill") ?? UIImage()
        case "11d":
            return UIImage(systemName: "cloud.bolt.fill") ?? UIImage()
        case "11n":
            return UIImage(systemName: "cloud.bolt..fill") ?? UIImage()
        case "13d":
            return UIImage(systemName: "cloud.snow.fill") ?? UIImage()
        case "13n":
            return UIImage(systemName: "cloud.snow.fill") ?? UIImage()
        case "50d":
            return UIImage(systemName: "cloud.fog.fill") ?? UIImage()
        case "50n":
            return UIImage(systemName: "cloud.fog.fill") ?? UIImage()
        default:
            return UIImage(systemName: "sun.max.fill") ?? UIImage()
        }
    }
}

