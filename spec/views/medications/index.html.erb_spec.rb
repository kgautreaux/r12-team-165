require 'spec_helper'

describe "medications/index" do
  before(:each) do
    assign(:medications, [
      stub_model(Medication),
      stub_model(Medication)
    ])
  end

  it "renders a list of medications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
