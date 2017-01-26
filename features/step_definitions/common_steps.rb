Given /^I am on '(\w+)' page$/ do |page|
  page.open
end

When /^(?:I |)fill and submit search field with query '(.+)'$/ do |query|
  LandingPage.given.header_section.fill_and_submit_search_field(query)
end

When /^(?:I |)search profiles with the following criteria:$/ do |data|
  SearchProfilesPage.given.search(data.rows_hash.symbolize_keys)
end

Then /^(?:I |)should see that first '(\d+)' results have skill '(.*)'$/ do |limit, criterion|
  search_results = SearchProfilesPage.given.search_results(limit.to_i)
  Howitzer::Log.info("Check search result: #{search_results}")

  result = search_results.all? do |result|
    result[:skills].include?(criterion)
  end

  expect(result).to be_truthy
end

Then /^(?:I |)should see that first '(\d+)' results have rate '(.*)'$/ do |limit, criterion|
  comparison_method = criterion['+'] ? '>=' : '=='
  expected_rate = criterion.gsub(/[^\d]/, '').to_f
  search_results = SearchProfilesPage.given.search_results(limit.to_i)
  Howitzer::Log.info("Check search result: #{search_results}")

  result = search_results.all? do |result|
    result[:rate].send(comparison_method, expected_rate)
  end

  expect(result).to be_truthy
end