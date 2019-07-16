require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

    # SETUP
    before :each do
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

    scenario "They see product detail" do
      # ACT
      visit root_path

      first('article.product').find_link('Details').click

      sleep 3
  
      # DEBUG / VERIFY
      save_screenshot "productDetails.png"
  
      expect(page).to have_css 'article.product-detail', count: 1
    end

end
