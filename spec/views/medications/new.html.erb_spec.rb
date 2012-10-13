require 'spec_helper'

describe "medications/new" do
  before(:each) do
    assign(:medication, stub_model(Medication).as_new_record)
  end

  it "renders new medication form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => medications_path, :method => "post" do
    end
  end
end
