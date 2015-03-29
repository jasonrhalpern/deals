require 'rails_helper'

describe FavoritesController do
  login_user

  let(:johns_favorite) { create(:favorite, :user => @user) }

  describe "GET #index" do
    it "populates an array of all the favorites" do
      favorite_one = create(:favorite, :user => @user)
      favorite_two = create(:favorite, :user => @user)
      get :index
      expect(assigns(:favorites)).to match_array([favorite_one, favorite_two])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    before(:each) do
      @location = create(:location)
    end

    context "with valid attributes" do
      it "saves the new favorite in the database" do
        expect{
          xhr :post, :create, { user_id: @user.id, location_id: @location.id }
        }.to change(Favorite, :count).by(1)
      end

      it "returns a 200 status code" do
        xhr :post, :create, { user_id: @user.id, location_id: @location.id }
        expect(response.status).to be(200)
      end

      it "re-renders the toggle template" do
        xhr :post, :create, { user_id: @user.id, location_id: @location.id }
        expect(response).to render_template('toggle')
      end
    end

    context "with invalid attributes" do
      it "does not save the new favorite in the database" do
        expect{
          xhr :post, :create, { user_id: @user.id, location_id: nil }
        }.to_not change(Favorite, :count)
      end
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @favorite = create(:favorite, :user => @user)
    end

    it "deletes the favorite" do
      expect{
        xhr :post, :destroy, id: @favorite.id
      }.to change(Favorite, :count).by(-1)
    end

    it "returns a 200 status code" do
      xhr :post, :destroy, id: @favorite.id
      expect(response.status).to be(200)
    end

    it "re-renders the toggle template" do
      xhr :post, :destroy, id: @favorite.id
      expect(response).to render_template('toggle')
    end
  end


end
