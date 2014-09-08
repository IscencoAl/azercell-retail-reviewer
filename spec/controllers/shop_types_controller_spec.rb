require 'rails_helper'


RSpec.describe ShopTypesController, :type => :controller do

  describe "GET index" do
    it "populates an array of shop_types" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      get :index
      expect(assigns(:shop_types)).to eq([shop_type])
    end

    it "filters shop_type" do
      admin = create(:user, :admin)
      sign_in admin

      shop_type = create(:shop_type, :name => "West")

      get :index, {:filter => {:name => "West"}}
      expect(assigns(:shop_types)).to eq([shop_type])
    end

    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new shop_type as a @shop_type" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      get :new
      expect(assigns(:shop_type)).to be_a_new(ShopType)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested shop_type as @shop_type" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      get :edit, {:id => shop_type.to_param}
      expect(assigns(:shop_type)).to eq(shop_type)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      get :edit, {:id => shop_type.to_param}
      expect(response).to render_template(:edit)
    end
  end


  describe "POST create" do
    context "with valid params" do
      it "creates a new shop_type" do
        user = create(:user, :admin)
        sign_in user
       
        expect {
          post :create, {:shop_type => FactoryGirl.build(:shop_type).attributes.symbolize_keys}
        }.to change(ShopType, :count).by(1)
      end

      it "assigns a newly created shop_type as @shop_type" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop_type => FactoryGirl.build(:shop_type).attributes.symbolize_keys}
        expect(assigns(:shop_type)).to be_a(ShopType)
        expect(assigns(:shop_type)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop_type => FactoryGirl.build(:shop_type).attributes.symbolize_keys}
        expect(response).to redirect_to(shop_types_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shop_type as @shop_type" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop_type => FactoryGirl.attributes_for(:shop_type, :invalid)}
        expect(assigns(:shop_type)).to be_a(ShopType)
        expect(assigns(:shop_type)).not_to be_persisted
      end

      it "assigns a newly created shop_type as @shop_type" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:shop_type => FactoryGirl.attributes_for(:shop_type, :invalid)}
        expect(assigns(:shop_type)).to be_a_new(ShopType)
      end

      it "re-renders the new view" do
        user = create(:user, :admin)
        sign_in user
        
        post :create, {:shop_type => FactoryGirl.attributes_for(:shop_type, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an shop_type" do
        user = create(:user, :admin)
        sign_in user

        shop_type = create(:shop_type)

        put :update, {:id => shop_type.to_param, :shop_type => {:name => 'Sorochi'}}
        shop_type.reload

        expect(shop_type.name).to eq('Sorochi')
      end

      it "assigns the requested shop_type as @shop_type" do
        user = create(:user, :admin)
        sign_in user

        shop_type = create(:shop_type)

        put :update, {:id => shop_type.to_param, :shop_type => FactoryGirl.attributes_for(:shop_type)}
        expect(assigns(:shop_type)).to eq(shop_type)
      end
      
      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        shop_type = create(:shop_type)

        put :update, {:id => shop_type.to_param, :shop_type => FactoryGirl.attributes_for(:shop_type)}
        expect(response).to redirect_to(shop_types_url)
      end
    end

    context "with invalid params" do
      it "assigns the requested shop_type as @shop_type" do
        user = create(:user, :admin)
        sign_in user

        shop_type = create(:shop_type)

        put :update, {:id => shop_type.to_param, :shop_type => FactoryGirl.attributes_for(:shop_type, :invalid)}
        expect(assigns(:shop_type)).to eq(shop_type)
      end

      it "re-renders the edit view" do
        user = create(:user, :admin)
        sign_in user

         shop_type = create(:shop_type)

        put :update, {:id => shop_type.to_param, :shop_type => FactoryGirl.attributes_for(:shop_type, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested shop_type" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      delete :destroy, {:id => shop_type.to_param}
      shop_type.reload

      expect(shop_type.is_deleted).to be_truthy
    end

    it "redirects to the shop_type list" do
      user = create(:user, :admin)
      sign_in user

      shop_type = create(:shop_type)

      delete :destroy, {:id => shop_type.to_param}
      expect(response).to redirect_to(shop_types_url)
    end
  end

  describe "GET restore" do
    it "sets is_deleted in false for the requested shop_type" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_shop_type =  create(:shop_type, :deleted)

      get :restore, {:id => deleted_shop_type.to_param}
      deleted_shop_type.reload

      expect(deleted_shop_type.is_deleted).to be_falsey
    end

    it "redirects to the shop_types list" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_shop_type =  create(:shop_type, :deleted)

      get :restore, {:id => deleted_shop_type = create(:shop_type, :deleted).to_param}
      expect(response).to redirect_to(shop_types_url)
    end
  end

end
