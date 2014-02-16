module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
  def create_beer_with_style_and_rating(style,name,user,brewery, score)
    beer = Beer.create(name:name, brewery_id:brewery.id,style_id:style.id)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end
end