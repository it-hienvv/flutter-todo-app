
## Flutter to do app

`Todo app` demo app

## I. Introduction

**Setup**
- OS (Macos >= 10.15.7)
- Flutter version (>= 2.5.2)
- Dart version (>= 2.14.3)

**Feature**
- Show list todo
- Edit todo
- Delete todo
- Detail todo
- Filter todo

**Lib**
- flutter_bloc (state manager)
- get_it (dependency injection)
- floor (database)
- test (for test)
- bloc test (for bloc test)

**Structure**
```
    ├── ...
    ├── blocs                    **# Business layer (Business Logic Component)**
    │   ├── feature1          
    │   ├── feature2         
    │   └── ...                
    ├── constants                **# App constants**
    │   ├── constants1          
    │   ├── constants2         
    │   └── ...  
    ├── core                    **# App core for config, exception, themes...**
    │   ├── config          
    │   ├── exceptions         
    │   └── themes    
    ├── data                    **# Data access layer**
    │   ├── db                  
    │   ├── di                  
    │   ├── services 
    │   ├── models 
    │   └── repo 
    ├── presentations           **# Presentation layer**
    │   ├── commons          
    │   ├── routers         
    │   ├── screens 
    │   ├── widgets 
    │   └── unit
    ├── utils                   **# Helper for datetime, strings, validator...**
    │   ├── strings          
    │   ├── datetime         
    │   ├── validator  
    │   └── .... 
```

<br />

<img src="./architecture-proposal.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

<br />

## II. How to run

**Build mode**
- Dev
- Staging
- Prod

**Run**
- ```flutter pub get```
- ```flutter run```

**Test**
- ```flutter pub get```
- ```flutter test test/file_test.dart```

Liên lạc của tôi:

- Email: ithienvv@gmail.com

- Linkedin: ithienvv@gmail.com

Xin chân thành cảm ơn!
