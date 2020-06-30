import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// BitcoinView Keys
PageStorageKey bitcoinViewScrollOffset = PageStorageKey('bitcoinview');
ScrollController bitcoinViewScrollController;
TabController bitcoinViewTabController;

// MoreView keys
PageStorageKey moreViewKey = PageStorageKey('moreview');

final RoundedLoadingButtonController buttonController = new RoundedLoadingButtonController();

// Globally used Maps
final Map<int, String> weekDayMap = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

final Map<int, String> monthMap = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

final Map<String, String> currencyMap = {
  'AED': 'د.إ',
  'AUD': 'A\$',
  'CAD': 'CA\$', 
  'CHF': 'CHF ',
  'CNY': 'CN¥',
  'EUR': '€',
  'GBP': '£',
  'HKD': 'HK\$',
  'INR': '₹',
  'JPY': '¥',
  'KRW': '₩',
  'PHP': 'PHP ',
  'SGD': 'SGD ',
  'TRY': 'TRY ',
  'USD': '\$',
  'XAU': 'GOLD '
};
