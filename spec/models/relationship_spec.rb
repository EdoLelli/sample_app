require 'spec_helper'

describe 'Relationship' do
  let(:follower_user) {FactoryGirl.create :user}
  let(:followed_user) {FactoryGirl.create :user}
  let(:relationship) {follower_user.relationships.build(followed_id:followed_user.id)}
  
  subject{relationship} 
  it {should be_valid}
  describe "follower method" do
    it {should respond_to(:follower)}
    it {should respond_to(:followed)}
    its(:follower) {should eq follower_user}
    its(:followed) {should eq followed_user}
  end
  describe "when the field follower_id is nil" do
    before {relationship.follower_id=""}
    it {should_not be_valid}
  end
  describe "when the field followed_id is nil" do
    before {relationship.followed_id=""}
    it {should_not be_valid}
  end
  
end
