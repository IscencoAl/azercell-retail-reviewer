require 'rails_helper'


RSpec.describe ShopsController, :type => :controller do

  describe "GET index" do
    it "populates an array of shops" do
      user = create(:user, :admin)
      sign_in user

      shop = create(:shop)

      get :index
      expect(assigns(:shops)).to eq([shop])
    end

    it "filters shops" do
      admin = create(:user, :admin)
      sign_in admin
      shop_type = create(:shop_type)
      shop = create(:shop,  :shop_type => shop_type)

      get :index, {:filter => {:shop_type => shop_type.id}}
      expect(assigns(:shops)).to eq([shop])
    end



    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new shop as @shop" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(assigns(:shop)).to be_a_new(Shop)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested shop as @shop" do
      user = create(:user, :admin)
      sign_in user

      shop = create(:shop)

      get :edit, {:id => shop.to_param}
      expect(assigns(:shop)).to eq(shop)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      shop = create(:shop)

      get :edit, {:id => shop.to_param}
      expect(response).to render_template(:edit)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Shop" do
        user = create(:user, :admin)
        sign_in user
       
        expect {
          post :create, {:shop => FactoryGirl.build(:shop).attributes.symbolize_keys}
        }.to change(Shop, :count).by(1)
      end

      it "assigns a newly created shop as @shop" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop => FactoryGirl.build(:shop).attributes.symbolize_keys}
        expect(assigns(:shop)).to be_a(Shop)
        expect(assigns(:shop)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop => FactoryGirl.build(:shop).attributes.symbolize_keys}
        expect(response).to redirect_to(shops_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shop as @shop" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop => FactoryGirl.attributes_for(:shop, :invalid)}
        expect(assigns(:shop)).to be_a(Shop)
        expect(assigns(:shop)).not_to be_persisted
      end

      it "assigns a newly created shop as @shop" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop => FactoryGirl.attributes_for(:shop, :invalid)}
        expect(assigns(:shop)).to be_a_new(Shop)
      end

      it "re-renders the new view" do
        user = create(:user, :admin)
        sign_in user
        
        post :create, {:shop => FactoryGirl.attributes_for(:shop, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an shop" do
        user = create(:user, :admin)
        sign_in user

        shop_type = create(:shop_type)
        shop = create(:shop)

        put :update, {:id => shop.to_param, :shop => {:shop_type_id => shop_type.id}}
        shop.reload

        expect(shop.shop_type).to eq(shop_type)
      end

      it "assigns the requested shop as @shop" do
        user = create(:user, :admin)
        sign_in user

        shop = create(:shop)


        put :update, {:id => shop.to_param, :shop => FactoryGirl.attributes_for(:shop)}
        expect(assigns(:shop)).to eq(shop)
      end
      
      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        shop = create(:shop)

        put :update, {:id => shop.to_param, :shop => FactoryGirl.attributes_for(:shop)}
        expect(response).to redirect_to(shops_url)
      end
    end

    context "with invalid params" do
      it "assigns the requested shop as @shop" do
        user = create(:user, :admin)
        sign_in user

        shop = create(:shop)

        put :update, {:id => shop.to_param, :shop => FactoryGirl.attributes_for(:shop, :invalid)}
        expect(assigns(:shop)).to eq(shop)
      end

      it "re-renders the edit view" do
        user = create(:user, :admin)
        sign_in user

        shop = create(:shop)

        put :update, {:id => shop.to_param, :shop => FactoryGirl.attributes_for(:shop, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested shop" do
      user = create(:user, :admin)
      sign_in user

      shop = create(:shop)

      delete :destroy, {:id => shop.to_param}
      shop.reload

      expect(shop.is_deleted).to be_truthy
    end

    it "redirects to the shop list" do
      user = create(:user, :admin)
      sign_in user

      shop = create(:shop)

      delete :destroy, {:id => shop.to_param}
      expect(response).to redirect_to(shops_url)
    end
  end

  describe "GET restore" do
    it "sets is_deleted in false for the requested shop" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_shop =  create(:shop, :deleted)

      get :restore, {:id => deleted_shop.to_param}
      deleted_shop.reload

      expect(deleted_shop.is_deleted).to be_falsey
    end

    it "redirects to the shops list" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_shop =  create(:shop, :deleted)

      get :restore, {:id => deleted_shop = create(:shop, :deleted).to_param}
      expect(response).to redirect_to(shops_url)
    end
  end

end
