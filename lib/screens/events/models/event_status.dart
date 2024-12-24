enum EventStatus {
  upcoming('Yaklaşan'),
  ongoing('Devam Eden'),
  completed('Tamamlandı'),
  cancelled('İptal');

  final String label;
  const EventStatus(this.label);
}
