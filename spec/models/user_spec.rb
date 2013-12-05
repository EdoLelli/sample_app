require 'spec_helper'

 describe 'User' do
   before  {@user = User.new(name:"Alberto", email:"alberto@examples.it", password:"foobar", password_confirmation:"foobar")}
   subject {@user}
   
   it {should respond_to(:name)}
   it {should respond_to(:email)}
   it {should respond_to(:password_digest)}
   it {should respond_to(:password)}
   it {should respond_to(:password_confirmation)}
   it {should respond_to(:authenticate)}
   it {should respond_to(:remember_token)}
   it {should respond_to(:admin)}
   it {should respond_to(:microposts)}
   it {should respond_to(:feed)}
   it {should respond_to(:relationships)}
   it {should respond_to(:follow!)}
   it {should respond_to(:following?)}
   it {should be_valid}
   
   describe 'when name is not present' do
    before{@user = User.new(name:"")}
    it {should_not be_valid}
    end
   describe 'when name is too long' do
     before {@user.name="a"*51}                                                 #caso1
     it {should_not be_valid}
   end
   describe 'when name is too short' do
     it do                                                                      #caso2
     @user.name="a"
     expect(@user).not_to be_valid
     end
   end
   describe "when the email format isn't correct" do
   address =  %w[pippo.example.it pluto@yahoo.it.32 pap@.erino@alice.it foo@bar..com]
   address.each do |valid_block|
     it do
       @user.email=valid_block                                                  #caso3
        should_not be_valid
      end
     end
   end
   
    describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when the password is not present" do
   before do 
     @user.password=""
     @user.password_confirmation=""
  end
  it {should_not be_valid}
  end
  
  describe "when the password confirmation mismatch" do
  before {@user.password_confirmation="mismatch"}
  it {should_not be_valid}
end

 describe "return value of authentication" do
   
   before {@user.save}
   let(:found_user) { User.find_by(email:@user.email) }
     
     it "if password is valid" do
     should eq found_user.authenticate(@user.password) 
     end
     
   describe "if password is invalid" do
     
      it {should_not eq found_user.authenticate("cessp") }
   end
   end
   describe "password is'n at least 6 characters" do
     before {@user.password="a"*5}
     it {should_not be_valid}
   end
   describe "when isn't valid downcasing before the storage of the email into the database" do
     let(:mix_casing) {"fOoO@BAAaAR.com"}
    before do
      @user.email=mix_casing
      @user.save
    end
    it do
    expect(@user.reload.email).to eq mix_casing.downcase
     end
   end
   describe "when the remember_token is correctly created" do
     before {@user.save}
     its(:remember_token) {should_not be_blank}
   end  
   describe "with admin attribute set to true" do
     before do
       @user.save
       @user.toggle!(:admin)
     end
     it {should be_admin}
   end
   
   describe "user's micropost" do
     before {@user.save}
     let!(:micropost_first) {FactoryGirl.create(:micropost, user:@user, created_at: 1.day.ago)}
     let!(:micropost_last) {FactoryGirl.create(:micropost, user:@user, created_at: 1.hours.ago)}
     
     describe "unfollowed-followed micropost" do
         let!(:unfollowed) {FactoryGirl.create :micropost, user:(FactoryGirl.create :user)}
         let(:followed) { FactoryGirl.create(:user) }
     describe "feed" do
       before do
        @user.follow!(followed)
        3.times { followed.microposts.create!(content: "Mpost") }
      end
       its(:feed) {should include(micropost_first)}
       its(:feed) {should include(micropost_last)}
       its(:feed) {should_not include(unfollowed)}
       its(:feed) do
        followed.microposts.each do |micropost|
          should include(micropost)
        end
      end
     end
      end
    it "last should appear for first" do
      expect(@user.microposts.to_a).to eq [micropost_last, micropost_first]
    end
    describe "should be automatically destroyed, when a user is destroyed" do
      before {@user.destroy}
      its(:microposts) {should be_empty}
    end
   end
   describe "following action" do
     let(:other_user) {FactoryGirl.create :user}
     before do
       @user.save
       @user.follow!(other_user)
     end
     describe "follow" do
    
     it {should be_following(other_user)}
     its(:followed_users) {should include(other_user)}
     end
     describe "unfollow" do
       before {@user.unfollow!(other_user)}
       it {should_not be_following(other_user)}
       its(:followed_users) {should_not include(other_user)}
     end
     describe "followers listing" do
       subject {other_user}
       its(:followers) {should include(@user)}
     end
   end
   end