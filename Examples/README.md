# Plan Examples

## Overview

This example uses `Plan` framework to implement a clean architecture.

With the following structure, it is possible to reduce the dependency of the component and clear the scope of development and testing.

![Plan Example Structure](https://user-images.githubusercontent.com/5707132/91378757-30b49e00-e85c-11ea-9884-2bc5503b8e8e.png)


`Component` is composed of user interface related objects such as `UIView` and `UIViewController`.

By limiting the dependency of `Component` to `Boundary` (interface) and `Entity`, visual regression test, etc. can be easily executed.

## Structure

This project is structured 2 apps and 5 frameworks. All frameworks are divided into layers by role so that only the modules needed for the application are imported.

The application is divided into `Example.app` which is executed as a product and `Catalog.app` which is executed to test the UI. The product application imports all modules, but the test application imports only the `Component.framework`, `Boundary.framework`, and `Entity.framework` required for testing. By making UI components into independent modules, `Catalog` application can import and execute only the modules required for UI configuration.

`Boundary` consists of the interface of application logic and the object to execute processing (eg aggregate response etc).

## Projects

#### Example-iOS-RAC

It depends on `ReactiveSwift`.

#### Example-iOS-Rx

It depends on `RxSwift`.
