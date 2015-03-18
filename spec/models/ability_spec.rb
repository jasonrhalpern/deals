require 'rails_helper'

describe "Ability" do
  describe "User" do
    before(:each) do
      @user = create(:user)
      @user_two = create(:user)
      @ability = Ability.new(@user)
      @business = create(:business, :user => @user)
      @business_two = create(:business, :user => @user_two)
    end

    it "can crud himself, but not other users" do
      assert @ability.can?(:crud, @user)
      assert @ability.cannot?(:crud, User.new)
      assert @ability.cannot?(:crud, @user_two)
    end

    it "can crud his own favorite, but not the favorites of others" do
      assert @ability.can?(:crud, Favorite.new(:user => @user))
      assert @ability.cannot?(:crud, Favorite.new)
      assert @ability.cannot?(:crud, Favorite.new(:user => @user_two))
    end

    it "can crud his own business, but not the businesses of other users" do
      assert @ability.can?(:crud, Business.new(:user => @user))
      assert @ability.cannot?(:crud, Business.new)
      assert @ability.cannot?(:crud, Business.new(:user => @user_two))
    end

    it "can crud a location of his own business, but not the locations of others" do
      assert @ability.can?(:crud, Location.new(:business => @business))
      assert @ability.cannot?(:crud, Location.new)
      assert @ability.cannot?(:crud, Location.new(:business => @business_two))
    end

    it "can crud a deal of his own business, but not the deals of others" do
      assert @ability.can?(:crud, Deal.new(:business => @business))
      assert @ability.cannot?(:crud, Deal.new)
      assert @ability.cannot?(:crud, Deal.new(:business => @business_two))
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

    it "can crud his own favorites and the favorites of others" do
      assert @ability.can?(:crud, Favorite.new(:user => @user))
      assert @ability.can?(:crud, Favorite.new)
    end

    it "can crud his own business and those of other users" do
      assert @ability.can?(:crud, Business.new(:user => @admin))
      assert @ability.can?(:crud, Business.new)
    end

    it "can crud a location of his own business and the locations of others" do
      assert @ability.can?(:crud, Location.new(:business => @business))
      assert @ability.can?(:crud, Location.new)
      assert @ability.can?(:crud, Location.new(:business => @business_two))
    end

    it "can crud a deal of his own business and the deals of others" do
      assert @ability.can?(:crud, Deal.new(:business => @business))
      assert @ability.can?(:crud, Deal.new)
      assert @ability.can?(:crud, Deal.new(:business => @business_two))
    end
  end
end