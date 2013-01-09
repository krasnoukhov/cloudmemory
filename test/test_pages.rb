require File.expand_path("helper", File.dirname(__FILE__))

scope do
  test "Root" do
    visit "/"
    
    assert has_content?("Cloud Memory")
    assert has_content?("Natalia")
    assert has_content?("Dmitry")
  end
end
