require 'rails_helper'

describe LocationsController do
  login_user

  let(:johns_location) { create(:location, :business => create(:business, :user => @user)) }

  describe "GET #index" do
    it "populates an array of all the locations" do
      business = create(:business, :user => @user)
      location_one = create(:location, :business => business)
      location_two = create(:location, :business => business)
      get :index, :business_id => business.id
      expect(assigns(:locations)).to match_array([location_one, location_two])
    end

    it "renders the :index template" do
      get :index, :business_id => johns_location.business_id
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "assigns a new location to @location" do
      get :new, :business_id => johns_location.business_id
      expect(assigns(:location)).to be_a_new(Location)
    end

    it "renders the :new template" do
      get :new, :business_id => johns_location.business_id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) do
      @my_business = create(:business, :user => @user)
    end

    context "with valid attributes" do
      it "saves the new location in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               location: attributes_for(:location, :business => @my_business)
        }.to change(Location, :count).by(1)
      end

      it "redirects to locations#index" do
        post :create, :business_id => @my_business.id,
             location: attributes_for(:location, :business => @my_business)
        expect(response).to redirect_to business_locations_path(@my_business)
      end
    end

    context "with invalid attributes" do
      it "does not save the new location in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               location: attributes_for(:location, :street => nil)
        }.to_not change(Location, :count)
      end

      it "re-renders the :new template" do
        post :create, :business_id => @my_business.id,
             location: attributes_for(:location, :street => nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested location to @location" do
      get :edit, :business_id => johns_location.business_id, :id => johns_location
      expect(assigns(:location)).to eq(johns_location)
    end

    it "renders the :edit template" do
      get :edit, :business_id => johns_location.business_id, :id => johns_location
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "changes the location" do
        patch :update, :business_id => johns_location.business_id, :id => johns_location,
              location: attributes_for(:location, :street => '8 Pond Avenue')
        johns_location.reload
        expect(johns_location.street).to eq('8 Pond Avenue')
      end

      it "redirects to the updated locations" do
        patch :update, :business_id => johns_location.business_id, :id => johns_location,
              location: attributes_for(:location, :street => '8 Pond Avenue')
        expect(response).to redirect_to business_locations_path(johns_location.business)
      end
    end

    context "with invalid attributes" do
      it "does not change the location" do
        patch :update, :business_id => johns_location.business_id, :id => johns_location,
              location: attributes_for(:location, :street => '8 Pond Avenue', :city => nil)
        johns_location.reload
        expect(johns_location.street).to_not eq('8 Pond Avenue')
      end

      it "re-renders the edit template" do
        patch :update, :business_id => johns_location.business_id, :id => johns_location,
              location: attributes_for(:location, :street => '8 Pond Avenue', :city => nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @my_location = create(:location, :business => create(:business, :user => @user))
    end

    it "deletes the location" do
      expect{
        delete :destroy, :business_id => @my_location.business_id, id: @my_location
      }.to change(Location, :count).by(-1)
    end

    it "redirects to locations#index" do
      delete :destroy, :business_id => @my_location.business_id, id: @my_location
      expect(response).to redirect_to business_locations_path
    end
  end


end
