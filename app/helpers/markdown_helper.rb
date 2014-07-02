module MarkdownHelper
  def render_markdown(markdown)
    # make class so we don't have to recreate renderer over and over?
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    md_renderer ||= Redcarpet::Markdown.new(renderer, autolink: true, strikethrough: true, superscript: true)

    # Clean up any possible junk HTML
    Sanitize.fragment(md_renderer.render(markdown), Sanitize::Config.merge(
      Sanitize::Config::BASIC,
      elements: Sanitize::Config::BASIC[:elements] + ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    ))
  end
end
