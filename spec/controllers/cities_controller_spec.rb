require 'rails_helper'


RSpec.describe CitiesController, :type => :controller do

  describe "GET index" do
    it "populates an array of cities" do
      user = create(:user, :admin)
      sign_in user

      city = create(:city)

      get :index
      expect(assigns(:cities)).to eq([city])
    end

    it "filters city" do
      admin = create(:user, :admin)
      sign_in admin

      city = create(:city, :name => "West")

      get :index, {:filter => {:name => "West"}}
      expect(assigns(:cities)).to eq([city])
    end

    it "renders the index view" do
      user = create(:user, :admin)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new city as a @city" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(assigns(:city)).to be_a_new(City)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested city as @city" do
      user = create(:user, :admin)
      sign_in user

      city = create(:city)

      get :edit, {:id => city.to_param}
      expect(assigns(:city)).to eq(city)
    end

    it "renders the new view" do
      user = create(:user, :admin)
      sign_in user

      city = create(:city)

      get :edit, {:id => city.to_param}
      expect(response).to render_template(:edit)
    end
  end


  describe "POST create" do
    context "with valid params" do
      it "creates a new City" do
        user = create(:user, :admin)
        sign_in user
       
        expect {
          post :create, {:city => FactoryGirl.build(:city).attributes.symbolize_keys}
        }.to change(City, :count).by(1)
      end

      it "assigns a newly created city as @city" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:city => FactoryGirl.build(:city).attributes.symbolize_keys}
        expect(assigns(:city)).to be_a(City)
        expect(assigns(:city)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:city => FactoryGirl.build(:city).attributes.symbolize_keys}
        expect(response).to redirect_to(cities_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved city as @city" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:city => FactoryGirl.attributes_for(:city, :invalid)}
        expect(assigns(:city)).to be_a(City)
        expect(assigns(:city)).not_to be_persisted
      end

      it "assigns a newly created city as @city" do
        user = create(:user, :admin)
        sign_in user

        post :create, {:city => FactoryGirl.attributes_for(:city, :invalid)}
        expect(assigns(:city)).to be_a_new(City)
      end

      it "re-renders the new view" do
        user = create(:user, :admin)
        sign_in user
        
        post :create, {:city => FactoryGirl.attributes_for(:city, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an city" do
        user = create(:user, :admin)
        sign_in user

        city = create(:city)

        put :update, {:id => city.to_param, :city => {:name => 'Sorochi'}}
        city.reload

        expect(city.name).to eq('Sorochi')
      end

      it "assigns the requested city as @city" do
        user = create(:user, :admin)
        sign_in user

        city = create(:city)

        put :update, {:id => city.to_param, :city => FactoryGirl.attributes_for(:city)}
        expect(assigns(:city)).to eq(city)
      end
      
      it "redirects to the index" do
        user = create(:user, :admin)
        sign_in user

        city = create(:city)

        put :update, {:id => city.to_param, :city => FactoryGirl.attributes_for(:city)}
        expect(response).to redirect_to(cities_url)
      end
    end

    context "with invalid params" do
      it "assigns the requested user as @user" do
        user = create(:user, :admin)
        sign_in user

        city = create(:city)

        put :update, {:id => city.to_param, :city => FactoryGirl.attributes_for(:city, :invalid)}
        expect(assigns(:city)).to eq(city)
      end

      it "re-renders the edit view" do
        user = create(:user, :admin)
        sign_in user

         city = create(:city)

        put :update, {:id => city.to_param, :city => FactoryGirl.attributes_for(:city, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested city" do
      user = create(:user, :admin)
      sign_in user

      city = create(:city)

      delete :destroy, {:id => city.to_param}
      city.reload

      expect(city.is_deleted).to be_truthy
    end

    it "redirects to the city list" do
      user = create(:user, :admin)
      sign_in user

      city = create(:city)

      delete :destroy, {:id => city.to_param}
      expect(response).to redirect_to(cities_url)
    end
  end

  describe "GET restore" do
    it "sets is_deleted in false for the requested city" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_city =  create(:city, :deleted)

      get :restore, {:id => deleted_city.to_param}
      deleted_city.reload

      expect(deleted_city.is_deleted).to be_falsey
    end

    it "redirects to the users list" do
      admin = create(:user, :admin)
      sign_in admin

      deleted_city =  create(:city, :deleted)

      get :restore, {:id => deleted_city = create(:city, :deleted).to_param}
      expect(response).to redirect_to(cities_url)
    end
  end

end
