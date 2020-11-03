// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import RxSwift

let triggers: Observable<Int> = Observable.merge(
    Observable.just(3),
    Observable.just(5).delay(.seconds(10), scheduler: MainScheduler.instance),
    Observable.just(6).delay(.seconds(13), scheduler: MainScheduler.instance)
)

triggers.debug("TRIGGER")
    .flatMapLatest { max -> Observable<Int> in
        guard max >= 0 else {
            return .empty()
        }

        return Observable.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { max - $0 - 1 }
            .startWith(max)
            .takeUntil(.inclusive, predicate: { $0 <= 0 })
    }
    .debug("COUNTDOWN")
    .subscribe()
