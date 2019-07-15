require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should let you create a product' do
      @category = Category.create name:'testing'
      @product = @category.products.create name: 'Something', price: 1666, quantity: 66, description: 'wtf is this'
      expect(@product.id).to be_present
    end

    it 'should not let you create a product without name' do
      @category = Category.create name:'testing'
      @product = @category.products.create price: 1666, quantity: 66, description: 'wtf is this'  
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not let you create a product without price' do
      @category = Category.create name:'testing'
      @product = @category.products.create name: 'Something', quantity: 66, description: 'wtf is this'  
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not let you create a product without quantity' do
      @category = Category.create name:'testing'
      @product = @category.products.create name: 'Something', price: 1666, description: 'wtf is this'  
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not let you create a product without category' do
      @product = Product.create name: 'Something', price: 1666, quantity: 66, description: 'wtf is this' 
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
