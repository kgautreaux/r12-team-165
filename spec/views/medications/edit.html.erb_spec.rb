require 'spec_helper'

describe "medications/edit" do
  before(:each) do
    @medication = assign(:medication, stub_model(Medication))
  end

  it "renders the edit medication form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => medications_path(@medication), :method => "post" do
    end
  end
end
