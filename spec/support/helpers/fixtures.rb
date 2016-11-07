
module FixturesHelpers
  def read_fixture(filename)
    File.read("./spec/support/fixtures/#{filename}")
  end
end
