require 'rails_helper'

describe "Ability" do
  describe "User" do
    before(:each) do
      @user = create(:user)
      @user_two = create(:user)
      @ability = Ability.new(@user)
    end

    it "can crud himself, but not other users" do
      assert @ability.can?(:crud, @user)
      assert @ability.cannot?(:crud, User.new)
      assert @ability.cannot?(:crud, @user_two)
    end
  end

  describe "Admin" do
    before(:each) do
      @admin = create(:admin)
      @ability = Ability.new(@admin)
    end

    it "can crud himself and other users" do
      assert @ability.can?(:crud, @admin)
      assert @ability.can?(:crud, User.new)
    end
  end
end