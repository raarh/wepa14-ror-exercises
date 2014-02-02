require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end
  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.rating_average).to eq(15.0)
    end
    describe "and password" do
      it "is longer than 4 characters" do
        expect(User.create username:"Pekka", password:"Sec1", password_confirmation:"Sec1").to be_valid
        expect(User.create username:"Masa", password:"Secr1", password_confirmation:"Secr1").to be_valid
        expect(User.count).to eq(2)
        expect(User.create username:"Peksi", password:"Se1", password_confirmation:"Se1").not_to be_valid
        expect(User.count).to eq(2)
      end
      it "contain at least one uppercase character" do
        expect(User.create username:"Peksi", password:"sec1", password_confirmation:"sec1").not_to be_valid
        expect(User.create username:"Masa", password:"Sec1", password_confirmation:"Sec1").to be_valid
        expect(User.create username:"Pekka", password:"SEc1", password_confirmation:"SEc1").to be_valid
        expect(User.count).to eq(2)
      end
      it "contain at least one number" do
        expect(User.create username:"Peksi", password:"Secr", password_confirmation:"Secr").not_to be_valid
        expect(User.create username:"Masa", password:"Secr1", password_confirmation:"Secr1").to be_valid
        expect(User.create username:"Pekka", password:"SEc12", password_confirmation:"SEc12").to be_valid
        expect(User.count).to eq(2)
      end
    end
  end
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }
    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
  end
end

