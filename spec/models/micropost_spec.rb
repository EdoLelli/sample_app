require 'spec_helper'

describe "Micropost" do
  let(:user) {FactoryGirl.create :user}
  before {@post=user.microposts.build(content:"Lorem ipsium")}
  subject {@post}
  
  it {should respond_to(:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) {should eq user}
  
  it {should be_valid}
  
  describe "when user_id is nil" do
    before {@post.user_id= nil}
    it {should_not be_valid}
  end
  describe "it should maximum 140 charachters" do
    before {@post.content= "a"*141}
    it {should_not be_valid}
   end
   describe "when content is nil" do
     before {@post.content=" "}
     it {should_not be_valid} 
   end
end
