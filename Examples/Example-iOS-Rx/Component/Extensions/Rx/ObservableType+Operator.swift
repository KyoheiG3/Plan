import RxSwift

public extension ObservableType {
    func map<V>(value: V) -> Observable<V> {
        map { _ in value }
    }
}
