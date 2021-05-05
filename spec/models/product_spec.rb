require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "validates name is present" do
      product = Product.create(price: 100, category: @category, quantity: 1)
      product.valid?
      errors = product.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Name can't be blank")
    end

    it "validates price is present" do
      product = Product.create(name: "Salamander Sandals", category: @category, quantity: 1)
      product.valid?
      errors = product.errors.full_messages
      expect(errors.length).to be(3)
      expect(errors[0]).to include("Price cents is not a number")
      expect(errors[1]).to include("Price is not a number")
      expect(errors[2]).to include("Price can't be blank")
    end

    it "validates quantity is present" do
      product = Product.create(name: "Salamander Sandals", price: 100, category: @category)
      product.valid?
      errors = product.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Quantity can't be blank")
    end

    it "validates category is present" do
      product = Product.create(name: "Salamander Sandals", price: 100, quantity: 1)
      product.valid?
      errors = product.errors.full_messages
      expect(errors.length).to be(1)
      expect(errors[0]).to include("Category can't be blank")
    end

  end
end
