
module FixturesHelpers
  def read_fixture(filename)
    File.read("./spec/fixtures/#{filename}")
  end
end
