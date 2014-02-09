require 'spec_helper'

describe Brewery do
  describe "when initialized with name Schlenkerla and year 1674" do
    subject{ Brewery.create name: "Schlenkerla", year: 1674 }

    it { should be_valid }
    its(:name) { should eq("Schlenkerla") }
    its(:year) { should eq(1674) }
  end
  it "cannot be established in the future (> this year)" do
    b = Brewery.create name: "Testimo", year: Date.today.year.next
    expect(b).to be_invalid
  end
end
