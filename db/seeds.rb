puts "Clear existing data"
ActiveRecord::Base.transaction do
  User.destroy_all
  Category.destroy_all
  Skill.destroy_all
end

puts "Creating categories"
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

categories.each do |category_attributes|
  Category.create(category_attributes)
end

puts "Create Skills"
skills = [
  { name: 'Ruby on Rails', description: 'Web development framework', category_name: 'Technology' },
  { name: 'Python', description: 'Programming language', category_name: 'Technology' },
  { name: 'JavaScript', description: 'Scripting language for web development', category_name: 'Technology' },

  { name: 'UI/UX Design', description: 'User Interface and User Experience design', category_name: 'Design' },
  { name: 'Graphic Design', description: 'Creating visual content', category_name: 'Design' },
  { name: 'Adobe Photoshop', description: 'Image editing and design', category_name: 'Design' },

  { name: 'SEO', description: 'Search Engine Optimization', category_name: 'Marketing' },
  { name: 'Content Marketing', description: 'Creating and distributing valuable content', category_name: 'Marketing' },
  { name: 'Social Media Management', description: 'Managing social media platforms', category_name: 'Marketing' },

  { name: 'Project Management', description: 'Managing projects and teams', category_name: 'Business' },
  { name: 'Business Strategy', description: 'Planning and executing business strategies', category_name: 'Business' },
  { name: 'Entrepreneurship', description: 'Starting and managing new ventures', category_name: 'Business' },

  { name: 'Curriculum Development', description: 'Designing educational programs', category_name: 'Education' },
  { name: 'Tutoring', description: 'Providing individual academic support', category_name: 'Education' },
  { name: 'Educational Technology', description: 'Using technology to enhance learning', category_name: 'Education' },

  { name: 'Football', description: 'Playing and coaching soccer', category_name: 'Sports' },
  { name: 'Basketball', description: 'Playing and coaching basketball', category_name: 'Sports' },
  { name: 'Fitness Training', description: 'Personal fitness and training programs', category_name: 'Sports' },

  { name: 'Piano', description: 'Playing and teaching Piano', category_name: 'Music' },
  { name: 'Music Production', description: 'Creating and recording music', category_name: 'Music' },
  { name: 'Music Theory', description: 'Understanding the fundamentals of music', category_name: 'Music' },

  { name: 'Ballet', description: 'Classical dance form', category_name: 'Dance' },
  { name: 'Hip Hop', description: 'Street dance style', category_name: 'Dance' },
  { name: 'Contemporary Dance', description: 'Modern dance form', category_name: 'Dance' },

  { name: 'Watercolor Painting', description: 'Art of painting with watercolors', category_name: 'Art' },
  { name: 'Sculpture', description: 'Three-dimensional art form', category_name: 'Art' },
  { name: 'Digital Art', description: 'Art created using digital tools', category_name: 'Art' },

  { name: 'Woodworking', description: 'Crafting objects from wood', category_name: 'DIY' },
  { name: 'Knitting', description: 'Creating textiles using needles', category_name: 'DIY' },
  { name: 'Home Renovation', description: 'Improving or remodeling homes', category_name: 'DIY' },
  { name: 'Fashion Design', description: 'Creating clothing and accessories', category_name: 'Design' }
]

puts "Assigning Skills to Categories"
skills.each do |skill_attributes|
  skill = Skill.create(name: skill_attributes[:name], description: skill_attributes[:description])
  category = Category.find_by(name: skill_attributes[:category_name])
  SkillCategory.create(skill: skill, category: category)
end

puts "Create Users"
users = [
  { username: 'alice', email: 'alice@example.com', password: 'password123', bio: 'Software Developer', address: '123 Main St', latitude: 40.7128, longitude: -74.0060 },
  { username: 'bob', email: 'bob@example.com', password: 'password123', bio: 'Graphic Designer', address: '456 Elm St', latitude: 34.0522, longitude: -118.2437 },
  { username: 'charlie', email: 'charlie@example.com', password: 'password123', bio: 'Digital Marketer', address: '789 Maple St', latitude: 37.7749, longitude: -122.4194 },
  { username: 'dave', email: 'dave@example.com', password: 'password123', bio: 'Fitness Trainer', address: '101 Pine St', latitude: 36.1699, longitude: -115.1398 },
  { username: 'eve', email: 'eve@example.com', password: 'password123', bio: 'Music Producer', address: '202 Oak St', latitude: 34.0522, longitude: -118.2437 },

  { username: 'frank', email: 'frank@example.com', password: 'password123', bio: 'SEO Specialist', address: '303 Birch St', latitude: 37.7749, longitude: -122.4194 },
  { username: 'grace', email: 'grace@example.com', password: 'password123', bio: 'Content Writer', address: '404 Cedar St', latitude: 40.7306, longitude: -73.9352 },
  { username: 'hank', email: 'hank@example.com', password: 'password123', bio: 'Project Manager', address: '505 Walnut St', latitude: 41.8781, longitude: -87.6298 },
  { username: 'iva', email: 'iva@example.com', password: 'password123', bio: 'UI Designer', address: '606 Spruce St', latitude: 37.7749, longitude: -122.4194 },
  { username: 'john', email: 'john@example.com', password: 'password123', bio: 'Graphic Designer', address: '707 Pine St', latitude: 34.0522, longitude: -118.2437 },

  { username: 'katie', email: 'katie@example.com', password: 'password123', bio: 'Entrepreneur', address: '808 Fir St', latitude: 40.7128, longitude: -74.0060 },
  { username: 'leo', email: 'leo@example.com', password: 'password123', bio: 'Basketball Coach', address: '909 Redwood St', latitude: 36.1699, longitude: -115.1398 },
  { username: 'maya', email: 'maya@example.com', password: 'password123', bio: 'Piano Instructor', address: '1010 Maple St', latitude: 41.8781, longitude: -87.6298 },
  { username: 'nick', email: 'nick@example.com', password: 'password123', bio: 'Fitness Coach', address: '1111 Elm St', latitude: 40.7306, longitude: -73.9352 },
  { username: 'olivia', email: 'olivia@example.com', password: 'password123', bio: 'Music Theory Expert', address: '1212 Oak St', latitude: 37.7749, longitude: -122.4194 },

  { username: 'paul', email: 'paul@example.com', password: 'password123', bio: 'Business Consultant', address: '1313 Birch St', latitude: 34.0522, longitude: -118.2437 },
  { username: 'quinn', email: 'quinn@example.com', password: 'password123', bio: 'Dance Instructor', address: '1414 Cedar St', latitude: 41.8781, longitude: -87.6298 },
  { username: 'rachel', email: 'rachel@example.com', password: 'password123', bio: 'Project Coordinator', address: '1515 Walnut St', latitude: 36.1699, longitude: -115.1398 }
]

users.each do |user_attributes|
  User.create(user_attributes)
end

puts "Assign Skills to Users"
user_skills = {
  'alice' => ['Ruby on Rails', 'Python'],
  'bob' => ['UI/UX Design', 'Graphic Design'],
  'charlie' => ['SEO', 'Content Marketing'],
  'dave' => ['Fitness Training'],
  'eve' => ['Piano', 'Music Production'],

  'frank' => ['SEO'],
  'grace' => ['Content Marketing'],
  'hank' => ['Project Management'],
  'iva' => ['UI/UX Design'],
  'john' => ['Graphic Design'],

  'katie' => ['Entrepreneurship'],
  'leo' => ['Basketball'],
  'maya' => ['Piano'],
  'nick' => ['Fitness Training'],
  'olivia' => ['Music Theory'],

  'paul' => ['Business Strategy'],
  'quinn' => ['Dance Instruction'],
  'rachel' => ['Project Coordination']
}

user_skills.each do |username, skill_names|
  user = User.find_by(username: username)
  skill_names.each do |skill_name|
    skill = Skill.find_by(name: skill_name)
    UserSkill.create(user: user, skill: skill) if skill
  end
end

likes.each do |like_attributes|
  liker = User.find_by(username: like_attributes[:liker])
  liked = User.find_by(username: like_attributes[:liked])
  UserSkill.create(user: liker, skill: liked.skills[0], wanted: like_attributes[:wanted])
end

