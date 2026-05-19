// Path: lib/core/utils/string_utils.dart

/// Utility functions for string manipulation.
class StringUtils {
  StringUtils._();

  /// Removes Slovak diacritics (accents) from a string.
  /// Useful for search filtering where "á" should match "a".
  static String removeDiacritics(String str) {
    const withDiacritics = 'áäčďéíĺľňóôŕšťúýžÁÄČĎÉÍĹĽŇÓÔŔŠŤÚÝŽ';
    const withoutDiacritics = 'aacdeillnoorstuyzAACDEILLNOORSTUYZ';

    var result = str;
    for (var i = 0; i < withDiacritics.length; i++) {
      result = result.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }
    return result;
  }

  /// Normalizes a string for search by converting to lowercase and removing diacritics.
  static String normalizeForSearch(String str) {
    return removeDiacritics(str.toLowerCase());
  }
}
