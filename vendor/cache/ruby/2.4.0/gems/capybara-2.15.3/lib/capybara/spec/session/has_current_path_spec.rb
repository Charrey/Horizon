# frozen_string_literal: true
Capybara::SpecHelper.spec '#has_current_path?' do
  before do
    @session.visit('/with_js')
  end

  it "should be true if the page has the given current path" do
    expect(@session).to have_current_path('/with_js')
  end

  it "should allow regexp matches" do
    expect(@session).to have_current_path(/w[a-z]{3}_js/)
    expect(@session).not_to have_current_path(/monkey/)
  end

  it "should handle non-escaped query options" do
    @session.click_link("Non-escaped query options")
    expect(@session).to have_current_path("/with_html?options[]=things")
  end

  it "should handle escaped query options" do
    @session.click_link("Escaped query options")
    expect(@session).to have_current_path("/with_html?options%5B%5D=things")
  end

  it "should wait for current_path", requires: [:js] do
    @session.click_link("Change page")
    expect(@session).to have_current_path("/with_html", wait: 3)
  end

  it "should be false if the page has not the given current_path" do
    expect(@session).not_to have_current_path('/with_html')
  end

  it "should check query options" do
    @session.visit('/with_js?test=test')
    expect(@session).to have_current_path('/with_js?test=test')
  end

  it "should compare the full url" do
    expect(@session).to have_current_path(%r{\Ahttp://[^/]*/with_js\Z}, url: true)
  end

  it "should ignore the query" do
    @session.visit('/with_js?test=test')
    expect(@session).to have_current_path('/with_js?test=test')
    expect(@session).to have_current_path('/with_js', only_path: true)
  end

  it "should not allow url and only_path at the same time" do
    expect {
      expect(@session).to have_current_path('/with_js', url: true, only_path: true)
      }. to raise_error ArgumentError
  end

  it "should not raise an exception if the current_url is nil" do
    allow_any_instance_of(Capybara::Session).to receive(:current_url) { nil }

    # Without only_path option
    expect {
      expect(@session).to have_current_path(nil)
    }. not_to raise_exception

    # With only_path option
    expect {
      expect(@session).to have_current_path(nil, only_path: true)
    }. not_to raise_exception
  end
end

Capybara::SpecHelper.spec '#has_no_current_path?' do
  before do
    @session.visit('/with_js')
  end

  it "should be false if the page has the given current_path" do
    expect(@session).not_to have_no_current_path('/with_js')
  end

  it "should allow regexp matches" do
    expect(@session).not_to have_no_current_path(/w[a-z]{3}_js/)
    expect(@session).to have_no_current_path(/monkey/)
  end

  it "should wait for current_path to disappear", requires: [:js] do
    Capybara.using_wait_time(3) do
      @session.click_link("Change page")
      expect(@session).to have_no_current_path('/with_js')
    end
  end

  it "should be true if the page has not the given current_path" do
    expect(@session).to have_no_current_path('/with_html')
  end

  it "should not raise an exception if the current_url is nil" do
    allow_any_instance_of(Capybara::Session).to receive(:current_url) { nil }

    # Without only_path option
    expect {
      expect(@session).not_to have_current_path('/with_js')
    }. not_to raise_exception

    # With only_path option
    expect {
      expect(@session).not_to have_current_path('/with_js', only_path: true)
    }. not_to raise_exception
  end
end
