require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET index" do
    it "populates an array of users" do
      user = create(:user)
      sign_in user

      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index view" do
      user = create(:user)
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "assignes a new user as @user" do
      user = create(:user)
      sign_in user

      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new view" do
      user = create(:user)
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assignes the requested user as @user" do
      user = create(:user)
      sign_in user

      get :edit, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end

    it "renders the new view" do
      user = create(:user)
      sign_in user

      get :edit, {:id => user.to_param}
      expect(response).to render_template(:edit)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new User" do
        user = create(:user)
        sign_in user

        expect {
          post :create, {:user => FactoryGirl.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        user = create(:user)
        sign_in user

        post :create, {:user => FactoryGirl.attributes_for(:user)}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the index" do
        user = create(:user)
        sign_in user

        post :create, {:user => FactoryGirl.attributes_for(:user)}
        expect(response).to redirect_to(users_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        user = create(:user)
        sign_in user

        post :create, {:user => FactoryGirl.attributes_for(:user, :invalid)}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).not_to be_persisted
      end

      it "assigns a newly created user as @user" do
        user = create(:user)
        sign_in user

        post :create, {:user => FactoryGirl.attributes_for(:user, :invalid)}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the new view" do
        user = create(:user)
        sign_in user
        
        post :create, {:user => FactoryGirl.attributes_for(:user, :invalid)}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates an user" do
        user = create(:user)
        sign_in user

        put :update, {:id => user.to_param, :user => {:name => 'Josh'}}
        user.reload

        expect(user.name).to eq('Josh')
      end

      it "assigns the requested user as @user" do
        user = create(:user)
        sign_in user

        put :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user)}
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the index" do
        user = create(:user)
        sign_in user

        put :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user)}
        expect(response).to redirect_to(users_url)
      end

      context "and blank password" do
        it "removes password and confirmation from params" do
          user = create(:user)
          sign_in user

          put :update, {:id => user.id, :user => FactoryGirl.attributes_for(:user, :password => "")}

          expect(controller.params[:user]).not_to include(:password, :password_confirmation)
        end
      end
    end

    context "with invalid params" do
      it "assigns the requested user as @user" do
        user = create(:user)
        sign_in user

        put :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user, :invalid)}
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the edit view" do
        user = create(:user)
        sign_in user

        put :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user, :invalid)}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "sets is_deleted in true for the requested user" do
      user = create(:user)
      sign_in user

      delete :destroy, {:id => user.to_param}
      user.reload

      expect(user.is_deleted).to be_truthy
    end

    it "redirects to the users list" do
      user = create(:user)
      sign_in user

      delete :destroy, {:id => user.to_param}
      expect(response).to redirect_to(users_url)
    end
  end

end