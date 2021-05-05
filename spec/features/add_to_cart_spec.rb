require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

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


  scenario "The cart total increases by 1 when the user clicks add to cart" do
    # ACT
    visit root_path
    first(:button, 'Add').click
    # DEBUG
    sleep(1)
    save_screenshot
    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end
end