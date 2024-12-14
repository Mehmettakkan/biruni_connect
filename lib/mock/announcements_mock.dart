// mock/announcements_mock.dart
import 'package:biruni_connect/screens/home/models/announcement.dart';

class AnnouncementsMock {
  static final List<Announcement> announcements = [
    Announcement(
      id: 'announcements_1',
      title: 'Biruni Üniversitesi Lisansüstü Kayıtları Başladı!',
      description: '''
2024-2025 Eğitim-Öğretim Yılı Bahar Dönemi Başvuruları, Kontenjan ve Kayıt Kabul Koşulları

Kontenjan ve Başvuru Koşullarını görüntülemek için tıklayınız.

Online Başvuru Linki: https://application.biruni.edu.tr/

Lisansüstü Programlara Başvuru, Kayıt ve Kabul Yönergesi için tıklayınız.

Biruni Üniversitesi Lisansüstü Eğitim Enstitüsü Lisansüstü Programlarına 2024-2025 Eğitim-Öğretim Yılı Bahar Dönemi öğrenci alımı başvuru ve değerlendirmeleri aşağıda belirtilen tarihlerde yapılacaktır:

- 02 Aralık - 27 Aralık 2024: Lisansüstü Başvuruları
- 02 Aralık - 27 Aralık 2024: Yatay Geçiş Başvuruları
- 02 – 03 Ocak 2025: Sınav (Mülakat)
- 07 Ocak 2025: Sonuçların Değerlendirilmesi ve İlanı
- 08 – 14 Ocak 2025: Kesin Kayıt
  ''',
      imageUrl: 'assets/images/announcements/postgraduate-registrations.jpg',
      route: '/announcements/announcements_1',
      date: DateTime(2024, 8, 15),
    ),
    Announcement(
      id: 'announcements_2',
      title: 'Afete Hazır Biruni Ailesi',
      description: '''
Dünyamızda ve ülkemizde yaşanan afetlerin sayısı her yıl artmaktadır. Yaşanan afetlerden en az zararla kurtulabilmek ve sevdiklerimizin yanında olmak için her bireyin sahip olması gereken afet bilgisine sende sahip olabilirsin. Alacağın eğitimlerle Temel AFAD Gönüllüsü bile olman mümkün.

Yürüttüğümüz Sosyal Sorumluluk Projesi “Afete Hazır Biruni Ailesi” kapsamında seni de aramızda görmekten gurur duyarız.

“Ben de varım…” diyorsan sana yardımcı olmak isteriz. AFAD Gönüllüsü kimdir, gönüllülük seviyeleri nelerdir, Temel AFAD Gönüllüsü olmanın bana katkıları neler olacaktır, ben nasıl Temel AFAD Gönüllüsü olabilirim gibi sorularına yanıt vermek için hazırladığımız kitapçığı takip ederek sende gönüllü olabilirsin.
  ''',
      imageUrl: 'assets/images/announcements/disaster.jpg',
      route: '/announcements/announcements_2',
      date: DateTime(2024, 12, 12),
    ),
    Announcement(
      id: 'announcements_3',
      title:
          'Uluslararası Eğitmenlerle Plastik Cerrahi Kadavra Kursları Üniversitemizde Gerçekleşti',
      description: '''
11 Kasım’da Face Lift Derin Plan Yüz Germe Kadavra Kursu, 14 Kasım’da ise Rinoplasti Kadavra Kursu düzenlendi. 
Irak, İspanya, Brezilya gibi ülkelerden gelen plastik cerrahların da yer aldığı 30 katılımcı, teori ve uygulamalı pratiklerle bilgi ve becerilerini geliştirdi.

Eğitimlerde, Doç. Dr. Erdinç Tunç, Prof. Dr. Nazım Çerkeş ve Dr. Enrico Robotti, modern yüz ve burun cerrahisi tekniklerini katılımcılara aktardı.

Sıradaki Eğitim: Medikal Estetik Kadavra Kursu  
Tarih: 14-15 Aralık 2024  
Yer: Anatomi Ana Bilim Dalı, Biruni Üniversitesi, Tıp Fakültesi, İstanbul
  ''',
      imageUrl: 'assets/images/announcements/plastic-surgery.jpeg',
      route: '/announcements/announcements_3',
      date: DateTime(2024, 8, 20),
    ),
    Announcement(
      id: 'announcements_4',
      title: 'Biruni Üniversitesi Öğrenci Toplulukları Fuarı Başlıyor!',
      description: '''
21-23 Ekim tarihlerinde öğrenci topluluklarımızın tanıtımlarının yapılacağı Öğrenci Toplulukları Fuarı'na seni de bekliyoruz! Fuar boyunca topluluklarımızı yakından tanıyabilir, ilgi duyduğun alanlarda aktif rol alabilirsin. 🎉

🗓️ Tarih: 21-23 Ekim  
⏰ Saat: 10.00 - 17.00  
📍 Yer: Merkez Kampüs - Havuz Katı Fuaye Alanı''',
      imageUrl: 'assets/images/announcements/student-societies.jpeg',
      route: '/announcements/announcements_4',
      date: DateTime(2024, 10, 21),
    ),
    Announcement(
      id: 'announcements_5',
      title:
          'Üniversite Spor Takımları Seçmeleri Başlıyor! Spor Takımlarında Yerini Al, Bu Heyecanı Sen de Yaşa!',
      description: '''Voleybol Kadın ve Erkek Takımları  
Üniversitemizin Voleybol Kadın ve Erkek takımları için seçmeler, 03 Ekim 2024 tarihinde saat 17:00'da Spor Merkezi'nde gerçekleştirilecektir. (A Blok - Havuz Katı)  
Voleybol tutkunuzu göstermek ve takımımızda yer almak için herkesi bekliyoruz!

Basketbol Kadın ve Erkek Takımları  
Üniversitemizin Basketbol Kadın ve Erkek takımları için seçmeler, 08 Ekim 2024 tarihinde saat 17:00'da Spor Merkezi'nde gerçekleştirilecektir. (A Blok - Havuz Katı)  
Basketbol yeteneklerinizi sergileme ve takımımızın bir parçası olma fırsatını kaçırmayın!

Farklı Branşlarda Spor Takımları  
Üniversitemizin Kadın ve Erkek sporcu takımları için diğer branşlardaki seçmeler, 10 Ekim 2024 tarihinde saat 17:00'da Spor Merkezi'nde gerçekleştirilecektir. (A Blok - Havuz Katı)  
Farklı branşlarda yeteneklerinizi sergilemek ve takımımıza katılmak için sizleri aramızda görmekten mutluluk duyarız!''',
      imageUrl: 'assets/images/announcements/student-societies.jpeg',
      route: '/announcements/announcements_5',
      date: DateTime(2024, 10, 10),
    ),
  ];
}
