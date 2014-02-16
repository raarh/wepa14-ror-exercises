require 'spec_helper'
include OwnTestHelper


describe "Rating page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    create_material
    beer1 = Beer.first
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.rating_average).to eq(15.0)
  end
  it "lists ratings and tells number of ratings" do
    create_material
    beer1 = Beer.first
    beer2 = Beer.last
    visit ratings_path
    expect(page).to have_content "Number of ratings 0"
    FactoryGirl.create(:rating, score:25, beer:beer1, user:user)
    visit ratings_path
    expect(page).to have_content "Number of ratings #{Rating.count}"
    expect(page).to have_content "iso 3, 25 Pekka"
    FactoryGirl.create(:rating, score:21, beer:beer2, user:user)
    visit ratings_path
    expect(page).to have_content "Number of ratings #{Rating.count}"
    expect(page).to have_content "iso 3, 25 Pekka"
    expect(page).to have_content "Karhu, 21 Pekka"
  end
end

def create_material
  style = Style.create style:"Lager"
  Beer.create(name:"iso 3", brewery_id:brewery.id,style_id:style.id)
  Beer.create(name:"Karhu", brewery_id:brewery.id,style_id:style.id)

end