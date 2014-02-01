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
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.rating_average).to eq(15.0)
    end
    describe "and password" do
      it "is longer than 4 characters" do
        user1 = User.create username:"Pekka", password:"Sec1", password_confirmation:"Sec1"
        expect(user1).to be_valid
        user1 = User.create username:"Masa", password:"Secr1", password_confirmation:"Secr1"
        expect(user1).to be_valid
        expect(User.count).to eq(2)
        user1 = User.create username:"Peksi", password:"Se1", password_confirmation:"Se1"
        expect(user1).not_to be_valid
        expect(User.count).to eq(2)
      end
      it "contain at least one uppercase character" do
        user1 = User.create username:"Peksi", password:"sec1", password_confirmation:"sec1"
        expect(user1).not_to be_valid
        user1 = User.create username:"Masa", password:"Sec1", password_confirmation:"Sec1"
        expect(user1).to be_valid
        user1 = User.create username:"Pekka", password:"SEc1", password_confirmation:"SEc1"
        expect(user1).to be_valid
        expect(User.count).to eq(2)
      end
      it "contain at least one number" do
        user1 = User.create username:"Peksi", password:"Secr", password_confirmation:"Secr"
        expect(user1).not_to be_valid
        user1 = User.create username:"Masa", password:"Secr1", password_confirmation:"Secr1"
        expect(user1).to be_valid
        user1 = User.create username:"Pekka", password:"SEc12", password_confirmation:"SEc12"
        expect(user1).to be_valid
        expect(User.count).to eq(2)
      end
      end
    end

  end

