require 'spec_helper'

describe "UsersPages" do
 before {visit signup_path}
 subject {page}
 
 describe "Sign up" do
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
end
