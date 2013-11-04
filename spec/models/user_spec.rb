require 'spec_helper'

 describe 'User' do
   before  {@user = User.new(name:"Alberto", email:"alberto@examples.it", password:"foobar", password_confirmation:"foobar")}
   subject {@user}
   
   it {should respond_to(:name)}
   it {should respond_to(:email)}
   it {should respond_to(:password_digest)}
   it {should respond_to(:password)}
   it {should respond_to(:password_confirmation)}
   it {should respond_to (:authenticate)}
   it {should be_valid}
   
   describe 'when name is not present' do
    before{@user = User.new(name:"")}
    it {should_not be_valid}
    end
   describe 'when name is too long' do
     before {@user.name="a"*21}                                                 #caso1
     it {should_not be_valid}
   end
   describe 'when name is too short' do
     it do                                                                      #caso2
     @user.name="a"
     expect(@user).not_to be_valid
     end
   end
   describe "when the email format isn't correct" do
   address =  %w[pippo.example.it pluto@yahoo.it.32 pap@.erino@alice.it]
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
   end