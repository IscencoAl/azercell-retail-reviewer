require 'rails_helper'


RSpec.describe DealersController, :type => :controller do

  describe "GET index" do
    it "populates an array of dealers" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      get :index
      expect(assigns(:dealers)).to eq([dealer])
    end

    it "filters dealer" do
      admin = create(:user, :admin)
      sign_in admin

      dealer = create(:dealer, :name => "West")

      get :index, {:filter => {:name => "West"}}
      expect(assigns(:dealers)).to eq([dealer])
    end

    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new dealer as a @dealer" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      get :new
      expect(assigns(:dealer)).to be_a_new(Dealer)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested dealer as @dealer" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      get :edit, {:id => dealer.to_param}
      expect(assigns(:dealer)).to eq(dealer)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      get :edit, {:id => dealer.to_param}
      expect(response).to render_template(:edit)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new dealer" do
        user = create(:user, :admin)
        sign_in user
       
        expect {
          post :create, {:dealer => FactoryGirl.build(:dealer).attributes.symbolize_keys}
        }.to change(Dealer, :count).by(1)
      end

      it "assigns a newly created dealer as @dealer" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:dealer => FactoryGirl.build(:dealer).attributes.symbolize_keys}
        expect(assigns(:dealer)).to be_a(Dealer)
        expect(assigns(:dealer)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:dealer => FactoryGirl.build(:dealer).attributes.symbolize_keys}
        expect(response).to redirect_to(dealers_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved dealer as @dealer" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:dealer => FactoryGirl.attributes_for(:dealer, :invalid)}
        expect(assigns(:dealer)).to be_a(Dealer)
        expect(assigns(:dealer)).not_to be_persisted
      end

      it "assigns a newly created dealer as @dealer" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:dealer => FactoryGirl.attributes_for(:dealer, :invalid)}
        expect(assigns(:dealer)).to be_a_new(Dealer)
      end

      it "re-renders the new view" do
        user = create(:user, :admin)
        sign_in user
        
        post :create, {:dealer => FactoryGirl.attributes_for(:dealer, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an dealer" do
        user = create(:user, :admin)
        sign_in user

        dealer = create(:dealer)

        put :update, {:id => dealer.to_param, :dealer => {:name => 'Sorochi'}}
        dealer.reload

        expect(dealer.name).to eq('Sorochi')
      end

      it "assigns the requested dealer as @dealer" do
        user = create(:user, :admin)
        sign_in user

        dealer = create(:dealer)

        put :update, {:id => dealer.to_param, :dealer => FactoryGirl.attributes_for(:dealer)}
        expect(assigns(:dealer)).to eq(dealer)
      end
      
      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        dealer = create(:dealer)

        put :update, {:id => dealer.to_param, :dealer => FactoryGirl.attributes_for(:dealer)}
        expect(response).to redirect_to(dealers_url)
      end
    end

    context "with invalid params" do
      it "assigns the requested dealer as @dealer" do
        user = create(:user, :admin)
        sign_in user

        dealer = create(:dealer)

        put :update, {:id => dealer.to_param, :dealer => FactoryGirl.attributes_for(:dealer, :invalid)}
        expect(assigns(:dealer)).to eq(dealer)
      end

      it "re-renders the edit view" do
        user = create(:user, :admin)
        sign_in user

        dealer = create(:dealer)

        put :update, {:id => dealer.to_param, :dealer => FactoryGirl.attributes_for(:dealer, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested dealer" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      delete :destroy, {:id => dealer.to_param}
      dealer.reload

      expect(dealer.is_deleted).to be_truthy
    end

    it "redirects to the dealer list" do
      user = create(:user, :admin)
      sign_in user

      dealer = create(:dealer)

      delete :destroy, {:id => dealer.to_param}
      expect(response).to redirect_to(dealers_url)
    end
  end

  describe "GET restore" do
    it "sets is_deleted in false for the requested dealer" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_dealer =  create(:dealer, :deleted)

      get :restore, {:id => deleted_dealer.to_param}
      deleted_dealer.reload

      expect(deleted_dealer.is_deleted).to be_falsey
    end

    it "redirects to the users list" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_dealer =  create(:dealer, :deleted)

      get :restore, {:id => deleted_dealer = create(:dealer, :deleted).to_param}
      expect(response).to redirect_to(dealers_url)
    end
  end


end
