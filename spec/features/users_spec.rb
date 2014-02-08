require 'spec_helper'

describe "User page" do
  before :each do
    @user = FactoryGirl.create :user
    @brewery = FactoryGirl.create :brewery, name:"Koff"
    @beer1 = FactoryGirl.create :beer, name:"iso 3", brewery:@brewery
    @beer2 = FactoryGirl.create :beer, name:"Karhu", brewery:@brewery

  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
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
    expect(page).to have_content "iso 3, 25"
    expect(page).to have_content "Karhu, 21"
  end
  it "when user deletes rating,it is removed from database" do
    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    sign_in(username:"Pekka", password:"Foobar1")

    visit user_path(@user)
    expect{
    click_link "delete"
    }.to change{Rating.count}.from(1).to(0)

  end
  it "user's favorite brewery is printed on the user's page" do
    brewery2 = FactoryGirl.create :brewery, name:"Testimo"
    beer3 = FactoryGirl.create :beer, name:"La Sol", brewery:brewery2
    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    visit user_path(@user)
    expect(page).to have_content "Favorite brewery: Koff"
    FactoryGirl.create(:rating, score:45, beer:beer3, user:@user)
    visit user_path(@user)
    expect(page).to have_content "Favorite brewery: Testimo"
  end
  it "user's favorite brewery is printed on the user's page" do
    FactoryGirl.create(:rating, score:25, beer:@beer1, user:@user)
    visit user_path(@user)
    expect(page).to have_content "Favorite style: Lager"
  end
  it "User without ratings does not have favorite style or favorite brewery" do
    visit user_path(@user)
    expect(page).not_to have_content "Favorite style"
    expect(page).not_to have_content "Favorite brewery"
  end
end
