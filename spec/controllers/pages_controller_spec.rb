require 'spec_helper'

describe PagesController do
	render_views

  describe "Home page" do
  
	it "should be have the content 'Considerating'" do
    	visit '/pages/home'
    	page.should have_content('Considerating')
    end
    
    it "should have the right title" do
    	visit '/pages/home'
    	page.should have_selector("title", :text => "Considerating")
    end
  end

  describe "About page" do
  
    it "should be have the content 'About'" do
    	visit '/pages/about'
    	page.should have_content('About')
    end
    
    it "should have the right title" do
    	visit '/pages/about'
    	page.should have_selector("title", :text => "About Considerating")
    end
  end

end
