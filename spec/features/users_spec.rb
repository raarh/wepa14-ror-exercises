require 'spec_helper'
include OwnTestHelper

describe "User (page)" do
  before :each do
    @user = FactoryGirl.create :user
    @brewery = FactoryGirl.create :brewery, name:"Koff"
    @lager = Style.create style:"Lager"
    @beer1 = create_beer_with_style_and_rating(@lager,"Iso 3",@user,@brewery, 10)
    @beer2 = create_beer_with_style_and_rating(@lager,"Karhu",@user,@brewery, 25)

  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "can join to a club" do
      b= FactoryGirl.create :beerclub, name:"Testi"
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_membership_path
      select("Testi", from:"membership[beer_club_id]")
      expect{
        click_button "Create Membership"
      }.to change{Membership.count}.from(0).to(1)

    end
  end
  it "is redirected back to signin form if wrong credentials given" do
    sign_in(username:"Pekka", password:"Wrong")
    expect(current_path).to eq(signin_path)
    expect(page).to have_content 'Username and password do not match'

  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
  it "user's ratings are listen on the user's page" do

    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    FactoryGirl.create(:rating, score:21, beer:@beer2 , user:@user)
    visit user_path(@user)
    expect(page).to have_content "Ratings"
    expect(page).to have_content "Iso 3, 25"
    expect(page).to have_content "Karhu, 21"
  end
  it "when user deletes rating,it is removed from database" do
    user = FactoryGirl.create(:user, username:"teri",password:"Foobar1",  password_confirmation:"Foobar1")
    create_beer_with_style_and_rating(@lager,"Iso3",user,@brewery, 10)
    sign_in(username:"teri", password:"Foobar1")

    visit user_path(user)
    expect{
    click_link "delete"
    }.to change{Rating.count}.from(3).to(2)

  end
  it "user's favorite brewery is printed on the user's page" do
    brewery2 = FactoryGirl.create :brewery, name:"Testimo"
    create_beer_with_style_and_rating(@lager,"La Sol",@user,brewery2, 45)
    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    visit user_path(@user)
    expect(page).to have_content "Favorite brewery: Koff"
    create_beer_with_style_and_rating(@lager,"Teron olut",@user,brewery2, 45)
    visit user_path(@user)
    expect(page).to have_content "Favorite brewery: Testimo"
  end
  it "user's favorite brewery is printed on the user's page" do
    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    visit user_path(@user)
    expect(page).to have_content "Favorite style: Lager"
  end
  it "User without ratings does not have favorite style or favorite brewery" do
    user = FactoryGirl.create(:user, username:"testi",password:"Foobar1",  password_confirmation:"Foobar1")
    visit user_path(user)
    expect(page).not_to have_content "Favorite style"
    expect(page).not_to have_content "Favorite brewery"
  end
end
