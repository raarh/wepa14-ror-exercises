require 'spec_helper'
include OwnTestHelper


describe "Beer page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }


  it "Beer is created, only if it is named" do
    #Style.create style:"Lager"
    sign_in(username:"Pekka", password:"Foobar1")

    visit new_beer_path
    fill_in('beer[name]', with:'Iso 4A')
    select('Lager', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end
  it "Unnamed beer returns an error" do
    Style.create style:"Lager"
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    select('Lager', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.not_to change{Beer.count}
    expect(page).to have_content "Name can't be blank"
  end


end