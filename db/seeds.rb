puts "Clear existing data"
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

skill_ids = []

categories.each do |category_attr|
  puts "create category #{category_attr[:name]} and skills..."
  cat = Category.create(category_attr)
  skills[cat.name.downcase.to_sym].each do |skill_attr|
    skill = Skill.create(skill_attr)
    skill_ids << skill.id
    SkillCategory.create(skill:, category: cat)
  end
end

puts "create admins..."

admins = %w[xinhe adil laurene severine mathieu]

def create_user_skill

end
admins.each do |admin|
  puts "create #{admin} and her skills..."
  user = User.create(username: admin, email: "#{admin}@sm.com",
                     password: 123_456, address: "16 villa Gaudelet",
                     latitude: 2.3801, longitude: 48.86495, admin: true)
  rand(3..5).times do
    UserSkill.create(user:, skill_id: skill_ids.sample, wanted: true)
  end
  rand(3..5).times do
    UserSkill.create(user:, skill_id: skill_ids.sample, wanted: false)
  end
end

puts "create random users in our universe..."

adds_pack = [
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
    longitude: 2.377573,
  },
  {
    address: "45 Avenue des Champs-Élysées, Paris",
    latitude: 48.867495,
    longitude: 2.317430
  }
]

40.times do |i|
  ind = i % adds_pack.length
  username = Faker::Name.first_name
  user = User.create(username: "#{username.downcase}#{Faker::Name.initials.downcase}",
                     email: "#{username}@#{Faker::Internet.domain_name}",
                     password: 123_456, address: adds_pack[ind][:address],
                     latitude: adds_pack[ind][:latitude], longitude: adds_pack[ind][:longitude])
  rand(3..5).times do
    UserSkill.create(user:, skill_id: skill_ids.sample, wanted: true)
  end
  rand(3..5).times do
    UserSkill.create(user:, skill_id: skill_ids.sample, wanted: false)
  end
end
