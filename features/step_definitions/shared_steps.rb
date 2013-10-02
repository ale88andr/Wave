# temporary here
When /^(?:I am|I'm|I) (?:on|visit|go to|visiting) ['"]?([^"']*)["']$/ do |path|
  url_translate = {
    "Entity backend page" => backend_entities_path,
    "New Entity backend page" => new_backend_entity_path,
    "Entity category select backend page" => select_backend_entities_path,
  }
  if url_translate.key?(path)
    visit url_translate[path]
  else
    raise "#{path.inspect} not supported or not defined in application"
  end
end

And /^I (?:click|click on|push) (.+) button$/ do |button_name|
  begin
    # fix RUBY_Exp
    %{I press button_name}
  rescue
    raise "Button #{button_name} can't be find on the page"
  end
end
# --end temporary here