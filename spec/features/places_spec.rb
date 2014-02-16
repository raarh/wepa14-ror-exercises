require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if more than one is  returned by the API, all of them are shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"),Place.new(:name => "Oljenkorsi2") ]
    )


    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Oljenkorsi2"
  end
  it "if none is returned by the API, \"No locations in <>\"is shown" do
    BeermappingApi.stub(:places_in).with("rauma").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'rauma')
    click_button "Search"

    expect(page).to have_content "No locations in rauma"

  end
end
