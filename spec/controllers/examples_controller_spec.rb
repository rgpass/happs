require 'spec_helper'

describe ExamplesController do

  describe "GET 'profile_complete" do
    it "returns http success" do
      get 'profile_complete'
      response.should be_success
    end
  end

  describe "GET 'ohq'" do
    it "returns http success" do
      get 'ohq'
      response.should be_success
    end
  end

  describe "GET 'activity'" do
    it "returns http success" do
      get 'activity'
      response.should be_success
    end
  end

  describe "GET 'profile_start'" do
    it "returns http success" do
      get 'profile_start'
      response.should be_success
    end
  end
  
end
