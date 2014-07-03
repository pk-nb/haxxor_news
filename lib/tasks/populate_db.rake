namespace :populate_db do
  desc 'Fill database with users and articles'
  task :create, [:amount] => :environment do |t, args|
    args.with_defaults(amount: 20)
    args[:amount].to_i.times do |n|
      User.create(username: "person#{n}", email: "person#{n}@email.com", password: 'password', password_confirmation: 'password')
      Article.create(title: "Article #{n}", url: "http://article#{n}.com", user_id: User.find_by(username: "person#{n}").id)
    end
  end

  desc 'Delete all generated users and articles in db'
  task :delete do
    User.where("username LIKE :prefix", prefix: 'person%').destroy_all
    Article.where("title LIKE :prefix", prefix: 'Article%').destroy_all
  end
end
