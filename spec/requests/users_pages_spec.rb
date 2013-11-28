

require 'spec_helper'

describe "UsersPages" do
 
 subject {page}
 
  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title( 'All users') }
    it { should have_content('All users') }

    describe "pagination" do
    
  it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('Delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
       
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('Delete', match: :first) }.to change(User, :count).by(-1)
        end
        it { should_not have_link('Delete', href: user_path(admin)) }
      end
    end
  end
  
 describe "Sign up" do
   before {visit signup_path}
   it {should have_content('Sign up')}
   it {should have_title(full_title('Sign up'))}
 
 end


describe "profile page" do
  before {visit user_path(user)}
  let(:user) { FactoryGirl.create(:user) }
   it {should have_content(user.name)}
  it {should have_title(user.name)}
 end
 
 describe "sign up page" do
   let(:diff) {change(User, :count)}
   before {visit signup_path}
   describe "when filling in the fields is not valid" do
     it do
   expect {click_button "Create my account"}.not_to diff
     end
 describe 'after submission' do
   before {click_button "Create my account"}
   it {should have_title('Sign up')}
   it {should have_content('error')}
    end
 end
   describe "when filling in the fields is valid" do
   before do
     fill_in "Name",           with: "Dedo"
     fill_in "Email",          with: "dedo@example.org"
     fill_in "Password",       with: "pazzopazzini"
     fill_in "Confirmation",   with: "pazzopazzini"
     end
     it do 
       expect {click_button "Create my account"}.to diff.by(1) 
       end
    
     describe "after savung the user" do
       before {click_button "Create my account"}
       let(:user) {User.find_by(email:"dedo@example.org")}
       it {should have_title(user.name)}
       it {should have_selector('div.alert.alert-success', text: "Welcome to my Sample App!")}
     end
   end
 end
 
 describe "edit" do
   let(:user) { FactoryGirl.create(:user) }
   before do
     sign_in(user)
     visit edit_user_path(user)
   end
   it {should have_content("Update your profile")}
   it {should have_title("Edit Page")}
   it {should have_link("Change", href: "https://it.gravatar.com/emails")}
 
   describe "when the edit isn't correct" do
     before {click_button "Edit my account"}
     it {should have_content("Error")}
     end
     describe "when the edit is correct" do
       let(:new_name) {"Alberto"}
       let(:new_email) {"alberto@example.it"}
       before do
       fill_in "Name", with: new_name
       fill_in "Email", with: new_email
       fill_in "Password", with: user.password
       fill_in "Confirmation", with: user.password_confirmation
       click_button "Edit my account"
       end
         it {should have_title(new_name)}
         it {should have_content(new_name)}
         it {should have_selector("div.alert.alert-success", text: "Account correctly modified")}
         it {should have_link("Sign out", href: signout_path)}
         specify {expect(user.reload.name).to eq new_name}
         specify {expect(user.reload.email).to eq new_email}
     end
   end
   describe "when visiting a User page" do
     let(:user) {FactoryGirl.create :user}
     let!(:micropost_1) {FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago)}
     let!(:micropost_2) {FactoryGirl.create(:micropost, user: user, created_at: 1.hours.ago)}
    before do
      sign_in user
      visit user_path(user)
    end
    it {should have_title(user.name)}
    it {should have_content(user.name)}
    it "should have displayed al his microposts" do
       user.microposts.each do |mp|
         expect(page).to (have_content(mp.content))
       end
     end
    it {should have_content(user.microposts.count)}
   end
   
 end

