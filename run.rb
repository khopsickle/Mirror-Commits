require 'figaro'
require 'github_api'
require 'pp'
require_relative 'fetch_history'

Figaro.application = Figaro::Application.new(
  environment: 'development',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

key = ENV['github_key']
github = Github.new(oauth_token: key)

fetcher = FetchHistory.new(github)

results = fetcher.get_private_repos
pp fetcher.populate_repo_commits(results)
