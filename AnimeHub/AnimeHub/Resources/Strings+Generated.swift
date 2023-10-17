// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum StringGen {
  /// Detail
  internal static let detailTitle = StringGen.tr("Localizable", "detailTitle", fallback: "Detail")
  /// list.bullet
  internal static let favoriteIcon = StringGen.tr("Localizable", "favoriteIcon", fallback: "list.bullet")
  /// Favorite
  internal static let favoriteTabTitle = StringGen.tr("Localizable", "favoriteTabTitle", fallback: "Favorite")
  /// My List
  internal static let favoriteTitle = StringGen.tr("Localizable", "favoriteTitle", fallback: "My List")
  /// Localizable.strings
  ///   AnimeHub
  /// 
  ///   Created by Tobi on 05/10/2023.
  internal static let homeIcon = StringGen.tr("Localizable", "homeIcon", fallback: "house")
  /// Home
  internal static let homeTabTitle = StringGen.tr("Localizable", "homeTabTitle", fallback: "Home")
  /// Anime Hub
  internal static let homeTitle = StringGen.tr("Localizable", "homeTitle", fallback: "Anime Hub")
  /// magnifyingglass
  internal static let searchIcon = StringGen.tr("Localizable", "searchIcon", fallback: "magnifyingglass")
  /// Search
  internal static let searchTabTitle = StringGen.tr("Localizable", "searchTabTitle", fallback: "Search")
  /// Discover
  internal static let searchTitle = StringGen.tr("Localizable", "searchTitle", fallback: "Discover")
  /// calendar
  internal static let seasonalIcon = StringGen.tr("Localizable", "seasonalIcon", fallback: "calendar")
  /// Seasonal
  internal static let seasonalTabTitle = StringGen.tr("Localizable", "seasonalTabTitle", fallback: "Seasonal")
  /// Seasonal
  internal static let seasonalTitle = StringGen.tr("Localizable", "seasonalTitle", fallback: "Seasonal")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension StringGen {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
