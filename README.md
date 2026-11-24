<div align="center">

<img src="assets/images/Logoamigo.jpeg" alt="Amigo logo" width="140" />

# Amigo: Flavours of Your Choice

**Campus food ordering without the queue.** A student app, a vendor app and a university admin portal, built in Flutter on Firebase.

[**▶ Try the interactive demo**](https://dakshvasudev.vercel.app/project/amigo)

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Cloud Firestore](https://img.shields.io/badge/Cloud_Firestore-FF6F00?logo=firebase&logoColor=white)

</div>

---

## The problem

Between classes, students had about ten minutes to eat. Campus stalls took orders on paper, queues ran long, and the university had no view of how its food court was doing: which stalls were slow, which were busy, what students thought of them.

## The solution

Amigo connects the three groups on one real-time backend:

| App | Who uses it | What it does |
|---|---|---|
| **Student app** (this repo) | Students | Browse stalls and menus, build a cart, place an order, follow its status until pickup |
| **Vendor app** | Stall owners | Live order queue, menu and stock management, daily sales |
| **University portal** (Flutter web) | Administration | Sales and performance per stall, reports, student feedback |

An order placed by a student reaches the vendor's queue instantly, and every status change flows back to the student and up to the portal.

## Try it in your browser

No install needed. The [interactive demo](https://dakshvasudev.vercel.app/project/amigo) recreates all three apps side by side, using the real stalls, menus and prices from this codebase:

1. Sign in on the student app and order from a stall
2. Accept it and mark it ready in the vendor app
3. Hand it over, rate it, and watch the university portal update

![Student and vendor apps in the interactive demo](docs/demo-order-flow.png)

![University portal in the interactive demo](docs/demo-university-portal.png)

> The demo runs on sample data in your browser. The Flutter apps in this repo talk to Firebase.

## Features in this repo (student app)

The app's UI matches the interactive demo: red and yellow Amigo branding, a bottom bar with Home, Orders and Cart, and a live order tracker.

- **Accounts:** email sign-up and login with Firebase Auth, profile photo upload to Firebase Storage
- **Home:** searchable list of stalls, streamed from Cloud Firestore
- **Menu:** every menu of a stall shown as a section with its items inline, with ADD and +/- steppers; items the vendor marks sold out are greyed out
- **Cart:** one stall per order, quantities editable in place, cart kept on the device and synced to the user's Firestore document
- **Orders:** placed with a single tap (pay at pickup), each with a pickup code and a live tracker (placed, being prepared, ready for pickup, collected) that updates as the vendor app changes the order's `status`
- **Ratings:** 1 to 5 stars once an order is collected, saved on the order so the university portal can report feedback per stall

### Order status values

| `status` | Shown as | Set by |
|---|---|---|
| `normal` | Order placed | Student app |
| `preparing` | Being prepared | Vendor app |
| `ready` | Ready for pickup | Vendor app |
| `ended` | Collected | Vendor app |
| `rejected` | Rejected | Vendor app |

## Architecture

```mermaid
flowchart LR
  S[Student app<br/>Flutter] -- place order --> O[(orders)]
  S -- order history --> UO[(users/uid/orders)]
  V[Vendor app<br/>Flutter] -- listens --> O
  V -- manages --> M[(sellers / menus / items)]
  S -- streams --> M
  P[University portal<br/>Flutter web] -- reads --> O
  P -- reads --> M
  A[Firebase Auth] -.-> S & V & P
```

**Firestore data model**

```
sellers/{sellerUID}
  └─ menus/{menuID}
       └─ items/{itemID}
users/{uid}                 # profile, userCart
  ├─ orders/{orderID}       # the student's own history
  └─ userAddress/{id}
orders/{orderID}            # shared collection the vendor app listens to
```

Each order is written twice, to the student's history and to the shared `orders` collection, so the student app and the vendor app each read only what they need.

## Tech stack

| Area | Choice |
|---|---|
| UI | Flutter, Material, Google Fonts (Inter) |
| State | Provider (cart count) |
| Backend | Firebase Auth, Cloud Firestore, Firebase Storage |
| Local storage | SharedPreferences |

## Run it locally

Requirements: Flutter SDK compatible with Dart `>=2.18 <3.0` (Flutter 3.3 to 3.7 era).

```bash
git clone https://github.com/dakshvasudev/Amigo.git
cd Amigo
flutter pub get
```

Connect your own Firebase project before running (the app expects Auth, Firestore and Storage):

```bash
dart pub global activate flutterfire_cli
flutterfire configure        # replaces android/app/google-services.json with your project's
flutter run
```

## Project structure

```
lib/
├── authScreen/        # auth tabs, login, register
├── mainScreens/       # home shell + tabs, menu, item detail, cart, orders, order details
├── widgets/           # shared UI (header, buttons, stepper), stall row, order card and tracker
├── assistantMethods/  # cart service, order service, cart counter (Provider)
├── model/, models/    # Items, Menus, Sellers, order status
└── main.dart
```

## Team and my role

Built in 2023 at Bennett University by a team of five. I led the team and worked on the Flutter apps and the Firebase data model.

## Roadmap

- Online payment instead of pay-at-pickup
- Push notification when an order is ready
- Firestore security rules so students can only rate their own collected orders
- Migrate to Dart 3 and current Firebase packages

---

<div align="center">

Made by [Daksh Vasudev](https://dakshvasudev.vercel.app/) · [LinkedIn](https://linkedin.com/in/daksh-vasudev)

</div>
