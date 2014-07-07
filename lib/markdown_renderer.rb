class MarkdownRenderer
  def to_html(raw)
    render(raw)
  end

  private
  def render(raw)
    # Clean up any possible junk HTML
    Sanitize.fragment(md_renderer.render(raw), Sanitize::Config.merge(
      Sanitize::Config::BASIC,
      elements: Sanitize::Config::BASIC[:elements] + ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    ))
  end

  def md_renderer
    @md_renderer ||= begin
      renderer = Redcarpet::Render::HTML.new(filter_html: true)
      md_renderer ||= Redcarpet::Markdown.new(renderer, autolink: true, strikethrough: true, superscript: true)
    end
  end
end
