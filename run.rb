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

results = FetchHistory.get_private_repos(github)
pp FetchHistory.populate_repo_commits(results, github)
