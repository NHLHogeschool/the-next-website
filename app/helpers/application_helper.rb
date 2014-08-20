module ApplicationHelper
  def title(title)
    parts = ['The Next Web', title].delete_if(&:blank?)
    content_for :title, parts.join(': ')
  end

  def markdown(body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true,
                                       tables: true)
    markdown.render(body).html_safe
  end
end
