# iFood Chalenge
This is the iFood challenge.
In this challenge I'm building an app using Pokemon API. This app has a bottom navigation with two tabs, a Pokémon List (with pagination) and the Caught Pokémon List (shows all caught pokémon).

## Libs, Architecture and tests

This project is built using these libs/architectures:
- [RxDart](https://pub.dev/packages/rxdart);
- [Provider](https://pub.dev/packages/provider);
- [Hive](https://pub.dev/packages/hive);
- [Dio](https://pub.dev/packages/dio);
- [Infinite Scroll Pagination](https://pub.dev/packages/infinite_scroll_pagination);
- [Mocktail](https://pub.dev/packages/mocktail/install);
- BLoC.

## How it's organized

This project is using Clean Arc, so it has layers. The two "main" layers are: domain and application.
The domain has all use cases and "contracts", while the application implements those contracts and creates all Pages, Navigation, etc.


## Missing features

- Widgets Tests;
- Integration Tests;
- More complex UI;
- Code revision.

