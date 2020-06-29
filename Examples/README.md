# Plan Examples

## Overview

This example uses `Plan` framework to implement a clean architecture.

With the following structure, it is possible to reduce the dependency of the component and clear the scope of development and testing.

![Plan Example Structure](https://user-images.githubusercontent.com/5707132/85881583-cdd16700-b818-11ea-916c-f1672cabbc81.png)


`Component` is composed of user interface related objects such as `UIView` and `UIViewController`.

By limiting the dependency of `Component` to `UseCase` (interface) and `Entity`, visual regression test, etc. can be easily executed.

## Structure

This project is structured 2 apps and 5 frameworks. All frameworks are divided into layers by role so that only the modules needed for the application are imported.

The application is divided into `Example.app` which is executed as a product and `Catalog.app` which is executed to test the UI. The product application imports all modules, but the test application imports only the `Component.framework`, `UseCase.framework`, and `Entity.framework` required for testing. By making UI components into independent modules, `Catalog` application can import and execute only the modules required for UI configuration.

`UseCase` consists of the interface of application logic and the object to execute processing (eg aggregate response etc).

`Repository` is implemented in Domain, but it may be independent as a framework.

## Projects

#### Example-iOS-RAC

It depends on `ReactiveSwift`.

#### Example-iOS-Rx

It depends on `RxSwift`.
