require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name:"Jan", email:"jankow@email.com", password:"examplepass", password_confirmation:"examplepass")
  end

  test "name should exist" do
    @user.name = "      "
    assert_not @user.valid?
  end
  
  test "email should exist" do
    @user.email = "      "
    assert_not @user.valid?
  end
  
  test "name can't be too short" do
    @user.name = "aa"
    assert_not @user.valid?
  end
  
  test "name can't be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end
  
  test "email can't be too long" do
    @user.email = "a"*251
    assert_not @user.valid?
  end

  test "valid email adresses should be accepted" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_adr|
      @user.email = valid_adr
      assert @user.valid?, "#{valid_adr} should be valid."
    end
  end
  
  test "invalid email adresses should be rejected" do
    invalid_addresses= %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_adr|
      @user.email = invalid_adr
      assert_not @user.valid?, "#{invalid_adr} should be invalid."
    end  
  end
  
  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
    
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end