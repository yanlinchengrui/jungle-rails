require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  # SETUP
  before :each do
    @user = User.create!(
      first_name: 'First User',
      last_name: 'Last User',
      email: 'first@user.com',
      password: '123456',
      password_confirmation: '123456'
    )

    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 66.99
      )
    end
  end

  scenario "They see product added to cart" do
    # ACT
    visit '/login'

    within 'form' do
      fill_in id: 'email', with: 'first@user.com'
      fill_in id: 'password', with: '123456'

      click_button 'Login!'
    end

    first('article.product').find_button('Add').click

    # DEBUG / VERIFY
    save_screenshot "productAdded.png"

    within('.navbar') do
      expect(page).to have_content 'My Cart (1)'
    end
  end
  
end
