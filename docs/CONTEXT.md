# Developer Guide: Buyer Feature Implementation

## 1. Overview

This document outlines the architecture, data models, and feature flows for the "Buyer" side of the Yegna Gebeya application. The goal is to provide a clear roadmap for implementation, ensuring a consistent and scalable structure.

The core principle is **Separation of Concerns**. Functionalities are divided into distinct repositories, each with a single responsibility.

- **`AuthRepository`**: Handles user authentication (Sign Up/Login).
- **`ProductRepository`**: Handles fetching product information.
- **`CartRepository`**: Manages the user's shopping cart.
- **`OrderRepository`**: Manages the creation of permanent order records.

## 2. Core Data Models

These models are the data blueprints for the application and should be located in `lib/core/models/`.

### 2.1. `Buyer` Model

Represents a user's profile information.

- **`id` (String)**: The user's `uid` from Firebase Auth. Primary Key.
- **`email` (String)**: User's email.
- **`fullName` (String)**: User's full name.

### 2.2. `Product` Model

Represents an item available for sale.

- **`id` (String)**: Unique product ID.
- **`name` (String)**: Product name.
- **`price` (double)**: Product price.
- **`sellerId` (String)**: ID of the user who is selling the product.

### 2.3. `Cart` & `CartItem` Models

Represents the user's temporary shopping cart.

- **`Cart`**: Contains the `userId` and a `List<CartItem>`.
- **`CartItem`**: Contains the `Product` and the desired `quantity`.

### 2.4. `Order` & `OrderItem` Models

Represents a permanent record of a completed purchase.

- **`Order`**: Contains a unique `orderId`, `userId`, `totalAmount`, `orderDate`, and a `List<OrderItem>`.
- **`OrderItem`**: A snapshot of the product and price at the time of purchase.

## 3. Feature Flow & Implementation Guide

This section details the step-by-step flow for each buyer-facing feature.

### 3.1. Flow 1: User Authentication & Profile Creation

**Goal:** A new user signs up, is authenticated, and a corresponding user profile is created in the database.

1.  **UI**: The user enters their email, password, and full name on the `SignUpPage`.
2.  **Presentation Layer (`AuthCubit`)**: The UI calls the `signUp()` method in the `AuthCubit`.
3.  **Domain/Data Layer (`AuthRepository`)**:
    - The `AuthCubit` calls `authRepository.signUpWithEmailAndPassword()`.
    - This method interacts with **Firebase Auth** to create a new user.
4.  **Profile Creation**:
    - Upon successful authentication, Firebase returns a `UserCredential` containing the new user's `uid`.
    - The `AuthCubit` (or a dedicated `BuyerProfileCubit`) must then create a new document in the **Firestore `buyers` collection**.
    - The **Document ID** for this new document **must be the `uid`** from Firebase Auth.
    - The document will contain the user's `email`, `fullName`, and a `createdAt` timestamp.

**Database Interaction:**

- **CREATE**: A new document at `/buyers/{userId}`.

### 3.2. Flow 2: Viewing Products

**Goal:** A logged-in buyer can see a list of all available products or view the details of a single product.

1.  **UI**: The user navigates to a `ProductsListPage` or a `ProductDetailPage`.
2.  **Presentation Layer (`ProductCubit`)**:
    - To get all products, the UI calls `productCubit.fetchProducts()`.
    - To get one product, the UI calls `productCubit.fetchProductById(productId)`.
3.  **Domain/Data Layer (`ProductRepository`)**:
    - The cubit calls the corresponding method in the `ProductRepository` (`getProducts()` or `getProductById()`).
    - The repository implementation queries the **Firestore `products` collection** to fetch the required data.
    - The fetched data is mapped to `Product` model objects and returned to the UI for display.

**Database Interaction:**

- **READ**: From the `/products/` collection.

### 3.3. Flow 3: Managing the Shopping Cart

**Goal:** A buyer can add products to their cart, view the cart's contents, and remove items.

1.  **Adding an Item**:

    - **UI**: On a `ProductDetailPage`, the user taps an "Add to Cart" button.
    - **Presentation Layer (`CartCubit`)**: The UI calls `cartCubit.addProduct(productId, quantity)`.
    - **Domain/Data Layer (`CartRepository`)**: The cubit calls `cartRepository.addProductToCart()`. This implementation creates or updates a document in the user's cart sub-collection in Firestore.

2.  **Viewing the Cart**:

    - **UI**: The user navigates to the `CartPage`.
    - **Presentation Layer (`CartCubit`)**: The UI calls `cartCubit.fetchCart()`.
    - **Domain/Data Layer (`CartRepository`)**: The cubit calls `cartRepository.getCart()`. This fetches all documents from the user's cart sub-collection.

3.  **Removing an Item**:
    - **UI**: On the `CartPage`, the user taps a "Remove" button next to a `CartItem`.
    - **Presentation Layer (`CartCubit`)**: The UI calls `cartCubit.removeProduct(productId)`.
    - **Domain/Data Layer (`CartRepository`)**: The cubit calls `cartRepository.removeProductFromCart()`. This deletes the corresponding document from the user's cart sub-collection.

**Database Interaction:**

- **CREATE/UPDATE/DELETE/READ**: On the `/buyers/{userId}/cart/` sub-collection.

### 3.4. Flow 4: Purchasing Products

**Goal:** A buyer can finalize their purchase, which creates a permanent order record and clears their cart.

1.  **UI**: On the `CartPage` or a `CheckoutPage`, the user taps the "Purchase" button.
2.  **Presentation Layer (`OrderCubit`)**: The UI calls `orderCubit.createOrder()`.
3.  **Domain/Data Layer (`OrderRepository`)**:
    - The cubit calls `orderRepository.purchaseProducts()`.
    - This is a critical, multi-step process:
      a. **Fetch the current cart**: The repository first gets all items from the `/buyers/{userId}/cart/` sub-collection.
      b. **Create an Order Document**: It then creates a **new document** in the top-level `/orders/` collection. This document contains a snapshot of the buyer's ID, the total price, the current date, and a list of all items purchased.
      c. **Clear the Cart**: After the order is successfully created, the repository must **delete all documents** from the `/buyers/{userId}/cart/` sub-collection. This should be done in a batch operation for efficiency.
4.  **UI Feedback**: The UI listens for a success state from the `OrderCubit` and navigates to an "Order Successful" page, showing the new order details.

**Database Interaction:**

- **READ**: From `/buyers/{userId}/cart/`.
- **CREATE**: A new document in `/orders/`.
- **DELETE**: All documents from `/buyers/{userId}/cart/`.

Optimal Folder Structure
A scalable, maintainable buyer feature should use a structure like:

lib/
├── core/
│ └── models/
│ ├── buyer.dart
│ ├── product.dart
│ ├── cart.dart
│ └── order.dart
│
└── features/
└── buyer/
├── data/
│ └── repositories/
│ ├── product_repository_impl.dart
│ ├── cart_repository_impl.dart
│ └── order_repository_impl.dart
│
└── domain/
└── repositories/
├── product_repository.dart
├── cart_repository.dart
└── order_repository.dart
