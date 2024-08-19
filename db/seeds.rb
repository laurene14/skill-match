puts "Clear existing data"
ActiveRecord::Base.transaction do
  # Clear Messages
  Message.destroy_all

  # Clear Chatrooms
  Chatroom.destroy_all

  # Clear Matches
  Match.destroy_all

  # Clear Bookmarks
  Bookmark.destroy_all

  # Clear UserSkills
  UserSkill.destroy_all

  # Clear Skills
  Skill.destroy_all

  # Clear SkillCategories
  SkillCategory.destroy_all

  # Clear Users
  User.destroy_all

  # Clear Blocks
  Block.destroy_all
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

puts "Create Skills and assign to Categories"
skills.each do |skill_attributes|
  skill = Skill.create(name: skill_attributes[:name], description: skill_attributes[:description])
  category = Category.find_by(name: skill_attributes[:category_name])
  SkillCategory.create(skill: skill, category: category) if category
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

puts "Create User Interactions"
likes = [
  { liker: 'alice', liked: 'bob', wanted: true },
  { liker: 'bob', liked: 'alice', wanted: true },

  { liker: 'bob', liked: 'charlie', wanted: false },
  { liker: 'charlie', liked: 'bob', wanted: true },

  { liker: 'dave', liked: 'eve', wanted: true },
  { liker: 'eve', liked: 'dave', wanted: true },

  { liker: 'frank', liked: 'grace', wanted: true },
  { liker: 'grace', liked: 'frank', wanted: false },

  { liker: 'hank', liked: 'iva', wanted: true },
  { liker: 'iva', liked: 'hank', wanted: true },

  { liker: 'john', liked: 'katie', wanted: false },
  { liker: 'katie', liked: 'john', wanted: true },

  { liker: 'leo', liked: 'maya', wanted: true },
  { liker: 'maya', liked: 'leo', wanted: true },

  { liker: 'nick', liked: 'olivia', wanted: true },
  { liker: 'olivia', liked: 'nick', wanted: false },

  { liker: 'paul', liked: 'quinn', wanted: true },
  { liker: 'quinn', liked: 'paul', wanted: true },

  { liker: 'rachel', liked: 'hank', wanted: false },
  { liker: 'hank', liked: 'rachel', wanted: true }
]

likes.each do |like_attributes|
  liker = User.find_by(username: like_attributes[:liker])
  liked = User.find_by(username: like_attributes[:liked])
  UserSkill.create(user: liker, skill: liked.skill, wanted: like_attributes[:wanted])
end

puts "Create Matches"
def create_match(user1, user2)
  match = Match.create(user1: user1, user2: user2)
  create_chatroom(match)
end

def create_chatroom(match)
  Chatroom.create(match: match)
end

def match_status(user1, user2)
  like1 = UserSkill.find_by(user: user1, skill: user2.skill, wanted: true)
  like2 = UserSkill.find_by(user: user2, skill: user1.skill, wanted: true)

  if like1 && like2
    'matched'
  elsif like1 || like2
    'pending'
  else
    'not_matched'
  end
end

users = User.all

users.combination(2).each do |user1, user2|
  next if Block.find_by(blocker: user1, blocked: user2) || Block.find_by(blocker: user2, blocked: user1)

  status = match_status(user1, user2)
  if status == 'matched' || status == 'pending'
    create_match(user1, user2)
  end
end

puts "Create Messages"
messages = [
  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'alice'), user2: User.find_by(username: 'bob'))), user: User.find_by(username: 'alice'), content: 'Hi Bob!' },
  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'alice'), user2: User.find_by(username: 'bob'))), user: User.find_by(username: 'bob'), content: 'Hello Alice!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'bob'), user2: User.find_by(username: 'charlie'))), user: User.find_by(username: 'charlie'), content: 'Hey Bob, interested in a marketing project?' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'dave'), user2: User.find_by(username: 'eve'))), user: User.find_by(username: 'dave'), content: 'Hi Eve, let’s talk about fitness!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'frank'), user2: User.find_by(username: 'grace'))), user: User.find_by(username: 'frank'), content: 'Hi Grace, need some SEO tips!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'hank'), user2: User.find_by(username: 'iva'))), user: User.find_by(username: 'iva'), content: 'Hi Hank, let’s discuss UI/UX design!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'john'), user2: User.find_by(username: 'katie'))), user: User.find_by(username: 'john'), content: 'Hi Katie, interested in a design collaboration?' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'leo'), user2: User.find_by(username: 'maya'))), user: User.find_by(username: 'maya'), content: 'Hi Leo, want to talk about Piano techniques?' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'nick'), user2: User.find_by(username: 'olivia'))), user: User.find_by(username: 'nick'), content: 'Hi Olivia, can we chat about fitness and music?' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'paul'), user2: User.find_by(username: 'quinn'))), user: User.find_by(username: 'paul'), content: 'Hi Quinn, let’s discuss business strategies!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'rachel'), user2: User.find_by(username: 'hank'))), user: User.find_by(username: 'rachel'), content: 'Hi Hank, how about a project coordination meeting?' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'grace'), user2: User.find_by(username: 'maya'))), user: User.find_by(username: 'maya'), content: 'Hey Grace, I love your content marketing!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'frank'), user2: User.find_by(username: 'john'))), user: User.find_by(username: 'john'), content: 'Hi John, let’s discuss graphic design and SEO.' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'katie'), user2: User.find_by(username: 'olivia'))), user: User.find_by(username: 'olivia'), content: 'Hi Katie, let’s discuss entrepreneurship and music theory!' },

  { chatroom: Chatroom.find_by(match: Match.find_by(user1: User.find_by(username: 'quinn'), user2: User.find_by(username: 'rachel'))), user: User.find_by(username: 'quinn'), content: 'Hi Rachel, ready to talk about digital marketing?' }
]

messages.each do |message_attributes|
  Message.create(message_attributes)
end

puts "Create Bookmarks"
bookmarks = [
  { follower: 'alice', following: 'bob' },
  { follower: 'bob', following: 'charlie' },
  { follower: 'charlie', following: 'dave' },
  { follower: 'dave', following: 'eve' },
  { follower: 'frank', following: 'grace' },

  { follower: 'grace', following: 'hank' },
  { follower: 'hank', following: 'iva' },
  { follower: 'iva', following: 'john' },
  { follower: 'john', following: 'katie' },
  { follower: 'katie', following: 'leo' },

  { follower: 'leo', following: 'maya' },
  { follower: 'maya', following: 'nick' },
  { follower: 'nick', following: 'olivia' },
  { follower: 'olivia', following: 'paul' },
  { follower: 'paul', following: 'quinn' },

  { follower: 'quinn', following: 'rachel' },
  { follower: 'rachel', following: 'alice' }
]

bookmarks.each do |bookmark_attributes|
  follower = User.find_by(username: bookmark_attributes[:follower])
  following = User.find_by(username: bookmark_attributes[:following])
  Bookmark.create(follower: follower, following: following) if follower && following
end

puts "Seed successfully done"
