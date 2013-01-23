namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_tailor_made_player_requests
  end
end

def make_tailor_made_player_requests
  51.times do
    TailorMadePlayerRequest.create({
      name:        Faker::Name.name,
      email:       Faker::Internet.email,
      job_title:   Faker::Job.title,
      company:     Faker::Company.name,
      url:         Faker::Internet.http_url,
      country:     Country.all.sample[1],
      topic:       TailorMadePlayerRequest::TOPICS.sample,
      description: Faker::Company.bs,
      created_at:  random_date },
      without_protection: true)
  end
end

def random_date(from = Date.new(2013), to = Time.now.to_date)
  rand(from..to)
end
