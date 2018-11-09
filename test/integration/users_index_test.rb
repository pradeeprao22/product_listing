require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
def setup
  @user = users(:michael)
end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select
    User.paginate(page: 1).each do
      assert_select 'a[href=?]', users_path(user), text: user.username
    end

  end

end
