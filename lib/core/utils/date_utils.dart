/// Calendar-aware date helpers.
///
/// All data is stored as absolute `DateTime`s; this class renders them in the
/// user's chosen calendar system (Jalali or Gregorian) and locale (fa/en).
/// Persian digit conversion is independent of the calendar choice.
library;

import 'package:shamsi_date/shamsi_date.dart';

class ZedDateUtils {
  ZedDateUtils._();

  static const List<String> _faWeekdays = [
    'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه', 'شنبه', 'یکشنبه',
  ];

  static const List<String> _faWeekdayShorts = ['د', 'س', 'چ', 'پ', 'ج', 'ش', 'ی'];

  static const List<String> _enWeekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  static const List<String> _faJalaliMonths = [
    'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
    'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند',
  ];

  static const List<String> _enJalaliMonths = [
    'Farvardin', 'Ordibehesht', 'Khordad', 'Tir', 'Mordad', 'Shahrivar',
    'Mehr', 'Aban', 'Azar', 'Dey', 'Bahman', 'Esfand',
  ];

  static const List<String> _faGregorianMonths = [
    'ژانویه', 'فوریه', 'مارس', 'آوریل', 'مه', 'ژوئن',
    'ژوئیه', 'اوت', 'سپتامبر', 'اکتبر', 'نوامبر', 'دسامبر',
  ];

  static const List<String> _enGregorianMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _faDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  // ---------- weekday (same names for both calendars; week starts Saturday) ----------

  static String weekday(DateTime date, {bool fa = true, bool short = false}) {
    if (fa) return short ? _faWeekdayShorts[date.weekday - 1] : _faWeekdays[date.weekday - 1];
    return _enWeekdays[date.weekday - 1];
  }

  // ---------- month / day numbers per calendar ----------

  static String month(DateTime date, {required bool fa, bool jalali = true}) {
    if (jalali) {
      final j = date.toJalali();
      return fa ? _faJalaliMonths[j.month - 1] : _enJalaliMonths[j.month - 1];
    }
    return fa ? _faGregorianMonths[date.month - 1] : _enGregorianMonths[date.month - 1];
  }

  /// Day-of-month number in the chosen calendar, digits converted for fa.
  static String dayNumber(DateTime date, {required bool fa, bool jalali = true}) {
    final day = jalali ? date.toJalali().day : date.day;
    return toFaDigits(day, fa: fa);
  }

  /// Year number in the chosen calendar (Jalali year when [jalali]).
  static int year(DateTime date, {bool jalali = true}) =>
      jalali ? date.toJalali().year : date.year;

  /// e.g. "دوشنبه، ۲۵ مرداد" / "Monday, August 16" (Gregorian) or
  /// "شنبه، ۲۵ مرداد" style with Jalali month names when [jalali].
  static String fullDate(DateTime date, {required bool fa, bool jalali = true}) {
    if (fa) {
      return '${weekday(date)}، ${dayNumber(date, fa: true, jalali: jalali)} ${month(date, fa: true, jalali: jalali)}';
    }
    return '${weekday(date, fa: false)}, ${month(date, fa: false, jalali: jalali)} ${dayNumber(date, fa: false, jalali: jalali)}';
  }

  /// "مرداد ۱۴۰۵" / "Mordad 1405" or "August 2026".
  static String monthYearHeader(DateTime date, {required bool fa, bool jalali = true}) {
    return '${month(date, fa: fa, jalali: jalali)} ${toFaDigits(year(date, jalali: jalali), fa: fa)}';
  }

  /// Number of days in the month of [date] in the chosen calendar.
  static int daysInMonth(DateTime date, {bool jalali = true}) {
    if (jalali) return date.toJalali().monthLength;
    final firstNext = DateTime(date.year, date.month + 1, 1);
    return firstNext.subtract(const Duration(days: 1)).day;
  }

  /// First day (as DateTime) of the month containing [date] in the chosen calendar.
  static DateTime monthStart(DateTime date, {bool jalali = true}) {
    if (!jalali) return DateTime(date.year, date.month, 1);
    final j = date.toJalali();
    return Jalali(j.year, j.month, 1).toDateTime();
  }

  // ---------- absolute-date helpers (calendar-independent) ----------

  /// The week containing [date], starting Saturday (Persian week).
  static List<DateTime> weekOf(DateTime date) {
    // DateTime.weekday: Mon=1..Sun=7 → Sat-start offset
    final offset = (date.weekday + 1) % 7;
    final start = DateTime(date.year, date.month, date.day).subtract(Duration(days: offset));
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool isToday(DateTime d) => isSameDay(d, DateTime.now());

  static String toFaDigits(Object n, {bool fa = true}) {
    final s = n.toString();
    if (!fa) return s;
    return s.replaceAllMapped(RegExp(r'\d'), (m) => _faDigits[int.parse(m.group(0)!)]);
  }

  /// "۰۸:۰۰" style hour label.
  static String hourLabel(double hour, {bool fa = true}) {
    final h = hour.floor();
    final m = ((hour - h) * 60).round();
    final hh = h.toString().padLeft(2, '0');
    final mm = m == 0 ? '00' : m.toString().padLeft(2, '0');
    return toFaDigits('$hh:$mm', fa: fa);
  }

  /// "۰۹:۳۰ - ۱۱:۰۰" style range label.
  static String rangeLabel(double startHour, double durationHours, {bool fa = true}) {
    final end = startHour + durationHours;
    final eh = end.floor();
    final em = ((end - eh) * 60).round();
    final ehS = eh.toString().padLeft(2, '0');
    final emS = em == 0 ? '00' : em.toString().padLeft(2, '0');
    return '${hourLabel(startHour, fa: fa)} - ${toFaDigits('$ehS:$emS', fa: fa)}';
  }
}
