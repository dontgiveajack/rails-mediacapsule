
if params[:with_root] == "true"
  json.array! [Tenant::Folder.new(name: 'Cataloge')] do |root|
    json.resource_id 0
    json.title "Catalogue"
    json.folder true

    json.children @resources do |child|
      json.partial! 'node', resource: child
    end
  end
else
  json.array! @resources, partial: 'node', as: :resource
end
