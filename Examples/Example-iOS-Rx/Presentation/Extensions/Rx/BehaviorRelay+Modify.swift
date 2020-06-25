import RxRelay

extension BehaviorRelay {
    @discardableResult
    func modefy(block: (inout Element) -> Void) -> Element {
        var newValue = value
        block(&newValue)
        accept(newValue)
        return newValue
    }
}
