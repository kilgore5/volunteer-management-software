require "rails_helper"

RSpec.describe RotationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rotations").to route_to("rotations#index")
    end

    it "routes to #new" do
      expect(:get => "/rotations/new").to route_to("rotations#new")
    end

    it "routes to #show" do
      expect(:get => "/rotations/1").to route_to("rotations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rotations/1/edit").to route_to("rotations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rotations").to route_to("rotations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rotations/1").to route_to("rotations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rotations/1").to route_to("rotations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rotations/1").to route_to("rotations#destroy", :id => "1")
    end

  end
end
