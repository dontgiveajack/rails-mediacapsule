json.array! @fields do |field|
  json.title "<input type=\"hidden\" name=\"settings[predefined_metadata_fields][]\" value=\"#{field}\"><span>#{field}</span>"
end