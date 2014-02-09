require 'spec_helper'

describe BeerClub do
    describe "founded" do
      describe "in year the 1020" do
        subject{ BeerClub.create name: "Boolikerho", founded: 1020, city: "Helsinki"  }
          it { should be_valid }
        its(:founded) { should eq(1020) }
       end
      describe "with year greater than 1020, with name Bönthökerho and city Helsinki" do
          subject{ BeerClub.create name: "Bönthökerho", founded: 1021, city: "Helsinki"  }
          it { should be_valid }
          its(:name) { should eq("Bönthökerho") }
          its(:founded) { should eq(1021) }
      end
      describe "before year 1020" do
        subject{ BeerClub.create name: "Mörkökerho", founded: 1019, city: "Helsinki"  }
        it { should be_invalid }
        its(:founded) { should eq(1019) }
      end
    end
  it "has to_s" do
    bc = BeerClub.create name: "Marttakerho", founded: 2010, city: "Helsinki"
    expect(bc.to_s).to eq("Marttakerho")
  end
end