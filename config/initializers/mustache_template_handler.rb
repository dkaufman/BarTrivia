module MustacheTemplateHandler
  def self.call(template)
    "#{template.source.inspect}.html_safe"
  end
end

ActionView::Template.register_template_handler(:mustache, MustacheTemplateHandler)
