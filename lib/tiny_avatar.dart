library tiny_avatar;

import 'package:flutter/material.dart';

/// A `TinyAvatar` widget
///
/// The avatar is generated from the `baseString`. This generation gives the appearance of randomness
/// but will always be the same for the same base string.
class TinyAvatar extends StatelessWidget {
  /// The base string to generate the avatar from. For best results, use a string with 5+ characters.
  final String baseString;

  /// The colour scheme of the avatar.
  final TinyAvatarColourScheme colourScheme;

  /// Supplies the avatar with a custom custom set of colours. If this is not null, the `colourScheme` will be ignored.
  ///
  /// This list should contain:
  /// - 4 colours
  /// - 1st is the most prevalent, taking ~40% of the total space
  /// - 2nd takes ~30% of the total space
  /// - 3rd takes ~20% of the total space
  /// - 4th takes ~10% of the total space and is the accent colour
  final List<Color>? customColours;

  /// The clip of the avatar. Defaults to `Clip.antiAlias`.
  ///
  /// NOTE: settings this to `Clip.none` will cause the avatar to be drawn as a square regardless of other parameters.
  final Clip clip;

  /// The width and height of the avatar
  final double dimension;

  /// If true, the avatar will be completely rounded. By default, the avatar will be a square. **Incompatible with `borderRadius`**
  final bool? circular;

  /// The border radius of the avatar. If not set, the avatar will be a square. **Incompatible with `circular`**
  final double? borderRadius;

  const TinyAvatar({
    super.key,
    required this.baseString,
    this.colourScheme = TinyAvatarColourScheme.froggy,
    this.customColours,
    this.clip = Clip.antiAlias,
    required this.dimension,
    this.circular,
    this.borderRadius,
  })  : assert(
          circular == null || borderRadius == null,
          "Can't have both circular border radius and and set border radius",
        ),
        assert(
          customColours == null || customColours.length >= 3,
        );

  @override
  Widget build(BuildContext context) {
    // The hascode is the basis for avatar generation.
    final int hashCode = baseString.hashCode;

    // Convert hashCode into a list of integers
    final List<int> numbers = hashCode
        .toString()
        .split('')
        .map((number) => int.parse(number))
        .toList();

    // If our list is too short, pad it with some pseudo-random (but repeatable) numbers
    int adds = 0;
    while (numbers.length < 18) {
      final newNumbers = numbers
          .map(
            (number) => number * (adds + 1),
          )
          .toList();
      numbers.addAll(newNumbers);
      adds++;
    }

    // Convert list of numbers into lists of colours
    final List<Color> columnOneColours = numbers
        .sublist(0, 6)
        .map(
          (number) =>
              _generateColour(customColours ?? colourScheme.colours, number),
        )
        .toList();
    final List<Color> columnTwoColours = numbers
        .sublist(6, 12)
        .map(
          (number) =>
              _generateColour(customColours ?? colourScheme.colours, number),
        )
        .toList();
    final List<Color> columnThreeColours = numbers
        .sublist(12, 18)
        .map(
          (number) =>
              _generateColour(customColours ?? colourScheme.colours, number),
        )
        .toList();

    // Avatar is 6x6 grid
    final double containerDimension = dimension / 6;

    // Convert our list of colours into a list of coloured containers
    final List<Widget> columnOne = columnOneColours
        .map(
          (colour) => Container(
            width: containerDimension,
            height: containerDimension,
            color: colour,
          ),
        )
        .toList();

    final List<Widget> columnTwo = columnTwoColours
        .map(
          (colour) => Container(
            width: containerDimension,
            height: containerDimension,
            color: colour,
          ),
        )
        .toList();

    final List<Widget> columnThree = columnThreeColours
        .map(
          (colour) => Container(
            width: containerDimension,
            height: containerDimension,
            color: colour,
          ),
        )
        .toList();

    return Center(
      child: ClipRRect(
        // Default to antiAlias
        clipBehavior: clip,
        borderRadius: (circular == true)
            ? BorderRadius.circular(dimension / 2)
            : BorderRadius.circular(borderRadius ?? 0),
        child: SizedBox(
          width: dimension,
          height: dimension,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: columnOne,
              ),
              Column(
                children: columnTwo,
              ),
              Column(
                children: columnThree,
              ),
              Column(
                children: columnThree,
              ),
              Column(
                children: columnTwo,
              ),
              Column(
                children: columnOne,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TinyAvatarColourScheme {
  froggy(
    colours: [
      Color.fromARGB(255, 83, 208, 66),
      Color.fromARGB(255, 59, 183, 123),
      Color.fromARGB(255, 222, 255, 217),
      Color.fromARGB(255, 137, 229, 49),
    ],
  ),
  heated(
    colours: [
      Color.fromARGB(255, 250, 67, 4),
      Color.fromARGB(255, 200, 33, 23),
      Color.fromARGB(255, 255, 250, 241),
      Color.fromARGB(255, 255, 130, 20),
    ],
  ),
  seascape(
    colours: [
      Color.fromARGB(255, 0, 103, 111),
      Color.fromARGB(255, 0, 71, 119),
      Color.fromARGB(255, 238, 243, 242),
      Color.fromARGB(255, 0, 161, 134),
    ],
  ),
  summer(
    colours: [
      Color.fromARGB(255, 246, 224, 56),
      Color.fromARGB(255, 255, 200, 63),
      Color.fromARGB(255, 255, 255, 229),
      Color.fromARGB(255, 185, 217, 47),
    ],
  ),
  poolside(
    colours: [
      Color.fromARGB(255, 70, 124, 241),
      Color.fromARGB(255, 82, 177, 240),
      Color.fromARGB(255, 234, 240, 255),
      Color.fromARGB(255, 120, 92, 242),
    ],
  ),
  fruity(
    colours: [
      Color.fromARGB(255, 255, 122, 13),
      Color.fromARGB(255, 255, 151, 82),
      Color.fromARGB(255, 255, 248, 239),
      Color.fromARGB(255, 255, 98, 0),
    ],
  ),
  ;

  /// Colours are in order of prevalence in the final image
  final List<Color> colours;

  const TinyAvatarColourScheme({
    required this.colours,
  });
}

Color _generateColour(List<Color> scheme, int colorNumber) {
  final number = colorNumber % 10;
  if (number >= 0 && number <= 3) {
    return scheme[0];
  }
  if (number >= 4 && number <= 6) {
    return scheme[1];
  }
  if (number >= 7 && number <= 8) {
    return scheme[2];
  }
  return scheme[3];
}
