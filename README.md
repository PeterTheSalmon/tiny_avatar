A simple way to generate and display pseudo-random avatars for your users. Inspired by https://www.tinygraphs.com/

## Getting started

Install the package:

`flutter pub add tiny_avatar`

Import it into your project:
```dart
import 'package:tiny_avatar/tiny_avatar.dart';
```

## Features

- Generate unique avatars from a single string
- Customize colour, shape, and size with ease
- Avatars are consistent - the same string always leads to the same result
- Complete documentation

## Usage

```dart
TinyAvatar(
    baseString: 'John',
    dimension: 150,
);
```

![image](https://i.imgur.com/Mga9jmv.png)


## Customization

```dart

// Change colour scheme
TinyAvatar(
    baseString: 'c418',
    dimension: 150,
    colourScheme: TinyAvatarColourScheme.heated,
),

// Circular option
TinyAvatar(
    baseString: 'Mary',
    dimension: 150,
    circular: true,
),

// Custom border radius
TinyAvatar(
    baseString: 'Elton John',
    dimension: 150,
    colourScheme: TinyAvatarColourScheme.seascape,
    borderRadius: 30,
),

// Custom colour scheme
TinyAvatar(
    baseString: 'Superman',
    dimension: 150,
    colourScheme: TinyAvatarColourScheme.summer,
    customColours: const [
        Colors.red,
        Colors.orange,
        Colors.orangeAccent,
        Colors.yellow
    ],
)

```

![image](https://i.imgur.com/YkxhsvA.png)

## Additional information

Github: https://github.com/PeterTheSalmon/tiny_avatar

Want something added? Open an issue or pull request!
