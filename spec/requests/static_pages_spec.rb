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