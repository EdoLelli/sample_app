require 'spec_helper'

describe "Authentication" do
   subject {page}
  describe "sign in page" do
    before {visit signin_path}
   
    
    it {should have_title('Sign In')}
    it {should have_content('Sign In')}
  
  describe "when authentication failed (uncorrect email or password)" do
     before {click_button 'Sign In'}
     it {should have_title('Sign In')}
     it{should have_selector('div.alert.alert-error', text: 'Invalid email/password combination')}
     describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "when authentication is correct" do
       let(:user) {FactoryGirl.create :user}
       before {sign_in user}
       it {should have_title(user.name)}
       it {should have_content(user.name)}
       it {should have_link('Profile', href: user_path(user))}
       it {should have_link('Settings', href: edit_user_path(user))}
       it {should have_link('Sign out', href: signout_path)}
       it {should have_link('Users', href: users_path)}
       it {should_not have_link('Sign in', href: signin_path)}
       
   describe "following the sign out" do
     before {click_link "Sign out"}
     it {should have_link('Sign in')}
   end
  end
  end
  describe "authorization" do
    describe "for non-signed-users" do
      let(:user) {FactoryGirl.create :user}
            describe "in the Users controller" do
        describe "visiting the edit page" do
    before {visit edit_user_path(user)}
    it {should have_title("Sign In")}
  end
  describe "testing the update action" do
    before {patch user_path(user)}
    specify { expect(response).to redirect_to signin_path}
  end
  describe "when attempting to visit a protected page" do
    before {visit edit_user_path(user)}
    describe "after signing in" do
      before {sign_in user}
      it {should have_title("Edit")}
    end
  end
  describe "" do
    before {visit users_path}
    it {should have_selector("div.alert.alert-notice", text: "Before you have to Sign in!")}
  end
  describe "that try to manipulate their posts" do
    describe "sending a create request" do
    before {post microposts_path}
    specify {expect(response).to redirect_to signin_path}  
    end
    describe "sending a delete request" do
    let(:micropost) {FactoryGirl.create(:micropost, user: user)}
    before {delete micropost_path(micropost)}
    specify {expect(response).to redirect_to signin_path}
  end
  end
    end  
    end 
    
    
     describe "with the wrong user" do
       let(:user) {FactoryGirl.create :user}
       let(:wrong_user) {FactoryGirl.create :user, email: "wrong@example.it"}
       before {sign_in user, no_capybara: true}
       describe "that try to edit another user" do
         before {get edit_user_path(wrong_user)}
         
         specify {expect(response).to redirect_to root_path}
       end
       describe "with the update action" do
         before {patch user_path(wrong_user)}
         specify {expect(response).to redirect_to root_path}
       end
     end
    describe "for non admin users" do
      let(:user) {FactoryGirl.create :user}
      let(:non_admin_user) {FactoryGirl.create :user}
      before {sign_in non_admin_user, no_capybara: true} 
    
    describe "that try to send a delete request" do
        before {delete user_path(user)}
        specify {expect(response).to redirect_to root_path}
        end
   end
   end
   
  end
  
