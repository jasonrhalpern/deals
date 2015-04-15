require 'rails_helper'

describe PaymentsController do
  login_user

  let(:johns_biz) { create(:business, :user => @user) }
  let(:johns_payment) { create(:payment, :business_id => johns_biz.id) }
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "GET #new" do
    it "assigns a new payment to @payment" do
      get :new, :business_id => johns_biz.id
      expect(assigns(:payment)).to be_a_new(Payment)
    end

    it "renders the :new template" do
      get :new, :business_id => johns_biz.id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) do
      @my_business = create(:business, :user => @user)
      @plan = stripe_helper.create_plan(:id => 'intro_plan', :interval => 'month', :amount => '395', :currency => 'usd',
                                        :trial_period_days => 30, :description => 'Deal Website Intro Plan')
      create(:plan, :stripe_plan_token => @plan.id, :description => @plan.name, :trial_days => @plan.trial_period_days,
             :interval => @plan.interval, :active => true)
    end

    context "with valid attributes" do
      it "saves the new payment in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               payment: { :stripe_card_token => stripe_helper.generate_card_token, :stripe_plan_token => @plan.id }
        }.to change(Payment, :count).by(1)
      end

      it "redirects to payments#index" do
        post :create, :business_id => @my_business.id,
             payment: { :stripe_card_token => stripe_helper.generate_card_token, :stripe_plan_token => @plan.id }
        expect(response).to redirect_to business_payments_path(@my_business)
      end
    end

    context "with invalid attributes" do
      it "does not save the new payment in the database" do
        expect{
          post :create, :business_id => @my_business.id,
               payment: { :stripe_card_token => nil, :stripe_plan_token => @plan.id }
        }.to_not change(Payment, :count)
      end

      it "re-renders the :new template" do
        post :create, :business_id => @my_business.id,
             payment: { :stripe_card_token => nil, :stripe_plan_token => @plan.id }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit_card" do
    it "assigns the requested payment to @payment" do
      get :edit_card, :business_id => johns_payment.business_id, :id => johns_payment
      expect(assigns(:payment)).to eq(johns_payment)
    end

    it "renders the :edit_card template" do
      get :edit_card, :business_id => johns_payment.business_id, :id => johns_payment
      expect(response).to render_template("edit_card")
    end
  end

  describe "GET #edit_plan" do
    # before(:each) do
    #   @my_business = create(:business, :user => @user)
    #   @plan = stripe_helper.create_plan(:id => 'intro_plan', :interval => 'month', :amount => '395', :currency => 'usd',
    #                                     :trial_period_days => 30, :description => 'Deal Website Intro Plan')
    #   create(:plan, :stripe_plan_token => @plan.id, :description => @plan.name, :trial_days => @plan.trial_period_days,
    #          :interval => @plan.interval, :active => true)
    #   card_token = stripe_helper.generate_card_token(brand: 'Visa', last4: '9191', exp_month: 1, exp_year: 2018)
    #   customer = Stripe::Customer.create(email: 'h@aol.com', plan: @plan.id, source: card_token)
    #   @payment = create(:payment, :business_id => @my_business.id, :stripe_cus_token => customer.id)
    # end

    it "assigns the requested payment to @payment" do
      get :edit_plan, :business_id => johns_payment.business_id, :id => johns_payment
      expect(assigns(:payment)).to eq(johns_payment)
    end

    it "renders the :edit_plan template" do
      get :edit_plan, :business_id => johns_payment.business_id, :id => johns_payment
      expect(response).to render_template("edit_plan")
    end
  end

end