Capybara.register_driver :webkit do |app|
  options = {
    :js_errors    => true,
    :window_size  => [1280, 1440],
    :timeout      => 30
  }
  Capybara::Webkit::Driver.new(app, options)
end
