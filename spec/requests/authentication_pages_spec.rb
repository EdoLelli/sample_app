require 'spec_helper'

describe "Authentication" do
  describe "sign in page" do
    before {visit signin_path}
    subject {page}
    
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
       before do
         fill_in 'Email', with: user.email
         fill_in 'Password', with: user.password
         click_button 'Sign In'
       end
       it {should have_title(user.name)}
       it {should have_content(user.name)}
       it {should have_link('Profile', href: user_path(user))}
       it {should have_link('Sign out', href: signout_path)}
       it {should_not have_link('Sign in', href: signin_path)}
       
   describe "following the sign out" do
     before {click_link "Sign out"}
     it {should have_link('Sign in')}
   end
   
  end
  end
  end
