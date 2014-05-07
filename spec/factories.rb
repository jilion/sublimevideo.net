FactoryGirl.define do

  factory :tailor_made_player_request do
    name        'John Doe'
    email       'john@doe.com'
    job_title   'Developer'
    company     'Foo & Co.'
    url         'http://www.jilion.com'
    country     'FR'
    topic       'agency'
    description 'Want a player.'
  end

end
