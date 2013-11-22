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
   end