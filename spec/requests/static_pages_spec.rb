require 'spec_helper'

describe "Static pages" do
 let(:base_title) {"Ruby on Rails Tutorial Sample App"}
 subject { page }

 shared_examples_for "All" do
 it { should have_selector('h1', text: heading) }
 it { should have_title(full_title(page_title)) }                     #caso1
end 
 
  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    describe "simulating the creation of 2 user's microposts" do
    let(:user) {FactoryGirl.create :user}
     let!(:micropost_first) {FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago)}
     let!(:micropost_last) {FactoryGirl.create(:micropost, user: user, created_at: 1.hours.ago)}
     describe "and finally seeing the feed in our home page" do
       before do
         sign_in user
         visit root_path
       end
       it do
         user.feed.each do |item|
           expect(page).to have_selector("li##{item.id}", text: item.content)
         end
       end
      describe "follower/following count" do
        let(:other_user) {FactoryGirl.create :user}
        before do
          sign_in other_user
          visit user_path(user)
          other_user.follow!(user)
          visit root_path
        end
        it {should have_link("1 FOLLOWING"), href: following_user_path(other_user)}
        it {should have_link("0 FOLLOWER"), href: following_user_path(other_user)}
      end
    end
  end
  end
    
  
   describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  
  describe "About page" do
   before { visit about_path }                                         #caso2
   let(:heading) {'About'}
   let(:page_title) {'About'}
   
   it_should_behave_like "All"
   end
   
  describe "Contact page" do
   before { visit contact_path }
   let(:heading) {'Contact'}
   let(:page_title) {'Contact'}
   
   it_should_behave_like "All"
   end
end
 