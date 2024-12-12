// mock/news_mock.dart
import 'package:biruni_connect/screens/home/models/news.dart';

class NewsMock {
  static final List<News> news = [
    News(
      id: 'news_1',
      title: 'TÜBİTAK Proje Ödülü',
      description:
          'Üniversitemiz öğrencileri TÜBİTAK yarışmasında birincilik ödülü kazandı.',
      imageUrl: 'assets/images/placeholder_award.jpg',
      route: '/news/news_1',
      date: DateTime(2024, 3, 15),
    ),
    News(
      id: 'news_2',
      title: 'Uluslararası İşbirliği Anlaşması',
      description:
          'Üniversitemiz, Oxford Üniversitesi ile işbirliği anlaşması imzaladı.',
      imageUrl: 'assets/images/placeholder_collaboration.jpg',
      route: '/news/news_2',
      date: DateTime(2024, 4, 5),
    ),
    News(
      id: 'news_3',
      title: 'Yeni Laboratuvar Açılışı',
      description: 'Mühendislik Fakültesi\'nde yeni AR-GE laboratuvarı açıldı.',
      imageUrl: 'assets/images/placeholder_lab.jpg',
      route: '/news/news_3',
      date: DateTime(2024, 5, 1),
    ),
    News(
      id: 'news_4',
      title: 'Akademik Başarı',
      description: 'Üniversitemiz dünya sıralamasında ilk 500\'e girdi.',
      imageUrl: 'assets/images/placeholder_ranking.jpg',
      route: '/news/news_4',
      date: DateTime(2024, 3, 30),
    ),
    News(
      id: 'news_5',
      title: 'Sosyal Sorumluluk Projesi',
      description: 'Öğrencilerimizin başlattığı çevre projesi ödül kazandı.',
      imageUrl: 'assets/images/placeholder_project.jpg',
      route: '/news/news_5',
      date: DateTime(2024, 4, 20),
    ),
  ];
}
