// mock/announcements_mock.dart
import 'package:biruni_connect/screens/home/models/announcement.dart';

class AnnouncementsMock {
  static final List<Announcement> announcements = [
    Announcement(
      id: 'announcements_1',
      title:
          'Biruni Üniversitesi’nde Duygu Dolu 24 Kasım Öğretmenler Günü Programı',
      description:
          'Biruni Üniversitesi Konferans Salonu, 24 Kasım Öğretmenler Günü kapsamında düzenlenen anlamlı bir kutlama programına ev sahipliği yaptı.',
      imageUrl: 'assets/images/announcements/ogretmenler_gunu.jpg',
      route: '/announcements/announcements_1',
      date: DateTime(2024, 8, 15),
    ),
    Announcement(
      id: 'announcements_2',
      title:
          'Biruni Üniversitesi Hayvan Deneyleri Yerel Etik Kurulu Başvurulara Açılmıştır',
      description:
          'Biruni Üniversitesi olarak, bilimsel araştırmaların etik standartlara uygun şekilde yürütülmesi ve hayvan refahının korunması en önemli önceliklerimizdendir.',
      imageUrl: 'assets/images/announcements/hayvan_deneyleri.jpg',
      route: '/announcements/announcements_2',
      date: DateTime(2024, 9, 1),
    ),
    Announcement(
      id: 'announcements_3',
      title: 'Girişimcilik ve Ön Kuluçka Eğitimi Başlıyor',
      description:
          'Tekno Park ve sektörün deneyimli eğitmenleri ile girişimcilere özel yepyeni bir program başlıyor. İş dünyasına güçlü bir adım atmak ve kendi girişiminizi kurmak için ihtiyacınız olan tüm bilgi ve becerileri kazanın.',
      imageUrl: 'assets/images/announcements/girisimcilik.jpg',
      route: '/announcements/announcements_3',
      date: DateTime(2024, 8, 20),
    ),
    Announcement(
      id: 'announcements_4',
      title:
          'Biruni Üniversitesi Akademisyenleri Dünyanın En Etkili Bilim İnsanları Listesinde.',
      description: '',
      imageUrl: 'assets/images/announcements/akademisyenler.jpg',
      route: '/announcements/announcements_4',
      date: DateTime(2024, 6, 1),
    ),
    Announcement(
      id: 'announcements_5',
      title: 'Biruni ve Trinity College Dublin Araştırma Diyalogları',
      description:
          'Eczacılık ve farmasötik bilimler alanında uzman olan Prof. Dr. Sheridan, araştırmacılarımız ve öğretim üyelerimizle bir araya gelerek onların çalışma ve araştırma alanlarını dinledi. Görüşmelerde, Biruni Üniversitesi ve Trinity College Dublin arasında birçok disiplinde işbirliği potansiyeli vurgulandı.',
      imageUrl: 'assets/images/announcements/toplanti.jpg',
      route: '/announcements/announcements_5',
      date: DateTime(2024, 7, 1),
    ),
  ];
}
