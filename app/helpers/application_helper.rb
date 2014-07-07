module ApplicationHelper
  def render_markdown(markdown)
    @md_renderer ||= MarkdownRenderer.new
    @md_renderer.to_html(markdown)
  end
end
