require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Saving User Tests
  test "should not save user without email" do
    u = User.new
    u.first_name = 'first'
    u.last_name = 'last'
    u.password = 'password'
    u.password_confirmation = 'password'
    assert !u.save, "User saved without email"
  end
  
  test "should not save user without first name" do
    u = User.new
    u.email = 'test@test.com'
    u.last_name = 'last'
    u.password = 'password'
    u.password_confirmation = 'password'
    assert !u.save, "User saved without first_name"
  end
  
  test "should not save user without last name" do
    u = User.new
    u.email = 'test@test.com'
    u.first_name = 'first'
    u.password = 'password'
    u.password_confirmation = 'password'
    assert !u.save, "User saved without last_name"
  end
  
  test "should not save user without password" do
    u = User.new
    u.email = 'test@test.com'
    u.first_name = 'first'
    u.last_name = 'last'
    u.password_confirmation = 'password'
    assert !u.save, "User saved without password"
  end
  
  test "should save user with valid profile" do
    u = User.new
    u.email = 'test@test.com'
    u.first_name = 'first'
    u.last_name = 'last'
    u.password = 'password'
    u.password_confirmation = 'password'
    assert u.save, "User not saved with valid profile"
  end

end
