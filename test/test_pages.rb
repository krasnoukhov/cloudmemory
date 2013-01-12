require File.expand_path("helper", File.dirname(__FILE__))

scope do
  test "Home" do
    visit "/"
    
    assert has_content?("Cloud Memory")
    assert has_content?("Natalia")
    assert has_content?("Dmitry")
  end
  
  test "Photo" do
    visit "/photo/tags/ruby"
    json = JSON.parse(body)
    
    assert json.include? "caption"
    assert json.include? "images"
    
    visit "/photo/location/48.819263,2.415799"
    json = JSON.parse(body)
    
    assert json.include? "caption"
    assert json.include? "images"
  end
end
