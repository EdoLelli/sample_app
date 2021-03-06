require 'spec_helper'

describe "MicropostPages" do
  subject {page}
  let(:user) { FactoryGirl.create(:user) }
  before {sign_in user}
   
  describe "user after sign in" do
 
  before do 
          
          visit root_path
        end
  
  it "when try to sumbit a wrong post" do
    expect{click_button "Post"}.not_to change(Micropost, :count)
    end
   
   describe "error messages" do
     before {click_button "Post"}
     it {should have_content("error")}
   end
   describe "when the creating of microposts is correct" do
   let(:submit) {click_button "Post"}
     before do
       fill_in "micropost_content", with: "my first post"
      end
    it "should change the number of the record by 1" do
       expect{submit}.to change(Micropost, :count).by(1)
     end
     describe "success message" do
       before {submit}
       it {should have_content("Micropost correctly created")}
     end   
     end
  end
 describe "micropost destruction" do
    
    let!(:micropost) {FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
     before {visit root_path}
     it "should delete a micropost" do
        expect { click_link "delete"}.to change(Micropost, :count).by(-1)
      end
    end
  end
end
