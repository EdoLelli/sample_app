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
   it "when filling in the fields is not valid" do
   expect {click_button "Create my account"}.not_to diff
 end
 
   it "when filling in the fields is valid" do
     
     fill_in "Name",           with: "Dedo"
     fill_in "Email",          with: "dedo@example.org"
     fill_in "Password",       with: "pazzopazzini"
     fill_in "Confirmation",   with: "pazzopazzini"
     expect {click_button "Create my account"}.to diff.by(1)
   end
 end
end