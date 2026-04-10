# CookOld

iOS-приложение для поиска и просмотра рецептов на базе [TheMealDB](https://www.themealdb.com/), с избранным и офлайн-кэшем изображений.

## Основные фичи

- **Главная фича - создание блюда по ингредиентам**: пользователь добавляет ингредиенты, а приложение подбирает блюда, в которых они встречаются.
- **Home**: подборка популярных и последних рецептов.
- **Search**: поиск по названию с debounce и каталог категорий.
- **Категории**: переход в категорию и локальный поиск внутри нее.
- **Detail**: детальная карточка блюда (ингредиенты, меры, инструкция).
- **Избранное**: добавление/удаление блюд и локальное хранение через SwiftData.
- **Кэш изображений**: memory + disk cache для более быстрого повторного открытия экранов.
- **Состояния UI**: loading / error / empty + `pull-to-refresh`.

## Технологии

- SwiftUI
- Observation (`@Observable`)
- Swift Concurrency (`async/await`)
- SwiftData
- DI-контейнер (`DIContainer`)
- XcodeGen + Mint

## Быстрый старт

### 1) Установка dev-зависимостей

```bash
brew install mint
mint bootstrap
```

### 2) Подключение git hooks

```bash
make hook
```

После этого используется путь `.githooks`, а при checkout/merge выполняется `make xcgen`.

### 3) Генерация и открытие проекта

```bash
make generate open
```

## Скриншоты

![Home](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.16.29.png)
![Search](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.16.40.png)
![Categories](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.16.50.png)
![Detail](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.17.19.png)
![Favorites](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.17.29.png)
![More UI](Screens/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.17.37.png)

![Screen Recording](Screens/Simulator%20Screen%20Recording%20-%20iPhone%2017%20Pro%20-%202026-04-10%20at%2010.05.11.gif)

## Структура проекта

- `Sources/Application` - entrypoint и DI.
- `Sources/Presentation` - SwiftUI экраны и UI-компоненты.
- `Sources/Domain` - доменные модели.
- `Sources/Data` - сеть, репозитории, кэш, persistence.
- `CulinarAppTests` / `CulinarAppUITests` - unit и UI тесты.
