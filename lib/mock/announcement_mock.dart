class CarouselItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String route;
  final DateTime date;
  final String category;

  CarouselItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.route,
    required this.date,
    required this.category,
  });
}

// Mock veriler
final List<CarouselItem> mockCarouselItems = [
  // Duyurular
  CarouselItem(
    id: 'announcement_1',
    title:
        'Biruni Üniversitesi’nde Duygu Dolu 24 Kasım Öğretmenler Günü Programı',
    description:
        'Biruni Üniversitesi Konferans Salonu, 24 Kasım Öğretmenler Günü kapsamında düzenlenen anlamlı bir kutlama programına ev sahipliği yaptı.',
    imageUrl: 'assets/images/announcements/ogretmenler_gunu.jpg',
    route: '/announcements/announcement_1',
    date: DateTime(2024, 8, 15),
    category: 'announcement',
  ),
  CarouselItem(
    id: 'announcement_2',
    title:
        'Biruni Üniversitesi Hayvan Deneyleri Yerel Etik Kurulu Başvurulara Açılmıştır',
    description:
        'Biruni Üniversitesi olarak, bilimsel araştırmaların etik standartlara uygun şekilde yürütülmesi ve hayvan refahının korunması en önemli önceliklerimizdendir. ',
    imageUrl: 'assets/images/announcements/hayvan_deneyleri.jpg',
    route: '/announcements/announcement_2',
    date: DateTime(2024, 9, 1),
    category: 'announcement',
  ),
  CarouselItem(
    id: 'announcement_3',
    title:
        'Üniversitemiz Kariyer Merkezi , Sürekli Eğitim Merkezi (KARSEM) ve Teknopark işbirliği ile yapılması planlanan Girişimcilik ve Ön Kuluçka Eğitimi Başlıyor.',
    description:
        'Tekno Park ve sektörün deneyimli eğitmenleri ile girişimcilere özel yepyeni bir program başlıyor. İş dünyasına güçlü bir adım atmak ve kendi girişiminizi kurmak için ihtiyacınız olan tüm bilgi ve becerileri kazanın. 6 temel modülle kariyerinize ve girişiminize değer katın!',
    imageUrl: 'assets/images/announcements/girisimcilik.jpg',
    route: '/announcements/announcement_3',
    date: DateTime(2024, 8, 20),
    category: 'announcement',
  ),
  CarouselItem(
    id: 'announcement_4',
    title:
        'Biruni Üniversitesi Akademisyenleri Dünyanın En Etkili Bilim İnsanları Listesinde.',
    description: '',
    imageUrl: 'assets/images/announcements/akademisyenler.jpg',
    route: '/announcements/announcement_4',
    date: DateTime(2024, 6, 1),
    category: 'announcement',
  ),
  CarouselItem(
    id: 'announcement_5',
    title: 'Biruni ve Trinity College Dublin Araştırma Diyalogları',
    description:
        'Eczacılık ve farmasötik bilimler alanında uzman olan Prof. Dr. Sheridan, araştırmacılarımız ve öğretim üyelerimizle bir araya gelerek onların çalışma ve araştırma alanlarını dinledi. Görüşmelerde, Biruni Üniversitesi ve Trinity College Dublin arasında birçok disiplinde işbirliği potansiyeli vurgulandı.',
    imageUrl: 'assets/images/announcements/toplanti.jpg',
    route: '/announcements/announcement_5',
    date: DateTime(2024, 7, 1),
    category: 'announcement',
  ),

  // Etkinlikler
  CarouselItem(
    id: 'event_1',
    title: 'Bahar Şenlikleri 2024',
    description:
        'Geleneksel bahar şenlikleri 15-20 Nisan tarihleri arasında düzenlenecektir.',
    imageUrl: 'assets/images/placeholder_festival.jpg',
    route: '/events/event_1',
    date: DateTime(2024, 4, 15),
    category: 'event',
  ),
  CarouselItem(
    id: 'event_2',
    title: 'Kariyer Günleri',
    description:
        'Sektör liderleri ile buluşma fırsatı sunan kariyer günleri etkinliği.',
    imageUrl: 'assets/images/placeholder_career.jpg',
    route: '/events/event_2',
    date: DateTime(2024, 5, 10),
    category: 'event',
  ),
  CarouselItem(
    id: 'event_3',
    title: 'Bilim ve Teknoloji Festivali',
    description:
        'Öğrenci projelerinin sergileneceği bilim ve teknoloji festivali.',
    imageUrl: 'assets/images/placeholder_tech.jpg',
    route: '/events/event_3',
    date: DateTime(2024, 5, 20),
    category: 'event',
  ),
  CarouselItem(
    id: 'event_4',
    title: 'Spor Turnuvaları',
    description: 'Fakülteler arası spor turnuvaları başlıyor.',
    imageUrl: 'assets/images/placeholder_sports.jpg',
    route: '/events/event_4',
    date: DateTime(2024, 4, 1),
    category: 'event',
  ),
  CarouselItem(
    id: 'event_5',
    title: 'Kültür ve Sanat Haftası',
    description: 'Bir hafta boyunca sürecek kültür ve sanat etkinlikleri.',
    imageUrl: 'assets/images/placeholder_culture.jpg',
    route: '/events/event_5',
    date: DateTime(2024, 6, 15),
    category: 'event',
  ),

  // Haberler
  CarouselItem(
    id: 'news_1',
    title: 'TÜBİTAK Proje Ödülü',
    description:
        'Üniversitemiz öğrencileri TÜBİTAK yarışmasında birincilik ödülü kazandı.',
    imageUrl: 'assets/images/placeholder_award.jpg',
    route: '/news/news_1',
    date: DateTime(2024, 3, 15),
    category: 'news',
  ),
  CarouselItem(
    id: 'news_2',
    title: 'Uluslararası İşbirliği Anlaşması',
    description:
        'Üniversitemiz, Oxford Üniversitesi ile işbirliği anlaşması imzaladı.',
    imageUrl: 'assets/images/placeholder_collaboration.jpg',
    route: '/news/news_2',
    date: DateTime(2024, 4, 5),
    category: 'news',
  ),
  CarouselItem(
    id: 'news_3',
    title: 'Yeni Laboratuvar Açılışı',
    description: 'Mühendislik Fakültesi\'nde yeni AR-GE laboratuvarı açıldı.',
    imageUrl: 'assets/images/placeholder_lab.jpg',
    route: '/news/news_3',
    date: DateTime(2024, 5, 1),
    category: 'news',
  ),
  CarouselItem(
    id: 'news_4',
    title: 'Akademik Başarı',
    description: 'Üniversitemiz dünya sıralamasında ilk 500\'e girdi.',
    imageUrl: 'assets/images/placeholder_ranking.jpg',
    route: '/news/news_4',
    date: DateTime(2024, 3, 30),
    category: 'news',
  ),
  CarouselItem(
    id: 'news_5',
    title: 'Sosyal Sorumluluk Projesi',
    description: 'Öğrencilerimizin başlattığı çevre projesi ödül kazandı.',
    imageUrl: 'assets/images/placeholder_project.jpg',
    route: '/news/news_5',
    date: DateTime(2024, 4, 20),
    category: 'news',
  ),
];
