namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    populate_users
    populate_microposts
    populate_relationships
    end
    
    def populate_users
    admin = User.create!(name: "Edoardo",
                         email: "edoardo_lelli@libero.it",
                         password: "pazzini",
                         password_confirmation: "pazzini")
                         admin.toggle!(:admin)
                      
                        
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    end  
    
    def populate_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
    def populate_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end
end
