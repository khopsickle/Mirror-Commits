module FetchHistory

  def self.get_private_repos(github)
    results = []
    github.repos.list do |repo|
      if repo['private'] == true || repo['fork'] == true
        record = {
          repo_name: repo['name'],
          repo_link: repo['html_url'],
          commits: nil
        }
        results << record
      end
    end
    results
  end

  def self.populate_repo_commits(results, github)
    results.each do |record|
      record[:commits] = get_repo_commits(record, github)
    end
  end

  def self.get_repo_commits(record, github)
    commits = {}
    github.repos.commits.list('DawnPaladin', record[:repo_name]) do |commit|
      # pp commit
      commit_date = commit['commit']['author']['date']
      commit_msg = commit['commit']['message']
      commits[commit_date] = commit_msg
    end
    commits
  end


  # {
  #   repo_name: name
  #   repo_link: link
  #   commits: {
  #     time => message,
  #     time => message,
  #     time => message
  #    },
  # }

end
