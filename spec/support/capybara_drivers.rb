# From: https://github.com/teamcapybara/capybara/blob/master/lib/capybara/registrations/drivers.rb#L31
Capybara.javascript_driver = :selenium_chrome_headless_no_sandbox
Capybara.register_driver :selenium_chrome_headless_no_sandbox do |app|
  browser_options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.add_argument("--headless")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-gpu") if Gem.win_platform?
    # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
    opts.add_argument("--disable-site-isolation-trials")
  end

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end
