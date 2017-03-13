require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "displays a welcome message" do
    render :text => "This is what is directly rendered"

    expect(rendered).to match /directly rendered/
  end
end
