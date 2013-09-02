require 'spec_helper'

describe Backend::UsersController do

  let!(:user) {mock_model(User).as_null_object}
  let(:test_user) {FactoryGirl.create(:valid_user)}

  shared_examples_for "render template" do |template|
    it "with #{template}" do
      expect(response).to render_template template
    end

    it "assigns @user to #{template}" do
      expect(assigns[:user]).to eq(user)
    end
  end

  shared_examples_for "access denied" do
    it "redirect to root" do
      expect(response).to redirect_to root_path
    end

    it "render alert" do
      expect(flash[:alert]).not_to be_nil
    end
  end

  shared_examples_for "404" do
    it "render error template" do
      expect(response).to render_template(file: 'public/404')
    end
  end

  context "with admin role" do
    login_as_god

    it "have admin privileges" do
      expect{current_user.role? :admin}.to be_true
    end

    describe "#index" do
      before :each do
        @user1, @user2 = FactoryGirl.create(:valid_user), FactoryGirl.create(:valid_user)
        get :index
      end

      it "contains existing users" do
        expect(assigns[:user]).to include(@user1, @user2)
      end

      it "with index template" do
        expect(response).to render_template :index
      end
    end

    describe "#show" do
      before :each do
        User.stub(:find).and_return(user)
      end

      it "sends find" do
        User.should_receive(:find).with(test_user.id.to_s)
        get :show, id: test_user
      end

      it_behaves_like "render template", 'show' do
        before {get :show, id: test_user}
      end

      context "when record not found" do
        it_behaves_like "404" do
          before {get :show, id: 1001}
        end
      end
    end

    describe "#edit" do
      before :each do
        User.stub(:find).and_return(user)
      end

      it "sends find" do
        User.should_receive(:find).with(test_user.id.to_s)
        get :edit, id: test_user
      end

      it_behaves_like "render template", 'edit' do
        before {get :edit, id: test_user}
      end

      context "when record not found" do
        it_behaves_like "404" do
          before {get :edit, id: 1001}
        end
      end
    end

    describe "#update" do
      before :each do
        User.stub(:find).and_return(user)
      end

      it "sends find" do
        User.should_receive(:find).with(test_user.id.to_s)
        put :update, id: test_user, user: test_user[:name] = 'NEW_USER_NAME'
      end

      context "return true" do

        let!(:new_user) {FactoryGirl.create(:valid_user)}

        before :each do
          User.stub(:update_attributes).and_return(true)
          put :update, id: test_user, user: new_user
        end

        it "update user data" do
          expect(User.find_by_name(new_user.name)).not_to be_nil
        end

        it "redirect to show" do
          expect(response).to redirect_to backend_users_path
        end

        it "render success message" do
          expect(flash[:notice]).not_to be_nil
        end
      end
    end

    describe "#privileges" do

      let!(:role) {mock_model(Role)}

      before :each do
        User.stub(:find).and_return(user)
        Role.stub(:find).and_return(role)
      end

      it "sends find" do
        User.should_receive(:find).with(test_user.id.to_s)
        get :privileges, user_id: test_user
      end

      it_behaves_like "render template", 'privileges' do
        before {get :privileges, user_id: test_user}
      end

      xit "assigns @roles to view" do
        get :privileges, user_id: test_user
        expect(assigns[:roles]).to eq role
      end

      context "when record not found" do
        it_behaves_like "404" do
          before {get :privileges, user_id: 1001}
        end
      end
    end

    describe "#destroy" do
      before :each do
        User.stub(:find).and_return(user)
      end

      it "sends find" do
        User.should_receive(:find).with(test_user.id.to_s)
        delete :destroy, id: test_user
      end

      context "return true" do
        before :each do
          User.stub(:destroy).and_return(true)
        end

        it "delete user" do
          expect{delete :destroy, id: test_user}.to change(User, :count).by(1)
        end

        it "redirect to index" do
          delete :destroy, id: test_user
          expect{response}.to redirect_to backend_users_path
        end

        it "render notice" do
          delete :destroy, id: test_user
          expect{flash[:notice]}.not_to be_nil
        end
      end

      context "return false" do
        before :each do
          User.stub(:destroy).and_return(false)
          get :destroy, id: test_user
        end

        it "delete user" do
          expect{delete :destroy, id: test_user}.not_to change(User, :count)
        end

        it "redirect to index" do
          expect{response}.to redirect_to backend_users_path
        end
      end
    end
  end

  context "with user role" do

    login_as_user

    it "have user privileges" do
      expect{current_user.role? :user}.to be_true
    end

    describe "#index" do
      it_behaves_like "access denaied" do
        before {get :index}
      end
    end

    describe "#show" do
      it_behaves_like "access denaied" do
        before {get :show, id: test_user}
      end
    end

    describe "#edit" do
      it_behaves_like "access denaied" do
        before {get :show, id: test_user}
      end
    end

    describe "#destroy" do
      it_behaves_like "access denaied" do
        before {delete :destroy, id: test_user}
      end
    end

    describe "#privileges" do
      it_behaves_like "access denaied" do
        before {get :privileges, user_id: test_user}
      end
    end

    describe "#update" do
      it_behaves_like "access denaied" do
        before {put :update, id: test_user, user: test_user}
      end
    end
  end
end