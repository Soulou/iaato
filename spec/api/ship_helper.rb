def it_should_be_a_ship(path = "")
  its(:body){ should have_json_path("#{path}id") }
  its(:body){ should have_json_type(String).at_path("#{path}name") }
  its(:body){ should be_json_eql(:null).at_path("#{path}position") }
end

def its_name_should_be(name, path = "")
  its(:body) { should be_json_eql(%("#{name}")).at_path("#{path}name") }
end

