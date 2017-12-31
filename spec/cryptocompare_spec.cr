require "./spec_helper"

describe Cryptocompare do
  it "should that_it_has_a_version_number" do
    ::Cryptocompare::VERSION.should_not eq(nil)
  end

  it "should exists" do
    Cryptocompare.should_not eq(nil)
  end
end
