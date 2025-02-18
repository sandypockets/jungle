require "rails_helper"

RSpec.feature "Users can navigate from the home page.", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
        )
    end
  end

  scenario "They go to the product detail page by clicking on a product" do
    # ACT
    visit root_path
    # Find the first matching "Details »" link and click it
    first(:link, "Details »").click
    # VERIFY
    puts page.html
    expect(page).to have_css(".products-show", count: 1)

    # DEBUG
    save_screenshot
  end
end