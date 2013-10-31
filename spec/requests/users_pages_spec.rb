require 'spec_helper'

describe "UsersPages" do
 before {visit signup_path}
 subject {page}
 
 describe "Sign up" do
   it {should have_content('Sign up')}
   it {should have_title(full_title('Sign up'))}
 
 end
end
