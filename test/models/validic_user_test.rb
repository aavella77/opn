require "test_helper"

class ValidicUserTest < ActiveSupport::TestCase


  def setup
    skip_if_disabled
    @user = users(:user_1)
    @user.delete_all_validic_users
  end


  def teardown
    skip_if_disabled
    @user.delete_all_validic_users
  end


  def check_alive
    skip_if_disabled

    assert User.check_validic_alive
  end

  def test_validic
    skip # This test should be skipped until it is fixed (should be able to assert test with VALIDIC ENABLED OR DISABLED)
    # Rewrite should include modifiable validic configuration (from application.yml), and in test setting of the variable
    skip_if_disabled

    @user.provision_validic_user
    assert @user.validic_user?, "User should be a validic user after provisioning"

    @user.delete_validic_user
    assert_not @user.validic_user?, "User should not be a validic user after deprovisioning"

    @user.provision_validic_user
    assert @user.validic_user?, "User should be a validic user after provisioning"
  end





  def skip_if_disabled
    skip "Validic is not enabled so we are skipping this test, since it tests the Validic module." if !Figaro.env.validic_enabled
  end



end
