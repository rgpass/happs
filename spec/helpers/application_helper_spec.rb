require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "includes the page title" do
      expect(full_title("foo")).to match(/foo/)
    end

    it "includes the base title" do
      expect(full_title("foo")).to match(/^Happs/)
    end

    it "does not include a bar for the home page" do
      expect(full_title("")).not_to match(/\|/)
    end

    it "shows apostrophes" do
      expect(full_title("This Guy's Stuff")).not_to match(/#/)
    end
  end
end
