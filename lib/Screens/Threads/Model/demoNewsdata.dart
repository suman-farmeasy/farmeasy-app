class AgricultureNews {
  final String id;
  final String title;
  final String description;
  final String fullDescription;
  final String image;
  final String publishedBy;
  final String author;
  final DateTime date;
  final List<String> category;
  final String region;
  final String fullNewsLink;
  final List<String> tags;
  final String readTime;
  final int views;
  final int shareCount;

  AgricultureNews({
    required this.id,
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.image,
    required this.publishedBy,
    required this.author,
    required this.date,
    required this.category,
    required this.region,
    required this.fullNewsLink,
    required this.tags,
    required this.readTime,
    required this.views,
    required this.shareCount,
  });

  // Convert from JSON
  factory AgricultureNews.fromJson(Map<String, dynamic> json) {
    return AgricultureNews(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fullDescription: json['fullDescription'] as String,
      image: json['image'] as String,
      publishedBy: json['publishedBy'] as String,
      author: json['author'] as String,
      date: DateTime.parse(json['date'] as String),
      category: List<String>.from(json['category']),
      region: json['region'] as String,
      fullNewsLink: json['fullNewsLink'] as String,
      tags: List<String>.from(json['tags']),
      readTime: json['readTime'] as String,
      views: json['views'] as int,
      shareCount: json['shareCount'] as int,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fullDescription': fullDescription,
      'image': image,
      'publishedBy': publishedBy,
      'author': author,
      'date': date.toIso8601String(),
      'category': category,
      'region': region,
      'fullNewsLink': fullNewsLink,
      'tags': tags,
      'readTime': readTime,
      'views': views,
      'shareCount': shareCount,
    };
  }
}

// agriculture_news_data.dart

final List<Map<String, dynamic>> agricultureNewsData = [
  {
    "id": "AGN001",
    "title": "Revolutionary Drought-Resistant Wheat Variety Developed",
    "description":
        "Scientists at Cornell University have developed a new wheat variety that can thrive with 40% less water while maintaining yield levels, promising hope for drought-prone regions.",
    "fullDescription":
        "In a breakthrough development, agricultural researchers at Cornell University have successfully created a drought-resistant wheat variety through advanced genetic engineering. The new variety, named \"AridGold\", demonstrates remarkable resilience in water-scarce conditions while maintaining productivity levels comparable to traditional varieties. Field trials conducted across three continents show consistent results with 40% reduced water requirements. This development could revolutionize wheat farming in arid regions and provide a solution to growing food security concerns amid climate change.",
    "image": "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b",
    "publishedBy": "Agricultural Science Weekly",
    "author": "Dr. Sarah Johnson",
    "date": "2024-03-15",
    "category": ["Crop Science", "Innovation", "Climate Resilience"],
    "region": "Global",
    "fullNewsLink": "https://agrisciweekly.com/drought-resistant-wheat-2024",
    "tags": ["Wheat", "Drought Resistance", "Research", "Food Security"],
    "readTime": "5 minutes",
    "views": 15420,
    "shareCount": 2341
  },
  {
    "id": "AGN002",
    "title": "AI-Powered Pest Detection System Revolutionizes Farm Management",
    "description":
        "Japanese tech firm develops AI system that can identify and track crop pests in real-time using drone imagery, reducing pesticide use by 60%.",
    "fullDescription":
        "Tokyo-based agricultural technology company AgriTech Solutions has unveiled a groundbreaking AI-powered pest detection system that combines drone surveillance with machine learning algorithms. The system can identify pest infestations up to two weeks earlier than traditional methods, allowing for targeted intervention. Early adopters report a 60% reduction in pesticide use while maintaining crop health. The technology has been successfully tested on rice, wheat, and soybean fields across Asia.",
    "image": "https://images.unsplash.com/photo-1586771107445-d3ca888129ff",
    "publishedBy": "Tech in Agriculture Digest",
    "author": "Hiroshi Tanaka",
    "date": "2024-03-18",
    "category": ["AgriTech", "Artificial Intelligence", "Pest Management"],
    "region": "Asia",
    "fullNewsLink": "https://techinag.com/ai-pest-detection-2024",
    "tags": ["AI", "Drones", "Pest Control", "Sustainable Farming"],
    "readTime": "4 minutes",
    "views": 12890,
    "shareCount": 1876
  },
  {
    "id": "AGN003",
    "title": "Vertical Farming Breakthrough: New LED Technology Doubles Yield",
    "description":
        "Dutch researchers develop specialized LED lighting system that significantly increases crop yield in vertical farms while reducing energy consumption.",
    "fullDescription":
        "Scientists at Wageningen University have engineered a revolutionary LED lighting system specifically designed for vertical farming applications. The new system, dubbed 'SpectraMax', uses a proprietary combination of light wavelengths that optimize photosynthesis while consuming 30% less energy than conventional growing lights. Initial trials show a 100% increase in yield for leafy greens and herbs. The technology is already being implemented in major vertical farming operations across Europe.",
    "image": "https://images.unsplash.com/photo-1606006557981-ddf0ec4bc05c",
    "publishedBy": "Future Farming Today",
    "author": "Dr. Lisa van der Berg",
    "date": "2024-03-20",
    "category": ["Vertical Farming", "Innovation", "Energy Efficiency"],
    "region": "Europe",
    "fullNewsLink": "https://futurefarming.com/led-breakthrough-2024",
    "tags": [
      "LED Technology",
      "Vertical Farming",
      "Energy Efficiency",
      "Urban Agriculture"
    ],
    "readTime": "6 minutes",
    "views": 18765,
    "shareCount": 3102
  },
  {
    "id": "AGN004",
    "title":
        "Soil Microbiome Mapping Project Reveals Hidden Plant Growth Promoters",
    "description":
        "International research team completes first comprehensive mapping of beneficial soil bacteria, identifying new microorganisms that enhance crop growth.",
    "fullDescription":
        "A groundbreaking study led by an international consortium of soil scientists has completed the most comprehensive mapping of soil microbiomes to date. The project identified over 500 previously unknown bacterial species that demonstrate significant plant growth-promoting properties. Of particular interest are several strains that can fix nitrogen in non-legume crops, potentially reducing the need for synthetic fertilizers. The findings are expected to lead to new biological alternatives to chemical fertilizers.",
    "image": "https://images.unsplash.com/photo-1587162146766-e06b1189b907",
    "publishedBy": "Soil Science Journal",
    "author": "Dr. Miguel Rodriguez",
    "date": "2024-03-22",
    "category": ["Soil Science", "Microbiology", "Sustainable Agriculture"],
    "region": "Global",
    "fullNewsLink": "https://soilscience.org/microbiome-mapping-2024",
    "tags": ["Soil Health", "Microbiome", "Fertilizers", "Research"],
    "readTime": "7 minutes",
    "views": 14230,
    "shareCount": 1945
  },
  {
    "id": "AGN005",
    "title":
        "Breakthrough in Plant Disease Detection Using Smartphone Technology",
    "description":
        "Australian startup launches app that can diagnose plant diseases with 95% accuracy using smartphone camera and machine learning.",
    "fullDescription":
        "Melbourne-based startup AgriDiagnostics has released a revolutionary smartphone application that allows farmers to instantly diagnose plant diseases using their phone's camera. The app, powered by advanced machine learning algorithms trained on millions of plant images, can identify over 200 common crop diseases with 95% accuracy. The technology has been validated by leading agricultural institutions and is being distributed free to smallholder farmers in developing regions.",
    "image": "https://images.unsplash.com/photo-1587161584760-f51779fb276d",
    "publishedBy": "Digital Agriculture Report",
    "author": "Emma Wilson",
    "date": "2024-03-25",
    "category": ["AgriTech", "Plant Pathology", "Mobile Technology"],
    "region": "Oceania",
    "fullNewsLink": "https://digitalagreport.com/smartphone-diagnosis-2024",
    "tags": [
      "Disease Detection",
      "Mobile Apps",
      "Machine Learning",
      "Farming Technology"
    ],
    "readTime": "5 minutes",
    "views": 16540,
    "shareCount": 2876
  },
  {
    "id": "AGN006",
    "title": "Novel Rice Variety Shows Complete Resistance to Blast Disease",
    "description":
        "Chinese researchers develop rice variety with unprecedented resistance to rice blast disease, potentially saving billions in crop losses annually.",
    "fullDescription":
        "Scientists at the Chinese Academy of Agricultural Sciences have announced the development of a rice variety that demonstrates complete resistance to rice blast disease, one of the most devastating rice pathogens worldwide. The breakthrough was achieved through CRISPR gene editing technology, targeting multiple resistance genes simultaneously. Field trials across various climatic conditions show zero infection rates, while maintaining optimal yield qualities. This development could prevent annual losses of over  billion in global rice production.",
    "image": "https://images.unsplash.com/photo-1536657464919-892534f60d6e",
    "publishedBy": "Rice Science Monthly",
    "author": "Dr. Li Wei",
    "date": "2024-03-26",
    "category": ["Plant Breeding", "Disease Resistance", "Food Security"],
    "region": "Asia",
    "fullNewsLink": "https://ricescimonthly.com/blast-resistant-rice-2024",
    "tags": ["Rice", "Disease Resistance", "CRISPR", "Crop Protection"],
    "readTime": "6 minutes",
    "views": 19870,
    "shareCount": 3245
  },
  {
    "id": "AGN007",
    "title": "Solar-Powered Smart Irrigation System Reduces Water Usage by 75%",
    "description":
        "Brazilian startup launches advanced irrigation system combining solar power, IoT sensors, and AI to optimize water usage in agriculture.",
    "fullDescription":
        "São Paulo-based agricultural technology company AquaSmart has unveiled a revolutionary irrigation system that combines solar power, IoT sensors, and artificial intelligence to dramatically reduce water consumption in agriculture. The system uses a network of soil moisture sensors and weather data to create precise irrigation schedules, delivering water only when and where needed. Early adopters report water savings of up to 75% while maintaining or improving crop yields. The system's solar-powered design makes it particularly suitable for remote agricultural areas.",
    "image": "https://images.unsplash.com/photo-1563906267088-b029e7101114",
    "publishedBy": "Smart Farming Quarterly",
    "author": "Paulo Santos",
    "date": "2024-03-27",
    "category": ["Irrigation", "Solar Energy", "Smart Agriculture"],
    "region": "South America",
    "fullNewsLink": "https://smartfarmquarterly.com/solar-irrigation-2024",
    "tags": ["Irrigation", "Solar Power", "Water Conservation", "IoT"],
    "readTime": "5 minutes",
    "views": 14560,
    "shareCount": 2890
  },
  {
    "id": "AGN008",
    "title":
        "Breakthrough in Natural Pest Control: New Beneficial Insect Species Discovered",
    "description":
        "Canadian researchers identify new predatory insect species effective against multiple agricultural pests, offering organic pest control solution.",
    "fullDescription":
        "Entomologists at the University of British Columbia have discovered a previously unknown species of predatory wasp that shows remarkable effectiveness in controlling multiple agricultural pests. The species, named Aphidius canadensis, specifically targets aphids and other soft-bodied insects that damage crops. Laboratory and field trials demonstrate that introducing these wasps can reduce pest populations by up to 90% without the use of chemical pesticides. The discovery represents a significant advancement in biological pest control methods.",
    "image": "https://images.unsplash.com/photo-1597848212624-a19eb35e2651",
    "publishedBy": "Biological Control Review",
    "author": "Dr. Jennifer Thompson",
    "date": "2024-03-28",
    "category": ["Pest Control", "Entomology", "Organic Farming"],
    "region": "North America",
    "fullNewsLink": "https://biocontrolreview.com/beneficial-insect-2024",
    "tags": [
      "Biological Control",
      "Pest Management",
      "Organic Farming",
      "Research"
    ],
    "readTime": "4 minutes",
    "views": 12340,
    "shareCount": 1678
  },
  {
    "id": "AGN009",
    "title":
        "New Soil Carbon Measurement Technology Enables Precise Carbon Credit Trading",
    "description":
        "Swedish innovation allows real-time soil carbon measurement, revolutionizing carbon credit markets for agricultural sectors.",
    "fullDescription":
        "A team of Swedish environmental scientists has developed a groundbreaking technology for measuring soil carbon content in real-time. The portable device, called CarbonSense, uses spectral analysis and machine learning to provide accurate carbon content measurements within minutes, compared to traditional laboratory methods that take weeks. This innovation enables precise verification for carbon credit trading in agricultural sectors, potentially opening up new revenue streams for farmers practicing carbon sequestration techniques. The technology has been validated by the International Soil Carbon Initiative.",
    "image": "https://images.unsplash.com/photo-1589759118988-64674ad144c5",
    "publishedBy": "Environmental Technology Today",
    "author": "Erik Andersson",
    "date": "2024-03-29",
    "category": ["Carbon Markets", "Soil Science", "Climate Action"],
    "region": "Europe",
    "fullNewsLink": "https://envirotech.com/soil-carbon-measurement-2024",
    "tags": ["Carbon Credits", "Soil Health", "Climate Change", "Technology"],
    "readTime": "7 minutes",
    "views": 16780,
    "shareCount": 2987
  },
  {
    "id": "AGN010",
    "title":
        "Marine Agriculture Breakthrough: Floating Farms Achieve Commercial Scale",
    "description":
        "Norwegian company successfully deploys large-scale floating agricultural platforms, combining hydroponics with wave energy harvesting.",
    "fullDescription":
        "Norwegian agri-tech company OceanCrops has achieved a significant milestone in marine agriculture with the successful deployment of commercial-scale floating farm platforms. The innovative system combines hydroponic growing systems with wave energy harvesting technology, creating self-sustaining agricultural platforms that can produce fresh vegetables in ocean environments. The first commercial installation, located off the Norwegian coast, demonstrates the ability to grow 500 metric tons of vegetables annually while generating surplus clean energy. The technology offers new possibilities for food production in coastal regions with limited arable land.",
    "image": "https://images.unsplash.com/photo-1586771107445-d3ca888129ff",
    "publishedBy": "Marine Technology Review",
    "author": "Dr. Anders Nielsen",
    "date": "2024-03-30",
    "category": ["Marine Agriculture", "Innovation", "Sustainable Farming"],
    "region": "Europe",
    "fullNewsLink": "https://marinetechreview.com/floating-farms-2024",
    "tags": ["Ocean Farming", "Hydroponics", "Wave Energy", "Innovation"],
    "readTime": "6 minutes",
    "views": 20450,
    "shareCount": 4120
  },
  {
    "id": "AGN011",
    "title":
        "Advanced Pollinator Drones Successfully Replace Declining Bee Populations",
    "description":
        "Israeli tech firm develops micro-drones capable of artificial pollination, addressing global pollinator decline crisis.",
    "fullDescription":
        "Tel Aviv-based robotics company PolliTech has successfully deployed swarms of autonomous micro-drones designed to replicate the pollination activities of natural insects. The drones, measuring just 2 centimeters in length, use advanced computer vision and precise flight control to identify and pollinate flowers. Field trials in almond orchards showed pollination rates comparable to natural bee populations. While not intended to permanently replace natural pollinators, the technology provides a crucial backup solution for areas experiencing severe pollinator decline.",
    "image": "https://images.unsplash.com/photo-1590075865003-e48b276d3fd4",
    "publishedBy": "AgriRobotics Journal",
    "author": "Dr. Yael Cohen",
    "date": "2024-03-31",
    "category": ["Robotics", "Pollination", "Innovation"],
    "region": "Middle East",
    "fullNewsLink": "https://agrirobotics.com/pollinator-drones-2024",
    "tags": ["Drones", "Pollination", "Technology", "Bees"],
    "readTime": "5 minutes",
    "views": 17890,
    "shareCount": 3567
  },
  {
    "id": "AGN012",
    "title": "Quantum Computing Application Optimizes Crop Rotation Patterns",
    "description":
        "IBM and agricultural research institute develop quantum algorithm that determines optimal crop rotation patterns, increasing yield by 35%.",
    "fullDescription":
        "A collaborative project between IBM's Quantum Computing Division and the International Crop Research Institute has resulted in a groundbreaking application of quantum computing in agriculture. The team developed an algorithm that processes complex variables including soil chemistry, climate patterns, and market demands to determine optimal crop rotation schedules. Initial implementations show yield increases of up to 35% while improving soil health. The system can process scenarios in minutes that would take traditional computers months to calculate.",
    "image": "https://images.unsplash.com/photo-1567912593367-5ba7b4b35c6b",
    "publishedBy": "Quantum Computing Weekly",
    "author": "Dr. James Mitchell",
    "date": "2024-04-01",
    "category": ["Quantum Computing", "Crop Management", "Innovation"],
    "region": "Global",
    "fullNewsLink": "https://quantumweekly.com/crop-rotation-2024",
    "tags": ["Quantum Computing", "Crop Rotation", "AI", "Agriculture"],
    "readTime": "8 minutes",
    "views": 21340,
    "shareCount": 4532
  },
  {
    "id": "AGN013",
    "title":
        "Edible Coating Innovation Extends Fresh Produce Shelf Life by 300%",
    "description":
        "Malaysian researchers develop natural, edible coating that dramatically extends the shelf life of fruits and vegetables while preserving nutritional value.",
    "fullDescription":
        "Scientists at the Malaysian Agricultural Research and Development Institute have created a revolutionary edible coating made from natural plant extracts that can extend the shelf life of fresh produce by up to 300%. The coating, which is tasteless and invisible, creates a microscopic barrier that slows down the ripening process while allowing the produce to breathe. The innovation could significantly reduce food waste in the supply chain and enable longer-distance transportation of fresh produce without quality loss.",
    "image": "https://images.unsplash.com/photo-1587411768638-ec71f8e33b78",
    "publishedBy": "Food Technology Review",
    "author": "Dr. Lee Ming Chen",
    "date": "2024-04-02",
    "category": ["Food Technology", "Post-Harvest", "Innovation"],
    "region": "Asia",
    "fullNewsLink": "https://foodtechreview.com/edible-coating-2024",
    "tags": ["Food Preservation", "Post-Harvest", "Food Waste", "Innovation"],
    "readTime": "5 minutes",
    "views": 15670,
    "shareCount": 2890
  },
  {
    "id": "AGN014",
    "title":
        "Underground Fungi Network Mapping Revolutionizes Forest Agriculture",
    "description":
        "New technology enables mapping and utilization of natural fungal networks for improved forest crop cultivation and ecosystem management.",
    "fullDescription":
        "Researchers at the University of British Columbia have developed a groundbreaking technology for mapping and analyzing underground fungal networks in forest ecosystems. The system uses advanced sensors and AI to create detailed maps of mycorrhizal fungi networks, allowing for optimal placement of forest agriculture crops. Early trials show yield increases of up to 200% when crops are planted in optimal positions within the natural fungal network. This development could transform agroforestry practices while preserving natural forest ecosystems.",
    "image": "https://images.unsplash.com/photo-1597848212624-a19eb35e2651",
    "publishedBy": "Forest Science Quarterly",
    "author": "Dr. Robert Pine",
    "date": "2024-04-03",
    "category": ["Agroforestry", "Mycology", "Ecosystem Management"],
    "region": "North America",
    "fullNewsLink": "https://forestscience.com/fungi-mapping-2024",
    "tags": ["Fungi", "Forest Agriculture", "Ecosystem", "Research"],
    "readTime": "6 minutes",
    "views": 13450,
    "shareCount": 2234
  },
  {
    "id": "AGN015",
    "title":
        "Satellite-Based Early Warning System Predicts Crop Diseases Two Weeks in Advance",
    "description":
        "European Space Agency launches advanced satellite system capable of detecting early signs of crop diseases, enabling preventive action.",
    "fullDescription":
        "The European Space Agency, in collaboration with agricultural research institutes, has launched a revolutionary satellite-based early warning system for crop diseases. The system combines hyperspectral imaging with machine learning algorithms to detect subtle changes in crop health indicators up to two weeks before visible symptoms appear. The technology has been successfully tested across Europe, providing farmers crucial time to implement preventive measures. Initial results show potential reduction in crop losses by up to 60% while reducing pesticide use through targeted early intervention.",
    "image": "https://images.unsplash.com/photo-1567789884554-0b844b6c49e0",
    "publishedBy": "Space Technology in Agriculture",
    "author": "Dr. Marie Laurent",
    "date": "2024-04-04",
    "category": ["Space Technology", "Disease Prevention", "Innovation"],
    "region": "Europe",
    "fullNewsLink": "https://spacetech-ag.com/early-warning-2024",
    "tags": [
      "Satellites",
      "Disease Detection",
      "Technology",
      "Precision Agriculture"
    ],
    "readTime": "7 minutes",
    "views": 18920,
    "shareCount": 3456
  },
  {
    "id": "AGN016",
    "title":
        "AI-Driven Aquaponics System Achieves Record Fish and Vegetable Yields",
    "description":
        "Singaporean startup introduces AI-powered aquaponics system that optimizes fish and vegetable production in urban environments.",
    "fullDescription":
        "Singapore-based agri-tech startup AquaFarms has developed an AI-driven aquaponics system that combines fish farming with hydroponic vegetable cultivation to achieve record yields in urban environments. The system uses machine learning algorithms to optimize nutrient cycling between fish and plants, resulting in faster growth rates and higher yields. Early adopters report a 40% increase in fish production and a 60% increase in vegetable yields compared to traditional aquaponics systems. The technology is being scaled for commercial rooftop farms in densely populated cities.",
    "image": "https://images.unsplash.com/photo-1597848212624-a19eb35e2651",
    "publishedBy": "Urban Agriculture Today",
    "author": "Dr. Mei Ling Tan",
    "date": "2024-04-05",
    "category": ["Aquaponics", "Urban Farming", "AI Technology"],
    "region": "Asia",
    "fullNewsLink": "https://urbanagtoday.com/ai-aquaponics-2024",
    "tags": ["Aquaponics", "AI", "Urban Agriculture", "Sustainability"],
    "readTime": "5 minutes",
    "views": 16780,
    "shareCount": 2987
  },
  {
    "id": "AGN017",
    "title": "Robotic Weed Control System Reduces Herbicide Use by 90%",
    "description":
        "Swedish agri-tech company launches autonomous robotic weeding system that identifies and eliminates weeds without chemical herbicides.",
    "fullDescription":
        "Stockholm-based agri-tech company RoboWeed has introduced an innovative robotic weeding system that uses advanced computer vision and robotic arms to identify and remove weeds without the need for chemical herbicides. The system, named 'WeedMaster', can distinguish between crops and weeds with 98% accuracy and precisely target individual weeds for removal. Early adopters report a 90% reduction in herbicide use while maintaining crop yields. The technology is being adopted by organic and conventional farmers seeking sustainable weed management solutions.",
    "image": "https://images.unsplash.com/photo-1597848212624-a19eb35e2651",
    "publishedBy": "WeedTech Review",
    "author": "Dr. Lars Eriksson",
    "date": "2024-04-06",
    "category": ["Robotics", "Weed Management", "Sustainable Agriculture"],
    "region": "Europe",
    "fullNewsLink": "https://weedtechreview.com/robotic-weeding-2024",
    "tags": ["Robotics", "Weed Control", "Sustainability", "Innovation"],
    "readTime": "4 minutes",
    "views": 12340,
    "shareCount": 1678
  }
];

// Example usage in Flutter:

// To create a list of AgricultureNews objects:
List<AgricultureNews> getAgricultureNews() {
  return agricultureNewsData
      .map((json) => AgricultureNews.fromJson(json))
      .toList();
}
