require 'spec_helper'
include OwnTestHelper


describe "Beer club" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }


  it " is created, only if it is named ja it has city" do
    sign_in(username:"Pekka", password:"Foobar1")
    alku = BeerClub.count
    visit new_beer_club_path
    fill_in('beer_club[name]', with:'Kerhotesti')
    fill_in('beer_club[founded]', with:1990)
    fill_in('beer_club[city]', with:'Tampere')

    expect{
      click_button "Create Beer club"
    }.to change{BeerClub.count}.from(alku).to(alku+1)

  end
  it "Unnamed club returns an error" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_club_path
    fill_in('beer_club[founded]', with:1990)
    fill_in('beer_club[city]', with:'Tampere')

    expect{
      click_button "Create Beer club"
    }.not_to change{BeerClub.count}
    expect(page).to have_content "Name can't be blank"

  end
  it "must have year in founded" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_club_path
    fill_in('beer_club[name]', with:'Kerhotesti 2')
    fill_in('beer_club[city]', with:'Tampere')

    expect{
      click_button "Create Beer club"
    }.not_to change{BeerClub.count}
    expect(page).to have_content "Founded can't be blank"

    visit new_beer_club_path
    fill_in('beer_club[name]', with:'Kerho 12')
    fill_in('beer_club[founded]', with:1990)
    fill_in('beer_club[city]', with:'Tampere')

    expect{
      click_button "Create Beer club"
    }.to change{BeerClub.count}


end
    it "must founded with a number" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_beer_club_path
      fill_in('beer_club[name]', with:'Kerhotesti 3')
      fill_in('beer_club[city]', with:'Tampere')
      fill_in('beer_club[founded]', with:"Masa")
      expect{
        click_button "Create Beer club"
      }.not_to change{BeerClub.count}
      expect(page).to have_content "Founded is not a number"
    end


end