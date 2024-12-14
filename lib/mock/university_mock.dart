final universityMockData = {
  'universityInfo': {
    'name': 'Biruni Üniversitesi',
    'foundationYear': '2014',
    'mission':
        'Bilimsel düşünce ve evrensel değerlere bağlı, araştıran, sorgulayan ve topluma katkı sağlayan bireyler yetiştirmeyi hedefleyen Biruni Üniversitesi, sağlık, teknoloji ve bilim alanlarında öncü bir eğitim sunmayı amaçlamaktadır.',
    'vision':
        'Sağlık, bilim ve teknoloji odaklı çalışmalarıyla uluslararası alanda tanınan, yenilikçi ve öncü bir dünya üniversitesi olmayı hedeflemektedir.',
    'history':
        'Biruni Üniversitesi, 2014 yılında Dünya Eğitim Vakfı tarafından kurulmuş ve sağlık bilimleri alanına odaklanmıştır. Üniversite, adını Türk-İslam bilim insanı Ebu Reyhan El-Biruni’den almıştır. UNESCO tarafından "Evrensel Deha" olarak kabul edilen El-Biruni, birçok bilim dalında önemli eserler bırakmış ve üniversite, bu mirası devam ettirme vizyonu ile çalışmalarına başlamıştır.'
  },
  'faculties': [
    {
      'id': 'f1',
      'name': 'Tıp Fakültesi',
      'description':
          'Modern tıp eğitiminde öncü, alanında uzman hekimler yetiştiren fakülte.',
      'programIds': ['p1']
    },
    {
      'id': 'f2',
      'name': 'Mühendislik ve Doğa Bilimleri Fakültesi',
      'description':
          'Teknoloji ve inovasyonda lider, geleceğin mühendislerini yetiştiren fakülte.',
      'programIds': ['p2', 'p3', 'p4', 'p5']
    },
    {
      'id': 'f3',
      'name': 'Eczacılık Fakültesi',
      'description':
          'İlaç geliştirme ve farmasötik bilimler alanlarında eğitim veren fakülte.',
      'programIds': ['p6']
    },
    {
      'id': 'f4',
      'name': 'Diş Hekimliği Fakültesi',
      'description':
          'Diş sağlığı ve tedavi alanında uzman diş hekimleri yetiştiren fakülte.',
      'programIds': ['p7']
    },
    {
      'id': 'f5',
      'name': 'Eğitim Fakültesi',
      'description':
          'Geleceğin öğretmenlerini yetiştiren, çeşitli eğitim alanlarında uzmanlaşan fakülte.',
      'programIds': ['p8', 'p9', 'p10', 'p11']
    },
    {
      'id': 'f6',
      'name': 'Sağlık Bilimleri Fakültesi',
      'description':
          'Sağlıkla ilgili çeşitli alanlarda eğitim veren ve sağlık profesyonelleri yetiştiren fakülte.',
      'programIds': ['p12', 'p13']
    }
  ],
  'programs': [
    {
      'id': 'p1',
      'name': 'Tıp',
      'description': 'Nitelikli hekim yetiştirme programı.',
      'facultyId': 'f1',
      'duration': '6 yıl',
      'degree': 'Tıp Doktoru',
      'language': 'Türkçe/İngilizce'
    },
    {
      'id': 'p2',
      'name': 'Bilgisayar Mühendisliği',
      'description': 'Modern yazılım ve donanım teknolojileri eğitimi.',
      'facultyId': 'f2',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'İngilizce'
    },
    {
      'id': 'p3',
      'name': 'Biyomedikal Mühendisliği',
      'description':
          'Sağlık teknolojileri ve medikal cihaz geliştirme eğitimi.',
      'facultyId': 'f2',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'İngilizce'
    },
    {
      'id': 'p4',
      'name': 'Elektrik-Elektronik Mühendisliği',
      'description':
          'Elektrik ve elektronik mühendisliği alanında eğitim veren program.',
      'facultyId': 'f2',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'İngilizce'
    },
    {
      'id': 'p5',
      'name': 'İç Mimarlık ve Çevre Tasarımı',
      'description':
          'Mimarlık ve çevre tasarımına yönelik eğitim veren program.',
      'facultyId': 'f2',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p6',
      'name': 'Eczacılık',
      'description':
          'Farmasötik bilimler ve ilaç geliştirme alanında eğitim veren program.',
      'facultyId': 'f3',
      'duration': '5 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p7',
      'name': 'Diş Hekimliği',
      'description':
          'Diş sağlığı ve tedavi alanında eğitim veren diş hekimliği programı.',
      'facultyId': 'f4',
      'duration': '5 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p8',
      'name': 'İlköğretim Matematik Öğretmenliği',
      'description': 'İlköğretim matematik öğretmeni yetiştiren program.',
      'facultyId': 'f5',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p9',
      'name': 'İngilizce Öğretmenliği',
      'description': 'İngilizce öğretmeni yetiştiren program.',
      'facultyId': 'f5',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p10',
      'name': 'Okul Öncesi Öğretmenliği',
      'description': 'Okul öncesi eğitim öğretmeni yetiştiren program.',
      'facultyId': 'f5',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p11',
      'name': 'Özel Eğitim Öğretmenliği',
      'description':
          'Özel eğitim gereksinimi duyan bireyler için eğitim veren öğretmen yetiştiren program.',
      'facultyId': 'f5',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p12',
      'name': 'Hemşirelik',
      'description':
          'Hemşirelik alanında uzman profesyoneller yetiştiren program.',
      'facultyId': 'f6',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    },
    {
      'id': 'p13',
      'name': 'Sağlık Yönetimi',
      'description':
          'Sağlık sektöründe yönetim ve organizasyon alanlarında eğitim veren program.',
      'facultyId': 'f6',
      'duration': '4 yıl',
      'degree': 'Lisans',
      'language': 'Türkçe'
    }
  ],
  'contactInfo': {
    'address': 'Merkezefendi, 75 Sk No:1-13 M. G, 34015 Zeytinburnu/İstanbul',
    'phone': '+90 212 444 8 276',
    'email': 'info@biruni.edu.tr',
    'website': 'www.biruni.edu.tr',
    'socialMedia': {
      'facebook': 'biruniedu',
      'twitter': 'Biruniedu',
      'instagram': 'biruniuniversitesi',
      'linkedin': 'school/biruni-üniversitesi/',
      'youtube': 'biruniuniversitesi'
    },
    'location': {'latitude': 41.01744, 'longitude': 28.91595}
  }
};
