import RealmSwift

class WeatherResultObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var temp: Double
    @Persisted var city: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var icon: String
}
