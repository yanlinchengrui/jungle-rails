require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should let you create a user' do
      @user = User.create first_name:'testing', last_name:'things', email: 'TEST@TEST.com', password: '123', password_confirmation: '123'
      expect(@user.id).to be_present
    end

    it 'should not let you create a user with password and password_confirmation are not the same' do
      @user = User.create first_name:'testing', last_name:'things', email: 'TEST@TEST.com', password: '123', password_confirmation: '456'
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'should not let you create a user without password and password_confirmation provided' do
      @user = User.create first_name:'testing', last_name:'things', email: 'TEST@TEST.com'
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'should not let you create a user with the same email' do
      @user = User.create first_name:'testing', last_name:'things', email: 'abc@abc.com', password: '123', password_confirmation: '123'
      @user2 = User.create first_name:'testing', last_name:'things', email: 'ABC@ABC.COM', password: '123', password_confirmation: '123'
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not let you create a user without email' do
      @user = User.create first_name:'testing', last_name:'things', password: '123', password_confirmation: '123'
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not let you create a user without first name' do
      @user = User.create last_name:'things', email: 'abc@abc.com', password: '123', password_confirmation: '123'
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not let you create a user without last name' do
      @user = User.create first_name:'testing', email: 'abc@abc.com', password: '123', password_confirmation: '123'
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not let you create a user with password length less than 3' do
      @user = User.create first_name:'testing', last_name:'things', email: 'abc@abc.com', password: '12', password_confirmation: '12'
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    before(:each) do
      @user = User.create first_name:'testing', last_name:'things', email: '555@555.com', password: 'password', password_confirmation: 'password'
    end
    
    it 'should not return user instance when email and password are wrong' do
      @user1 = User.authenticate_with_credentials("123@123.com", "77777")
      expect(@user1).to be_nil
    end

    it 'should not return user instance when password is wrong' do
      @user1 = User.authenticate_with_credentials("555@555.com", "66666")
      expect(@user1).to be false
    end

    it 'should return user instance when email and password are correct' do
      @user1 = User.authenticate_with_credentials("555@555.com", "password")
      expect(@user1.id).to match @user.id
      expect(@user1).to eql @user
    end

    it 'should return user instance when email and password are correct even if email contains spaces' do
      @user1 = User.authenticate_with_credentials("  555@555.com  ", "password")
      expect(@user1.id).to match @user.id
      expect(@user1).to eql @user
    end

    it 'should return user instance when email and password are correct even if email contains wrong case' do
      @user1 = User.authenticate_with_credentials("555@555.COM", "password")
      expect(@user1.id).to match @user.id
      expect(@user1).to eql @user
    end

    it 'should return user instance when email and password are correct even if email contains wrong case and spaces' do
      @user1 = User.authenticate_with_credentials(" 555@555.COM ", "password")
      expect(@user1.id).to match @user.id
      expect(@user1).to eql @user
    end
    
  end

end
