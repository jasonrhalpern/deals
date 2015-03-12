require 'rails_helper'

describe BusinessesController do
  login_user

  let(:johns_business) { create(:business, :user => @user) }

  describe "GET #new" do
    it "assigns a new business to @business" do
      get :new
      expect(assigns(:business)).to be_a_new(Business)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #show" do
    it "assigns the requested business to @business" do
      get :show, :id => johns_business
      expect(assigns(:business)).to eq(johns_business)
    end

    it "renders the :show template" do
      get :show, :id => johns_business
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    it "assigns the requested business to @business" do
      get :edit, :id => johns_business
      expect(assigns(:business)).to eq(johns_business)
    end

    it "renders the :edit template" do
      get :edit, :id => johns_business
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new business in the database" do
        expect{
          post :create, business: attributes_for(:business, :user_id => @user, :category => johns_business.category)
        }.to change(Business, :count).by(1)
      end

      it "redirects to business#show" do
        post :create, business: attributes_for(:business, :user_id => @user, :category_id => johns_business.category.id)
        expect(response).to redirect_to business_path(assigns[:business])
      end
    end

    context "with invalid attributes" do
      it "does not save the new business in the database" do
        expect{
          post :create, business: attributes_for(:business, :name => nil)
        }.to_not change(Business, :count)
      end

      it "re-renders the :new template" do
        post :create, business: attributes_for(:business, :name => nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "changes the business" do
        patch :update, id: johns_business, business: attributes_for(:business, :name => 'My Italian Joint')
        johns_business.reload
        expect(johns_business.name).to eq('My Italian Joint')
      end

      it "redirects to the updated business" do
        patch :update, id: johns_business, business: attributes_for(:business, :user => @user)
        expect(response).to redirect_to business_path(assigns[:business])
      end
    end

    context "with invalid attributes" do
      it "does not change the business" do
        patch :update, id: johns_business, business: attributes_for(:business, :name => nil, :website => 'http://www.myitalianjoint.com')
        johns_business.reload
        expect(johns_business.website).to_not eq('http://www.myitalianjoint.com')
      end

      it "re-renders the edit template" do
        patch :update, id: johns_business, business: attributes_for(:business, :name => nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @my_business = create(:business, :user => @user)
    end

    it "deletes the business" do
      expect{
        delete :destroy, id: @my_business
      }.to change(Business, :count).by(-1)
    end

    it "redirects to business#show" do
      delete :destroy, id: @my_business
      expect(response).to redirect_to new_business_path
    end
  end


end
