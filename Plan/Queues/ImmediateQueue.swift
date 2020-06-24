final class ImmediateQueue: Queue {
    func execute(_ work: () -> Void) {
        work()
    }
}
