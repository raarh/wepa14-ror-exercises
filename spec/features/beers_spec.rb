require 'spec_helper'
include OwnTestHelper


describe "Beer page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }


  it "Beer is created, only if it is named" do

    visit new_beer_path
    fill_in('beer[name]', with:'Iso 3')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end
  it "Unnamed beer returns an error" do

    visit new_beer_path
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.not_to change{Beer.count}
    expect(page).to have_content "Name can't be blank"
  end


end