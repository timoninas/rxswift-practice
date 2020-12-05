import Foundation
import RxSwift

func example(_ rxOperator: String, action: () -> ()) {
    print("\n----- Example of: \(rxOperator) -----")
    action()
}

private func main() {
    
    example("Interval") {
        let db = DisposeBag()

        let intObservable = Observable<Int>.interval(10, scheduler: MainScheduler.instance)
            .debug("interval")
            .subscribe {
                print($0)
            }
            .disposed(by: db)
    }
    
    example("From") {
        let observable = Observable<Int>.from([1, 2, 3, 4, 5])
            .subscribe {
                print($0)
            }
    }
    
    example("Timer") {
        let db = DisposeBag()
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
            .debug("timer")
            .subscribe {
                print($0)
            }
            .disposed(by: db)
    }
    
    example("Filter") {
        let observable = Observable<Int>.from([1, 2, 3, 4, 10, 20, 30, 40])
            .filter { $0 > 10 }
            .subscribe { print($0) }
    }
    
    example("Merge") {
        let observable1 = Observable<Int>.from([1, 2, 3, 4])
        let observable2 = Observable<Int>.from([10, 20, 30])
        let bothObservables = Observable<Int>.merge(observable1, observable2).subscribe {
            print($0)
        }
    }
    
    example("just") {
        // Observable
        let observable = Observable.just("Hello: RxSwift!")

        // Observer
        observable.subscribe { (event: Event<String>) in
            print(event)
        }
    }
}

main()
