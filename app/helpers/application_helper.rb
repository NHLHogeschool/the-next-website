module ApplicationHelper
  def markdown(body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true,
                                       tables: true)
    markdown.render(body).html_safe
  end
end
