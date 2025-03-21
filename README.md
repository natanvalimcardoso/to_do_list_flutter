lib/
 ├── app/
 │    └── modules/
 │         └── to_do/
 │              ├── data/
 │              │     ├── external/
 │              │     │     └── datasources/
 │              │     │          ├── local/
 │              │     │          └── remote/
 │              │     │
 │              │     └── infra/
 │              │           ├── datasources/
 │              │           │     ├── local/
 │              │           │     └── remote/
 │              │           ├── models/
 │              │           └── repositories/
 │              │
 │              ├── domain/
 │              │     ├── entities/
 │              │     ├── repositories/
 │              │     └── usecases/
 │              │
 │              └── presentation/
 │                    ├── bloc/
 │                    ├── controller/
 │                    ├── pages/
 │                    │     └── to_do_page.dart
 │                    └── widgets/
 │              
 │              ├── app_module.dart
 │              └── app_widget.dart
 │
 ├── core/
 │    ├── constants/
 │    ├── errors/
 │    ├── network/
 │    │     ├── api_endpoint.dart
 │    │     └── dio_network.dart
 │    ├── themes/
 │    │     ├── theme_color.dart
 │    │     └── theme_font.dart
 │    └── utils/
 │          ├── validations/
 |          └── extensions/ 
 └── main.dart