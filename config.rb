###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

require 'reformat_examples'

$dmwg_examples = DMWGExampleData.new('data/flattened')

# build raw json versions of the examples
$dmwg_examples.by_id.each do |k,v|
  proxy "/json/#{k}", "/templates/entity.json", :locals => { :object => v },
    :ignore => true, :layout => false, :directory_indexes => true
end
proxy "/json/Types", "/templates/entity.json", :locals => { :object => $dmwg_examples.types },
  :ignore => true, :layout => false, :directory_indexes => true
ignore "/templates/"
ignore "/json/" # not sure why this has to be here, but may work around a middleman bug...

helpers do

  # Generate a link to a specific resource with text based on title
  def link_to_resource(resource)
    if (resource.data.id == nil)
        link_to(resource.data.title, resource)
    else
        link_to(data.flattened.Type[resource.data.id].name, resource)
    end
  end

  # Return the path one level above the current path
  def parent_path(path)
    path.chomp('/')[/(.*\/).*$/, 1]
  end

  def path_depth(path)
    path.chomp('/').count('/')
  end

  def model_link(model)
    # %(<li class="#{model}"><a href="/#{model}"><span class="glyphicon #{data.models[model].icon}"></span>#{model.capitalize}</a></li>)
    resource = sitemap.find_resource_by_path("#{model}/index.html")
    link = link_to("/#{model}") do
      %(<span class="glyphicon #{data.models[model].icon}"></span>#{model.capitalize})
    end
    %(<li class="#{model}">#{link}</li>)
  end

  def local_link(text, path)
    if path == current_page.url
      %(<li class="active">#{link_to text, path}</li>)
    else
      "<li>#{link_to text, path}</li>"
    end
  end

  def example_table_item(data)
    if data.nil?
      return ''
    end
    output = ''
    if !data.kind_of?(Array)
      data = [data]
    end
    data.each do |item|
      if (item.kind_of?(Hash) && item['id'])
        output << %(<p>#{link_to item['id'], "/tech/details/details.html", :fragment => item['id'], :relative => true}</p>)
      else
        output << %(<p>#{item}</p>)
      end
    end
    output
  end

  def breadcrumb(page)
    li = ""
    li = "<li>#{link_to(page.data.title, page)}</li>\n" if page.data.title
    li = breadcrumb(page.parent) + li if page.parent
    li
  end

  def expanded_link_with_local_index(text, path)
    #resource = sitemap.find_resource_by_path("#{model}/discussion/index.html")
    resource = sitemap.find_resource_by_path("#{path}/index.html")
    # Count the child folders
    if (path_depth(current_page.url) == 1 ||
        current_page.url.include?('/#{path}/'))
      index = child_index(path)
      %(<li class="active">#{link_to(text, resource)}</li>#{index})
    # elsif current_page.url.include?('/discussion/')
    #   link_with_local_index(text,path)
    else
      "<li>#{link_to(text, resource)}</li>#{index}"
    end
  end

  # This is a special case needed because of bugs in the link_to method
  # when using relative links (also because were playing games with the
  # links from the discusison page
  def child_index(path)
    resource = sitemap.find_resource_by_path("#{path}/index.html")
    return "" if resource.children.size == 0
    resource.children.each { |e| "<li>#{link_to e.data.id, e.url}</li>" }
    index = resource.children.reduce("") { |a, e| a + "<li>#{link_to e.data.title, e.url}</li>" }
    "<ul>#{index}</ul>"
  end

  # Root links in left navbar. Expand (accordion style)
  # based on selected page
  def link_with_local_index(text, path)
    resource = sitemap.find_resource_by_path(path)
    # "<li> #{path} </li>"
    output = link_to(text, resource)
    if resource && current_page.url.include?(resource.url)
      index = local_index(current_page.url)
      %(<li class="active">#{output}</li>#{index})
    else
      "<li>#{output}</li>"
    end
  end

  def local_index(path)
    index = ""
    index = list_children(path) unless current_page.data.skip_children
    unless current_page.data.skip_siblings
      index = list_siblings(path, index) if path_depth(path) > 1
    end
    index = list_parents(path, index) if path_depth(path) > 2
    index
  end

  def list_parents(path, nested_index = "")
    parent_path = parent_path(path)
    index = list_siblings(parent_path, nested_index)
    index = list_parents(parent_path, index) if path_depth(parent_path) > 2
    index
  end

  def list_siblings(path, nested_index = "")
    sibling_path = parent_path(path)
    depth = path_depth(path)
    siblings = sitemap.resources.select do |r|
      r.url.include?(sibling_path) && path_depth(r.url) == depth
    end.sort_by { |r| r.path }
    list = siblings.reduce("") do |a, e|
      if current_page.url.include?(e.url)
        a << %(<li class="active">#{link_to_resource(e)}</li>#{nested_index})
      else
        a << "<li>#{link_to_resource(e)}</li>"
      end
    end
    "<ul>#{list}</ul>"
  end

  # Generate nested list of current element's children
  def list_children(parent_url)
    depth = path_depth(parent_url)
    children = sitemap.resources.select do |r|
      r.url.include?(parent_url) && path_depth(r.url) == depth + 1
    end.sort_by { |r| r.path }
    return "" if children.size == 0
    list = children.reduce("") do |a, e|
      a << "<li>#{link_to_resource(e)}</li>\n"
    end
    "<ul>#{list}</ul>"
  end

  def model_name
    current_page.data.model ? current_page.data.model.capitalize : ""
  end

  def brief_index(path)
    output = sitemap.resources.select{|r| r.url.include?(path) && path != r.url }.sort_by{ |r| r.path}.reduce("<ul>\n") do |acc, r|
      acc + "<li>#{link_to r.data.title, r.url}</li>\n"
    end
    return output + "</ul>\n"
  end

  def attributes_by_entity(entityId)
    $dmwg_examples.attributes_by_entity[entityId].select { |i| i['entityId'] == entityId }
  end

  def inherited_attributes_by_entity(entityId)
    $dmwg_examples.attributes_by_entity[entityId]
      .select { |i| i['entityId'] != entityId }
      .each { |i| i.merge({'inherited_from' => data.flattened.Type[i['entityId']]})}
  end

  def examples_by_type(type)
    type_name = data.flattened.Type[type]['name']
    $dmwg_examples.by_type[type_name]
  end

  # def example_path(example_id)
  #   "/allele/implementation/examples/#{example_id}.html"
  # end

  # def examples_index
  #   output = data.examples.sort_by{ |e| e['title'] }.reduce("<ul>\n") do |acc, e|
  #     acc + "<li>" + link_to(e['title'], example_path(e['id']))
  #   end
  #   return output + "</ul>"
  # end

  # def link_with_examples_index(text, path)
  #   output = link_to(text, path)
  #   if current_page.url.include?(path)
  #     "<strong>#{output}</strong>#{examples_index}"
  #   else
  #     output
  #   end
  # end

  # def examples_table(resource_name)
  #   examples = data.examples.select do |example|
  #     example.resource == resource_name
  #   end
  #   header = '<table class="table"><thead><tr><th>id</th><th>name</th></tr></thead><tbody>'
  #   output = examples.reduce(header) do |acc, example|
  #     acc << '<tr>'
  #     acc << "<td>#{example['id']}</td>"
  #     acc << "<td>#{link_to example['title'], example_path(example['id']) }</td>"
  #     if example['jsonld']
  #       acc << "<td>#{link_to 'json-ld', example['jsonld']}</td>"
  #     end
  #     acc << "<td>#{link_to 'xml', example['xml']}</td>"
  #     acc << "<td>#{link_to 'json', example['json']}</td>"
  #   end
  #   output + "</tbody></table>"
  # end

  def render_markdown(content)
    Tilt['markdown'].new { content }.render
  end

end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# run get_examples.rb script to download latest snapshot.

### Additonal custom configuration
set :relative_links, true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
