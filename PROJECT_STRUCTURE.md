# Fashion App — Clean Architecture Project Structure

## Purpose

This document defines the target structure for `nammeyyy/fashion-app`. It preserves the original product concept while separating Flutter UI, application state, business rules, and Firebase access so each part can be developed and tested independently.

The target feature set remains:

- Home: Outfit of the Day and daily lucky-color guidance
- Discover: keyword search with relevant fashion posts and images
- Shop: products grouped by clothes, bags, accessories, gender, and style
- Profile: account settings, saved posts, interests, and purchase history
- Social: user posts, likes, saves, comments, and shop links
- Communities: membership, community feeds, ratings, and reviews

## Architecture Rules

The app uses feature-first Clean Architecture with three layers inside each feature:

1. `presentation` renders widgets and owns view state.
2. `domain` defines entities, repository contracts, and use cases without Flutter or Firebase imports.
3. `data` implements repository contracts and communicates with Firebase.

Dependencies point inward:

```text
presentation → domain ← data → Firebase SDK
```

Additional rules:

- Widgets do not call `FirebaseAuth`, `FirebaseFirestore`, or `FirebaseStorage` directly.
- View models/controllers depend on domain repository interfaces, not concrete Firebase classes.
- Repository implementations are the source of truth for application data.
- Domain entities are immutable and use consistent field names.
- UI state explicitly represents initial, loading, success, empty, and error states.
- Cross-feature widgets belong in `core/`; feature-specific widgets stay inside their feature.
- A use case is introduced only when it represents a meaningful business action or combines repositories.
- Files and directories use `lowercase_with_underscores`.

## Target Directory Tree

```text
lib/
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── navigation/
│   │   ├── app_router.dart
│   │   ├── app_routes.dart
│   │   └── navigation_shell.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_spacing.dart
│       ├── app_theme.dart
│       └── app_typography.dart
│
├── core/
│   ├── errors/
│   │   ├── app_exception.dart
│   │   └── failure.dart
│   ├── result/
│   │   └── result.dart
│   ├── services/
│   │   ├── image_upload_service.dart
│   │   └── link_launcher_service.dart
│   ├── utils/
│   │   ├── debouncer.dart
│   │   └── validators.dart
│   └── widgets/
│       ├── app_empty_state.dart
│       ├── app_error_state.dart
│       ├── app_loading_indicator.dart
│       ├── async_value_view.dart
│       └── network_image_view.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/firebase_auth_data_source.dart
│   │   │   └── repositories/auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/auth_session.dart
│   │   │   ├── repositories/auth_repository.dart
│   │   │   └── use_cases/
│   │   │       ├── sign_in.dart
│   │   │       ├── sign_out.dart
│   │   │       └── sign_up.dart
│   │   └── presentation/
│   │       ├── controllers/auth_controller.dart
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   ├── register_screen.dart
│   │       │   └── welcome_screen.dart
│   │       └── widgets/
│   │
│   ├── home/
│   │   ├── data/
│   │   │   ├── datasources/home_firestore_data_source.dart
│   │   │   ├── models/outfit_dto.dart
│   │   │   └── repositories/home_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── lucky_color.dart
│   │   │   │   └── outfit.dart
│   │   │   ├── repositories/home_repository.dart
│   │   │   └── use_cases/get_daily_home_content.dart
│   │   └── presentation/
│   │       ├── controllers/home_controller.dart
│   │       ├── screens/home_screen.dart
│   │       └── widgets/
│   │           ├── lucky_color_card.dart
│   │           └── outfit_card.dart
│   │
│   ├── discover/
│   │   ├── data/
│   │   │   ├── datasources/search_firestore_data_source.dart
│   │   │   └── repositories/search_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/search_result.dart
│   │   │   ├── repositories/search_repository.dart
│   │   │   └── use_cases/search_fashion_content.dart
│   │   └── presentation/
│   │       ├── controllers/search_controller.dart
│   │       ├── screens/search_screen.dart
│   │       └── widgets/search_result_card.dart
│   │
│   ├── shop/
│   │   ├── data/
│   │   │   ├── datasources/product_firestore_data_source.dart
│   │   │   ├── models/product_dto.dart
│   │   │   └── repositories/product_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── product.dart
│   │   │   │   └── product_filter.dart
│   │   │   ├── repositories/product_repository.dart
│   │   │   └── use_cases/
│   │   │       ├── get_product.dart
│   │   │       └── watch_products.dart
│   │   └── presentation/
│   │       ├── controllers/shop_controller.dart
│   │       ├── screens/
│   │       │   ├── product_detail_screen.dart
│   │       │   └── shop_screen.dart
│   │       └── widgets/
│   │           ├── product_card.dart
│   │           └── product_filter_bar.dart
│   │
│   ├── profile/
│   │   ├── data/
│   │   │   ├── datasources/profile_firestore_data_source.dart
│   │   │   ├── models/app_user_dto.dart
│   │   │   └── repositories/profile_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── app_user.dart
│   │   │   │   └── user_interest.dart
│   │   │   ├── repositories/profile_repository.dart
│   │   │   └── use_cases/update_profile.dart
│   │   └── presentation/
│   │       ├── controllers/profile_controller.dart
│   │       ├── screens/
│   │       │   ├── edit_profile_screen.dart
│   │       │   ├── profile_screen.dart
│   │       │   └── saved_items_screen.dart
│   │       └── widgets/
│   │
│   ├── orders/
│   │   ├── data/
│   │   │   ├── datasources/order_firestore_data_source.dart
│   │   │   └── repositories/order_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── order.dart
│   │   │   │   └── order_item.dart
│   │   │   └── repositories/order_repository.dart
│   │   └── presentation/
│   │       ├── controllers/order_history_controller.dart
│   │       └── screens/order_history_screen.dart
│   │
│   ├── social/
│   │   ├── data/
│   │   │   ├── datasources/post_firestore_data_source.dart
│   │   │   └── repositories/post_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── comment.dart
│   │   │   │   └── post.dart
│   │   │   └── repositories/post_repository.dart
│   │   └── presentation/
│   │       ├── controllers/feed_controller.dart
│   │       ├── screens/
│   │       │   ├── create_post_screen.dart
│   │       │   ├── feed_screen.dart
│   │       │   └── post_detail_screen.dart
│   │       └── widgets/post_card.dart
│   │
│   └── communities/
│       ├── data/
│       │   ├── datasources/community_firestore_data_source.dart
│       │   └── repositories/community_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── community.dart
│       │   │   └── review.dart
│       │   └── repositories/community_repository.dart
│       └── presentation/
│           ├── controllers/community_controller.dart
│           ├── screens/
│           │   ├── communities_screen.dart
│           │   └── community_detail_screen.dart
│           └── widgets/review_card.dart
│
├── firebase_options.dart
└── main.dart

test/
├── core/
├── features/
│   ├── auth/
│   ├── home/
│   ├── discover/
│   ├── shop/
│   ├── profile/
│   ├── orders/
│   ├── social/
│   └── communities/
└── helpers/
    ├── fakes.dart
    └── pump_app.dart
```

Folders should be created only when they contain real code. Empty Clean Architecture boilerplate should not be committed.

## Main Navigation

The original three-tab navigation should evolve into five product areas:

| Tab | Feature | Purpose |
| --- | --- | --- |
| Home | `home` | Daily outfits, lucky color, and recommendations |
| Discover | `discover` | Search fashion posts, images, tags, and interests |
| Shop | `shop` | Browse categorized products and open shop links |
| Community | `social` + `communities` | Feed, posts, comments, groups, and reviews |
| Profile | `profile` + `orders` | Settings, saved items, interests, and order history |

`navigation_shell.dart` owns the bottom navigation. Individual screens do not manage the global tab index.

## Data Flow Example

Product browsing follows this path:

```text
ShopScreen
  → ShopController.watchProducts(filter)
  → ProductRepository.watchProducts(filter)
  → ProductRepositoryImpl
  → ProductFirestoreDataSource
  → Cloud Firestore
```

The result returns through the same layers as immutable `Product` entities and a typed UI state. `ShopScreen` only renders that state.

## Firebase Data Boundaries

Use consistent lowercase collection and field names:

```text
users/{user_id}
products/{product_id}
outfits/{outfit_id}
posts/{post_id}
posts/{post_id}/comments/{comment_id}
communities/{community_id}
communities/{community_id}/members/{user_id}
communities/{community_id}/reviews/{review_id}
users/{user_id}/saved_items/{item_id}
users/{user_id}/interests/{interest_id}
users/{user_id}/orders/{order_id}
```

Do not mix `Product` and `products`, or fields such as `Product Name`, `product name`, and `productName`. Choose one schema and map Firebase documents through DTOs before creating domain entities.

## State Management and Dependency Injection

Use Riverpod to provide repositories and controllers while keeping the domain layer independent of Riverpod:

```text
Firebase data source provider
  → repository implementation provider
  → controller provider
  → screen watches controller state
```

Repository contracts and entities remain plain Dart. This allows repository fakes to replace Firebase implementations in tests.

## Current-to-Target Migration Map

| Current location | Target location |
| --- | --- |
| `main.dart` app setup | `app/bootstrap.dart`, `app/app.dart`, and minimal `main.dart` |
| `bottom_nav/bottom_navBar.dart` | `app/navigation/navigation_shell.dart` |
| `components/AppBar.dart` | `core/widgets/app_bar.dart` |
| `components/customAppbar.dart` | Feature widget or `core/widgets/custom_app_bar.dart` |
| `controllers/register_controller.dart` | `features/auth/presentation/controllers/auth_controller.dart` |
| `controllers/addProduct_controller.dart` | `features/shop/presentation/controllers/shop_controller.dart` |
| `model/user.dart` | `features/profile/domain/entities/app_user.dart` |
| `model/product.dart` | `features/shop/domain/entities/product.dart` |
| `service/Auth.dart` | Auth data source, repository contract, and implementation |
| `service/database_user.dart` | Profile data source and repository implementation |
| `service/database_product.dart` | Shop data source and repository implementation |
| `pages/home_page.dart` | `features/home/presentation/screens/home_screen.dart` |
| `pages/search_page.dart` | `features/discover/presentation/screens/search_screen.dart` |
| `pages/cart_page.dart` | `features/shop/presentation/screens/shop_screen.dart` |
| `pages/product_detail.dart` | `features/shop/presentation/screens/product_detail_screen.dart` |
| `pages/account_page.dart` | `features/profile/presentation/screens/profile_screen.dart` |
| `pages/favorite_page.dart` | `features/profile/presentation/screens/saved_items_screen.dart` |
| `pages/purchase_history_page.dart` | `features/orders/presentation/screens/order_history_screen.dart` |
| Login, register, welcome pages | `features/auth/presentation/screens/` |
| `camera_page.dart` | Feature-local media picker used by Social or Profile |
| `camera_pagr.dart` | Remove after confirming it duplicates `camera_page.dart` |

## Incremental Refactor Order

1. Add `app/`, `core/`, and navigation without changing visible behavior.
2. Create immutable `AppUser` and `Product` entities and normalize Firestore field names.
3. Extract Firebase calls into data sources and repository implementations.
4. Introduce repository contracts and dependency injection.
5. Migrate Auth, then Shop, because other features depend on the signed-in user and products.
6. Migrate Home and replace hard-coded daily content with repository-backed data.
7. Migrate Search and replace mock results with repository-backed results.
8. Implement Profile, saved interests, and purchase history.
9. Add Social posts, likes, saves, comments, and shop links.
10. Add Communities, memberships, reviews, reporting, and moderation.
11. Remove the legacy `pages/`, `controllers/`, `model/`, and `service/` folders only after all imports and tests have migrated.

Each step should keep the app buildable. Do not perform one large folder move before repository and test boundaries exist.

## Verification Requirements

- `flutter format` produces no changes.
- `flutter analyze` reports no errors or warnings.
- Unit tests cover every repository, data mapper, controller, and non-trivial use case.
- Widget tests cover loading, populated, empty, and error states for each main screen.
- Integration tests cover authentication, search, product filtering, profile editing, saved items, posting, comments, and reviews.
- Firebase Emulator tests verify that users cannot modify another user's private profile, saved items, or orders.
- External shop links are validated before launching.
- All lists use pagination rather than unbounded Firestore reads.

## Naming Conventions

- Files and directories: `lowercase_with_underscores`
- Classes and enums: `UpperCamelCase`
- Variables, methods, and providers: `lowerCamelCase`
- Screens: `HomeScreen`, `ShopScreen`, `ProfileScreen`
- Controllers: `HomeController`, `ShopController`
- Repository contracts: `ProductRepository`
- Implementations: `ProductRepositoryImpl`
- Firebase adapters: `ProductFirestoreDataSource`
- Firestore collections and fields: consistent lowercase `snake_case`

This structure is the target architecture, not a requirement to generate every file immediately. It keeps the original fashion-lifestyle concept intact while providing clear boundaries for completing the missing features safely.
