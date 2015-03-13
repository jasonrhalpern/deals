require 'rails_helper'

describe DealsController do
  login_user

  let(:johns_deal) { create(:deal, :business => create(:business, :user => @user)) }

  describe "GET #index" do
    it "populates an array of all the deals" do
      business = create(:business, :user => @user)
      deal_one = create(:deal, :business => business)
      deal_two = create(:deal, :business => business)
      get :index, :business_id => business.id
      expect(assigns(:deals)).to match_array([deal_one, deal_two])
    end

    it "renders the :index template" do
      get :index, :business_id => johns_deal.business_id
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "assigns a new deal to @deal" do
      get :new, :business_id => johns_deal.business_id
      expect(assigns(:deal)).to be_a_new(Deal)
    end

    it "renders the :new template" do
      get :new, :business_id => johns_deal.business_id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) do
      @my_business = create(:business, :user => @user)
    end

    context "with valid attributes" do
      it "saves the new deal in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               deal: attributes_for(:deal, :business => @my_business)
        }.to change(Deal, :count).by(1)
      end

      it "redirects to deals#index" do
        post :create, :business_id => @my_business.id,
             deal: attributes_for(:deal, :business => @my_business)
        expect(response).to redirect_to business_deals_path(@my_business)
      end
    end

    context "with invalid attributes" do
      it "does not save the new deal in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               deal: attributes_for(:deal, :start_date => nil)
        }.to_not change(Deal, :count)
      end

      it "re-renders the :new template" do
        post :create, :business_id => @my_business.id,
             deal: attributes_for(:deal, :start_date => nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested deal to @deal" do
      get :edit, :business_id => johns_deal.business_id, :id => johns_deal
      expect(assigns(:deal)).to eq(johns_deal)
    end

    it "renders the :edit template" do
      get :edit, :business_id => johns_deal.business_id, :id => johns_deal
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "changes the deal" do
        patch :update, :business_id => johns_deal.business_id, :id => johns_deal,
              deal: attributes_for(:deal, :start_date => 4.days.ago.to_date)
        johns_deal.reload
        expect(johns_deal.start_date).to eq(4.days.ago.to_date)
      end

      it "redirects to the updated deals" do
        patch :update, :business_id => johns_deal.business_id, :id => johns_deal,
              deal: attributes_for(:deal, :start_date => 4.days.ago.to_date)
        expect(response).to redirect_to business_deals_path(johns_deal.business)
      end
    end

    context "with invalid attributes" do
      it "does not change the deal" do
        patch :update, :business_id => johns_deal.business_id, :id => johns_deal,
              deal: attributes_for(:deal, :start_date => 4.days.ago.to_date, :end_date => nil)
        johns_deal.reload
        expect(johns_deal.start_date).to_not eq(4.days.ago.to_date)
      end

      it "re-renders the edit template" do
        patch :update, :business_id => johns_deal.business_id, :id => johns_deal,
              deal: attributes_for(:deal, :start_date => 4.days.ago.to_date, :end_date => nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @my_deal = create(:deal, :business => create(:business, :user => @user))
    end

    it "deletes the deal" do
      expect{
        delete :destroy, :business_id => @my_deal.business_id, id: @my_deal
      }.to change(Deal, :count).by(-1)
    end

    it "redirects to deals#index" do
      delete :destroy, :business_id => @my_deal.business_id, id: @my_deal
      expect(response).to redirect_to business_deals_path
    end
  end


end
