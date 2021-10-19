require 'rails_helper'

RSpec.feature "Visitors can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path
    
    first('a.btn-default').click
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
  end
end
