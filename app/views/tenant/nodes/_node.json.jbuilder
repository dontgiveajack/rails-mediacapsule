
json.resource_id resource.id

if resource.is_a?(Tenant::Folder)
  @tenant_folder = resource
  json.favouriteStar check_box(:tenant_folder, :is_favourite, id: "tenant_folder_is_favourite_#{resource.id}", class:"sr-only", onchange: "this.setAttribute('data-params', 'tenant_folder[is_favourite]=' + this.checked*this.checked)", data: { remote: true, url: tenant_folder_path(resource), method: :patch }) + raw("<label for=\"tenant_folder_is_favourite_#{resource.id}\"></label>")#, '<input id="star" type="checkbox"/><label for="star"></label>'
  json.resource_type 'tenant_folder'
  json.title link_to(resource.name, tenant_catalogue_browser_path(path: resource.path))
  json.folder true
  json.size number_to_human_size(resource.folder_size)

  json.resource_url tenant_folder_path(resource)
  json.resource_move_url move_tenant_folder_path(resource)

  if params[:with_children] == "true"
    json.children resource.children do |child|
      json.partial! 'node', resource: child
    end
  end
else
  @tenant_media_item = resource
  json.favouriteStar check_box(:tenant_media_item, :is_favourite, id: "tenant_media_item_is_favourite_#{resource.id}", onchange: "this.setAttribute('data-params', 'tenant_media_item[is_favourite]=' + this.checked*this.checked)", data: { remote: true, url: tenant_media_item_path(resource), method: :patch }) + raw("<label for=\"tenant_media_item_is_favourite_#{resource.id}\"></label>")#, '<input id="star" type="checkbox"/><label for="star"></label>'
  json.resource_type 'tenant_media_item'
  json.title link_to(resource.file.filename, tenant_media_item_path(resource)) #link_to(resource.file.filename, rails_blob_url(resource.file, disposition: "attachment"))
  json.folder false
  json.size number_to_human_size(resource.file.byte_size)

  json.resource_url tenant_media_item_path(resource)
  json.resource_move_url move_tenant_media_item_path(resource)
end

# TODO, integrate with CArchive
json.online '<i class="fas fa-circle"></i>' 
json.archived false
# End of TODO

json.addedBy resource.creator.name
json.updated resource.updated_at.to_formatted_s(:long_ordinal)


