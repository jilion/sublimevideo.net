module FixturesHelper
  def fixture_file(path, mode = 'r')
    File.new(Rails.root.join('spec/fixtures', path), mode)
  end
end

RSpec.configuration.include(FixturesHelper)
