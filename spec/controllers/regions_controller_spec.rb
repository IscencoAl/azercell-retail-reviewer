require 'rails_helper'


RSpec.describe RegionsController, :type => :controller do

  describe "GET index" do
    it "populates an array of regions" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      get :index
      expect(assigns(:regions)).to eq([region])
    end

    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new region as a @region" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      get :new
      expect(assigns(:region)).to be_a_new(Region)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested region as @region" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      get :edit, {:id => region.to_param}
      expect(assigns(:region)).to eq(region)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      get :edit, {:id => region.to_param}
      expect(response).to render_template(:edit)
    end
  end


  describe "POST create" do
    context "with valid params" do
      it "creates a new region" do
        user = create(:user, :admin)
        sign_in user
       
        expect {
          post :create, {:region => FactoryGirl.build(:region).attributes.symbolize_keys}
        }.to change(Region, :count).by(1)
      end

      it "assigns a newly created region as @region" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:region => FactoryGirl.build(:region).attributes.symbolize_keys}
        expect(assigns(:region)).to be_a(Region)
        expect(assigns(:region)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:region => FactoryGirl.build(:region).attributes.symbolize_keys}
        expect(response).to redirect_to(regions_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved region as @region" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:region => FactoryGirl.attributes_for(:region, :invalid)}
        expect(assigns(:region)).to be_a(Region)
        expect(assigns(:region)).not_to be_persisted
      end

      it "assigns a newly created region as @region" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:region => FactoryGirl.attributes_for(:region, :invalid)}
        expect(assigns(:region)).to be_a_new(Region)
      end

      it "re-renders the new view" do
        user = create(:user, :admin)
        sign_in user
        
        post :create, {:region => FactoryGirl.attributes_for(:region, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an region" do
        user = create(:user, :admin)
        sign_in user

        region = create(:region)

        put :update, {:id => region.to_param, :region => {:name => 'Sorochi'}}
        region.reload

        expect(region.name).to eq('Sorochi')
      end

      it "assigns the requested region as @region" do
        user = create(:user, :admin)
        sign_in user

        region = create(:region)

        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region)}
        expect(assigns(:region)).to eq(region)
      end
      
      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        region = create(:region)

        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region)}
        expect(response).to redirect_to(regions_url)
      end
    end

    context "with invalid params" do
      it "assigns the requested user as @user" do
        user = create(:user, :admin)
        sign_in user

        region = create(:region)

        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region, :invalid)}
        expect(assigns(:region)).to eq(region)
      end

      it "re-renders the edit view" do
        user = create(:user, :admin)
        sign_in user

         region = create(:region)

        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested region" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      delete :destroy, {:id => region.to_param}
      region.reload

      expect(region.is_deleted).to be_truthy
    end

    it "redirects to the region list" do
      user = create(:user, :admin)
      sign_in user

      region = create(:region)

      delete :destroy, {:id => region.to_param}
      expect(response).to redirect_to(regions_url)
    end
  end

  describe "GET restore" do
    it "sets is_deleted in false for the requested region" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_region =  create(:region, :deleted)

      get :restore, {:id => deleted_region.to_param}
      deleted_region.reload

      expect(deleted_region.is_deleted).to be_falsey
    end

    it "redirects to the users list" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_region =  create(:region, :deleted)

      get :restore, {:id => deleted_region = create(:region, :deleted).to_param}
      expect(response).to redirect_to(regions_url)
    end
  end
end
