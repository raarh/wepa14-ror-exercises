require 'spec_helper'

describe "styles/index" do
  before(:each) do
    assign(:styles, [
      stub_model(Style,
        :style => "Style",
        :description => "MyText"
      ),
      stub_model(Style,
        :style => "Style",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of styles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Style".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
