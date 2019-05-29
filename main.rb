require 'rubygems'
require 'jira-ruby' 
require 'dotenv/load'
require 'dotenv'

email_address = ENV.fetch("EMAIL_ADDRESS")
api_token = ENV.fetch("TOKEN")
url = ENV.fetch("URL")
column = ENV.fetch("COLUMN")

options = {
            :username => email_address,
            :password => api_token,
            :site     => url,
            :context_path => '',
            :auth_type => :basic,
            :read_timeout => 120
          }

client = JIRA::Client.new(options)

puts "Logged in user: #{email_address}"

issues = []
jql = "updated >= -4w order by updated DESC"
start_at = 0
# fetch issues
results = client.Issue.jql(jql, start_at: start_at, max_results: 300)
# loop until results is empty
until results.empty?
  issues << results
  puts "Fetching issues..."
  # set start_at/offset by the number of results
  start_at += results.size
  # fetch issues
  results =  client.Issue.jql(jql, start_at: start_at, max_results: 300)
end

all_issues = issues.flatten.sort_by(&:id)
issues_ready_for_testing = all_issues.select { |issue| issue.status.name.downcase == column }
issues_ready_for_testing_assigned_to_me = issues_ready_for_testing.select { |issue| issue.assignee.present? && issue.assignee.emailAddress == email_address }
puts issues_ready_for_testing_assigned_to_me.count
issues_ready_for_testing_assigned_to_me.each do |issue|
  puts "#{issue.key} | #{issue.summary} (#{url}/browse/#{issue.key})"
end
