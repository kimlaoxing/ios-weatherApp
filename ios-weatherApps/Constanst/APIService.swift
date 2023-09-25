import Foundation

struct APIService {
    static let key = "c9e76ac196843eb24d32dd1838a7867d"
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(baseURLString)onecall?lat=\(lat)&lon=\(lon)&appid=\(key)"
    }
}
