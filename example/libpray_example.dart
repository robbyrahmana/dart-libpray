import 'package:libpray/libpray.dart';

void main() {
  // Use Oct 13th, 2019.
  const int year = 2019;
  const int month = 10;
  const int day = 13;
  final DateTime when = DateTime.utc(year, month, day);

  // Init settings.
  // Set calculation method to JAKIM (Fajr: 18.0 and Isha: 20.0).
  // Provide all initial default values
  final PrayerCalculationSettings settings = PrayerCalculationSettings(
      (PrayerCalculationSettingsBuilder b) => b
        ..imsakParameter.value = -10.0
        ..imsakParameter.type = PrayerCalculationParameterType.minutesAdjust
        ..calculationMethod.replace(CalculationMethod.fromPreset(
            preset: CalculationMethodPreset
                .departmentOfIslamicAdvancementOfMalaysia,
            when: DateTime.now().toUtc()))
        ..juristicMethod.replace(
            JuristicMethod.fromPreset(preset: JuristicMethodPreset.standard))
        ..highLatitudeAdjustment = HighLatitudeAdjustment.none
        ..imsakMinutesAdjustment = 0
        ..fajrMinutesAdjustment = 0
        ..sunriseMinutesAdjustment = 0
        ..dhuhaMinutesAdjustment = 0
        ..dhuhrMinutesAdjustment = 0
        ..asrMinutesAdjustment = 0
        ..sunsetMinutesAdjustment = 0
        ..maghribMinutesAdjustment = 0
        ..ishaMinutesAdjustment = 0);

  // Init location info.
  final Geocoordinate geo = Geocoordinate((GeocoordinateBuilder b) => b
    ..latitude = -7.8594867
    ..longitude = 110.3872098
    ..altitude = 2.0);
  const double timezone = 7.0;

  // Generate prayer times for one day on April 12th, 2018.
  final Prayers prayers = Prayers.on(
      date: when, settings: settings, coordinate: geo, timeZone: timezone);
  print('imsak : ${prayers.imsak}');
  print('fajr : ${prayers.fajr}');
  print('sunrise : ${prayers.sunrise}');
  print('dhuha : ${prayers.dhuha}');
  print('dhuhr : ${prayers.dhuhr}');
  print('asr : ${prayers.asr}');
  print('sunset : ${prayers.sunset}');
  print('maghrib : ${prayers.maghrib}');
  print('isha : ${prayers.isha}');
  print('midnight : ${prayers.midnight}');

  // Generate current prayer time
  final Prayer current =
      Prayer.now(settings: settings, coordinate: geo, timeZone: timezone);
  print('${current.type}: ${current.time}');

  // Generate next prayer time
  final Prayer next =
      Prayer.next(settings: settings, coordinate: geo, timeZone: timezone);
  print('${next.type}: ${next.time}');

  // Generate later prayer time
  final Prayer later =
      Prayer.later(settings: settings, coordinate: geo, timeZone: timezone);
  print('${later.type}: ${later.time}');

  // Generate after later prayer time
  final Prayer afterLater = Prayer.afterLater(
      settings: settings, coordinate: geo, timeZone: timezone);
  print('${afterLater.type}: ${afterLater.time}');
}
