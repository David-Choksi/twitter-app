require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example', email: 'example@gmail.com',
                     password: 'hello123', password_confirmation: 'hello123')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '  '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w[user@gmail.com usER@hello.COM D_C-EN@gmail.hello.com
                        name.last@ff.ca dc+cd@gmail.us]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "Address #{valid_address.inspect} should be valid"
    end
  end

  test 'email should reject invalid addresses' do
    invalid_addresses = %w[user@gmail,com user_gmail.com user@lime. user@lime_onade.com user@lime+onade.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "Address #{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'lImEOnADE@gmaIL.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'password should have a minimum length]' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'password should be present and not blank' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

end
