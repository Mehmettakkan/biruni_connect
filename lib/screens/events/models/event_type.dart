enum EventType {
  conference('Konferans'),
  seminar('Seminer'),
  workshop('Atölye'),
  festival('Festival/Şenlik'),
  sports('Spor Etkinliği'),
  career('Kariyer Etkinliği'),
  cultural('Kültürel Etkinlik'),
  other('Diğer');

  final String label;
  const EventType(this.label);
}
