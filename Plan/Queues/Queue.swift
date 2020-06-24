import Foundation

protocol Queue {
    func execute(_ work: @escaping () -> Void)
}

extension DispatchQueue: Queue {
    func execute(_ work: @escaping () -> Void) {
        async(execute: work)
    }
}
