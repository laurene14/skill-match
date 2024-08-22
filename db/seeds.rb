require 'tqdm'

puts "clear existing data"
ActiveRecord::Base.transaction do
  User.destroy_all
  Category.destroy_all
  Skill.destroy_all
end

categories = [
  { name: 'Technology', description: 'Skills related to technology and programming' },
  { name: 'Design', description: 'Skills related to design and user experience' },
  { name: 'Marketing', description: 'Skills related to marketing and business development' },
  { name: 'Business', description: 'Skills related to business management and strategy' },
  { name: 'Education', description: 'Skills related to teaching and education' },
  { name: 'Sports', description: 'Skills related to various sports and fitness activities' },
  { name: 'Music', description: 'Skills related to music creation, performance, and theory' },
  { name: 'Dance', description: 'Skills related to various dance styles' },
  { name: 'Art', description: 'Skills related to visual and performing arts' },
  { name: 'DIY', description: 'Skills related to do-it-yourself projects and crafts' }
]

skills = {
  technology: [
    { name: 'Ruby on Rails', description: 'Web development framework' },
    { name: 'Python', description: 'Programming language' },
    { name: 'JavaScript', description: 'Scripting language for web development' }
  ],
  design: [
    { name: 'UI/UX Design', description: 'User Interface and User Experience design' },
    { name: 'Graphic Design', description: 'Creating visual content' },
    { name: 'Adobe Photoshop', description: 'Image editing and design' },
    { name: 'Fashion Design', description: 'Creating clothing and accessories' }
  ],
  marketing:
  [
    { name: 'SEO', description: 'Search Engine Optimization' },
    { name: 'Content Marketing', description: 'Creating and distributing valuable content' },
    { name: 'Social Media Management', description: 'Managing social media platforms' }
  ],
  business:
  [
    { name: 'Project Management', description: 'Managing projects and teams' },
    { name: 'Business Strategy', description: 'Planning and executing business strategies' },
    { name: 'Entrepreneurship', description: 'Starting and managing new ventures' }
  ],
  education:
  [
    { name: 'Curriculum Development', description: 'Designing educational programs' },
    { name: 'Tutoring', description: 'Providing individual academic support' },
    { name: 'Educational Technology', description: 'Using technology to enhance learning' }
  ],
  sports:
  [
    { name: 'Football', description: 'Playing and coaching soccer' },
    { name: 'Basketball', description: 'Playing and coaching basketball' },
    { name: 'Fitness Training', description: 'Personal fitness and training programs' }
  ],
  music:
  [
    { name: 'Piano', description: 'Playing and teaching Piano' },
    { name: 'Music Production', description: 'Creating and recording music' },
    { name: 'Music Theory', description: 'Understanding the fundamentals of music' }
  ],
  dance:
  [
    { name: 'Ballet', description: 'Classical dance form' },
    { name: 'Hip Hop', description: 'Street dance style' },
    { name: 'Contemporary Dance', description: 'Modern dance form' }
  ],
  art:
  [
    { name: 'Watercolor Painting', description: 'Art of painting with watercolors' },
    { name: 'Sculpture', description: 'Three-dimensional art form' },
    { name: 'Digital Art', description: 'Art created using digital tools' }
  ],
  diy:
  [
    { name: 'Woodworking', description: 'Crafting objects from wood' },
    { name: 'Knitting', description: 'Creating textiles using needles' },
    { name: 'Home Renovation', description: 'Improving or remodeling homes' }
  ]
}

ADDS_PACK = [
  {
    address: "60 Rue de Belleville, Paris",
    latitude: 48.874048,
    longitude: 2.379859
  },
  {
    address: "12 Boulevard Haussmann, Paris",
    latitude: 48.875328,
    longitude: 2.329027
  },
  {
    address: "16 Rue du Chemin Vert, Paris",
    latitude: 48.859964,
    longitude: 2.377573
  },
  {
    address: "45 Avenue des Champs-Élysées, Paris",
    latitude: 48.867495,
    longitude: 2.317430
  },
  {
    address: "5 Place des Vosges, Paris",
    latitude: 48.8551115,
    longitude: 2.3644399
  },
  {
    address: "32 Rue de la Convention, Paris",
    latitude: 48.8445518,
    longitude: 2.2800784
  },
  {
    address: "50 Avenue de Paris, Vincennes",
    latitude: 48.8452571,
    longitude: 2.432615
  },
  {
    address: "25 Rue du Faubourg Saint-Antoine, Paris",
    latitude: 48.852968,
    longitude: 2.369903
  }
]

SKILLS = []
ADMIN_PROVIDE_SKILLS = []

puts "create category and skills..."
categories.each do |category_attr|
  cat = Category.create(category_attr)
  skills[cat.name.downcase.to_sym].each do |skill_attr|
    skill = Skill.create(skill_attr)
    SKILLS << skill
    SkillCategory.create(skill:, category: cat)
  end
end

puts "create admins..."

ADMINS = {
  xinhe1: [
    ['Ruby on Rails', 'Python', 'JavaScript', 'Piano', 'Knitting'],
    ['Fitness Training', 'Woodworking', 'Ballet']
  ],
  adil0: [
    ['Ruby on Rails', 'JavaScript', 'Fitness Training', 'Basketball', 'Project Management', 'Graphic Design'],
    ['Contemporary Dance', 'Music Theory', 'Ballet']
  ],
  laurene1: [
    ['Ruby on Rails', 'JavaScript', 'Project Management', 'Entrepreneurship'],
    ['Social Media Management', 'Hip Hop', 'Fashion Design']
  ],
  severine1: [
    ['Ruby on Rails', 'JavaScript', 'Project Management'],
    ['Knitting', 'Educational Technology', 'SEO']
  ],
  mathieu0: [
    ['Ruby on Rails', 'JavaScript', 'Python', 'Project Management'],
    ['Home Renovation', 'Educational Technology', 'Tutoring']
  ]
}

def create_admin_user_skill(admin, likers, skill, wanted)
  UserSkill.create(user: admin, skill:, wanted:)
  ADMIN_PROVIDE_SKILLS << skill if wanted
  likers.each do |liker|
    UserSkill.create(user: liker, skill:, wanted: !wanted)
  end
end

def create_random_user_skill(user, wanted: true, admin_provided: false)
  skill = admin_provided ? ADMIN_PROVIDE_SKILLS.sample : SKILLS.sample
  UserSkill.create(user:, skill:, wanted:)
end

ADMINS.each do |key, skills_array|
  name = key[0..-2]
  puts "create #{name}, #{ key[-1] == '0' ? 'his' : 'her'} skills and personalized likers..."
  admin = User.create(username: name, email: "#{name}@sm.com",
                      password: 123_456, address: "16 villa Gaudelet",
                      latitude: 2.3801, longitude: 48.86495, admin: true)
  likers = []
  (0..4).to_a.each do |i|
    ind = i % ADDS_PACK.length
    username = rand > 0.5 ? Faker::Name.first_name : Faker::Artist.name
    username += "_"
    username += rand > 0.5 ? Faker::Construction.material : Faker::Creature::Dog.name
    username = username.downcase
    liker = User.create(username:,
                        email: "#{username}@#{Faker::Internet.domain_name}",
                        password: 123_456, address: ADDS_PACK[ind][:address],
                        latitude: ADDS_PACK[ind][:latitude], longitude: ADDS_PACK[ind][:longitude])
    if liker.persisted?
      Like.create(liker:, liked: admin, wanted: true)
      likers << liker
    end
  end
  [false, true].each_with_index do |wanted, i|
    skills_array[i].each do |skill|
      set_skill = Skill.find_by(name: skill)
      create_admin_user_skill(admin, likers, set_skill, wanted)
    end
  end
end

puts "create random users in our universe..."

(0...40).tqdm.each do |i|
  ind = i % ADDS_PACK.length
  username = Faker::Name.first_name
  user = User.create(username: "#{username.downcase}#{Faker::Name.initials.downcase}",
                     email: "#{username}@#{Faker::Internet.domain_name}",
                     password: 123_456, address: ADDS_PACK[ind][:address],
                     latitude: ADDS_PACK[ind][:latitude], longitude: ADDS_PACK[ind][:longitude])
  rand(1..2).times do
    create_random_user_skill(user)
    create_random_user_skill(user, admin_provided: true)
  end
  rand(3..5).times do
    create_random_user_skill(user, wanted: false)
  end
end

puts "everything is ready!"
