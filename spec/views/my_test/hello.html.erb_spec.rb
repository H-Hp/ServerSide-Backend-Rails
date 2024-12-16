require 'rails_helper'

RSpec.describe "my_test/hello.html.erb", type: :view do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "displays the my_test message" do
    render
    expect(rendered).to match /Hello, World!/
  end
end

