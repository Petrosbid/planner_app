import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/core/utils/date_utils.dart';

void main() {
  // Known anchor: 2026-08-16 (Sunday) == 1405-05-25 Jalali (Mordad 25).
  final anchor = DateTime(2026, 8, 16);

  group('Jalali conversion', () {
    test('dayNumber renders Jalali day-of-month', () {
      expect(ZedDateUtils.dayNumber(anchor, fa: false, jalali: true), '25');
      expect(ZedDateUtils.dayNumber(anchor, fa: true, jalali: true), '۲۵');
    });

    test('dayNumber renders Gregorian day-of-month', () {
      expect(ZedDateUtils.dayNumber(anchor, fa: false, jalali: false), '16');
    });

    test('month names switch per calendar and locale', () {
      expect(ZedDateUtils.month(anchor, fa: true, jalali: true), 'مرداد');
      expect(ZedDateUtils.month(anchor, fa: false, jalali: true), 'Mordad');
      expect(ZedDateUtils.month(anchor, fa: true, jalali: false), 'اوت');
      expect(ZedDateUtils.month(anchor, fa: false, jalali: false), 'August');
    });

    test('year switches per calendar', () {
      expect(ZedDateUtils.year(anchor, jalali: true), 1405);
      expect(ZedDateUtils.year(anchor, jalali: false), 2026);
    });

    test('fullDate composes weekday + jalali day + month', () {
      expect(ZedDateUtils.fullDate(anchor, fa: true, jalali: true), 'یکشنبه، ۲۵ مرداد');
      expect(ZedDateUtils.fullDate(anchor, fa: false, jalali: false), 'Sunday, August 16');
    });

    test('monthYearHeader uses the chosen calendar year', () {
      expect(ZedDateUtils.monthYearHeader(anchor, fa: true, jalali: true), 'مرداد ۱۴۰۵');
      expect(ZedDateUtils.monthYearHeader(anchor, fa: false, jalali: false), 'August 2026');
    });

    test('daysInMonth matches Jalali month lengths', () {
      // Mordad 1405 has 31 days; its first day is 2026-07-23.
      expect(ZedDateUtils.daysInMonth(anchor, jalali: true), 31);
      // Esfand 1405 (not a leap year) has 29 days; contains 2027-03-11.
      expect(ZedDateUtils.daysInMonth(DateTime(2027, 3, 11), jalali: true), 29);
      // Gregorian February 2028 (leap) has 29 days.
      expect(ZedDateUtils.daysInMonth(DateTime(2028, 2, 10), jalali: false), 29);
    });

    test('monthStart returns the first day of the Jalali month', () {
      final start = ZedDateUtils.monthStart(anchor, jalali: true);
      expect(start, DateTime(2026, 7, 23));
      expect(ZedDateUtils.monthStart(anchor, jalali: false), DateTime(2026, 8, 1));
    });
  });

  group('calendar-independent helpers', () {
    test('weekOf starts on Saturday', () {
      // 2026-08-16 is Sunday; the Persian week containing it starts Sat 2026-08-15.
      final week = ZedDateUtils.weekOf(anchor);
      expect(week.first, DateTime(2026, 8, 15));
      expect(week.last, DateTime(2026, 8, 21));
      expect(week.length, 7);
    });

    test('toFaDigits converts only when fa', () {
      expect(ZedDateUtils.toFaDigits(42, fa: true), '۴۲');
      expect(ZedDateUtils.toFaDigits(42, fa: false), '42');
    });

    test('rangeLabel formats half hours', () {
      expect(ZedDateUtils.rangeLabel(10.5, 1, fa: false), '10:30 - 11:30');
      expect(ZedDateUtils.rangeLabel(9, 2, fa: true), '۰۹:۰۰ - ۱۱:۰۰');
    });
  });
}
