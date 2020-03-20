import 'dart:ffi';

abstract class Disposable {
  void dispose();
}

class DisposableBag implements Disposable {
  final _disposables = <Disposable>[];

  void add(Disposable disposable) => _disposables.add(disposable);

  @override
  void dispose() {
    _disposables.reversed.forEach((el) => el.dispose());
    _disposables.clear();
  }
}

typedef Finalizer<T extends NativeType> = void Function(Pointer<T>);

class DisposablePointer<T extends NativeType> implements Disposable {
  final Pointer<T> pointer;
  final Finalizer<T> finalizer;

  const DisposablePointer(this.pointer, this.finalizer);

  @override
  void dispose() {
    finalizer(pointer);
  }
}

extension Use<R, T extends Disposable> on T {
  R use(R Function(T) user) {
    try {
      return user(this);
    } finally {
      dispose();
    }
  }
}

extension WithBag<T extends Disposable> on T {
  T withBag(DisposableBag bag) {
    bag.add(this);
    return this;
  }
}

extension PointerWithBag<T extends NativeType> on Pointer<T> {
  Pointer<T> withBag(DisposableBag bag, Finalizer<T> finalizer) {
    bag.add(DisposablePointer(this, finalizer));
    return this;
  }
}

extension UsePointer<R, T extends NativeType> on Pointer<T> {
  R use(Finalizer<T> finalizer, R Function(Pointer<T>) scope) =>
      DisposablePointer(this, finalizer).use((ptr) => scope(ptr.pointer));
}

T useBag<T>(T Function(DisposableBag) scope) => DisposableBag().use(scope);
