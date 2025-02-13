require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new email: "test@gmail.com", password: "1234567890", username: "Alessandro"
  end

  test "works by default" do
    assert @user.valid?
  end

  test "fails if no email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "fails if no username" do
    @user.username = nil
    assert_not @user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
