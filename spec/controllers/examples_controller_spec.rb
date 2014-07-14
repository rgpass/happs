require 'spec_helper'

describe ExamplesController do

  describe "GET 'profile_start'" do
    it "returns http success" do
      get 'profile_start'
      response.should be_success
    end
  end

  describe "GET 'ohq'" do
    it "returns http success" do
      get 'ohq'
      response.should be_success
    end
  end

  describe "GET 'profile_ohq'" do
    it "returns http success" do
      get 'profile_ohq'
      response.should be_success
    end
  end

  describe "GET 'paf'" do
    it "returns http success" do
      get 'paf'
      response.should be_success
    end
  end

  describe "GET 'profile_paf'" do
    it "returns http success" do
      get 'profile_paf'
      response.should be_success
    end
  end

  describe "GET 'activity'" do
    it "returns http success" do
      get 'activity'
      response.should be_success
    end
  end

  describe "GET 'profile_activity'" do
    it "returns http success" do
      get 'profile_activity'
      response.should be_success
    end
  end

end
