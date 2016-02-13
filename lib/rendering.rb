require "erb"
require "pry"

module Rendering
  def render(action)
    response.write render_to_string(action)
  end

  def render_to_string(action) # :index
    path = template_path(action)
    # template = template_path(action)
    # template = ERB.new(File.read(path))
    # template.result(binding)

    method = compile_template(path)
    content = send method
    # content => "\n\n<p>Hello from a view!</p>\n<p>@message = </p>"

    layout_method = compile_template(layout_path)
    send(layout_method) { content }
  end

  def compile_template(path)
    method_name = path.gsub(/\W/, '_') # app/index.html.erb => app_index_html_erb
    unless respond_to?(method_name)
      template = ERB.new(File.read(path))
      class_eval <<-CODE
        def #{method_name}
          #{template.src}
        end
      CODE
    end

    method_name
  end

  def template_path(action)
    "app/views/#{controller_name}/#{action}.html.erb"
  end

  def layout_path
    "app/views/layouts/application.html.erb"
  end

  def controller_name
    self.class.name[/^(\w+)Controller/, 1].downcase # HomeController => "home"
  end
end