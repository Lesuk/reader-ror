require 'spec_helper'

describe "Static pages" do

  describe "home" do
    it "should have the content Sample App" do
    	visit '/static_pages/home'
    	expect(page).to have_content('Sample App')
    end

    it "should have the right title" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Ruby on Rails App | Home")
    end
  end

  describe "help" do
    it "should have the content 'Help" do
    	visit '/static_pages/help'
    	expect(page).to have_content('Help')
    end

    it "should have the right title" do
    	visit '/static_pages/help'
    	expect(page).to have_title("Ruby on Rails App | Help")
    end
  end

  describe "about" do
    it "should have the content 'About us" do
    	visit '/static_pages/about'
    	expect(page).to have_content('About us')
    end

    it "should have the right title" do
    	visit '/static_pages/about'
    	expect(page).to have_title("Ruby on Rails App | About")
    end
  end

end
