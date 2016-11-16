class FetchHistory

  def initialize(github)
    @github = github
  end

  def get_private_repos
    results = []
    @github.repos.list do |repo|
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

  def populate_repo_commits(results)
    results.each do |record|
      record[:commits] = get_repo_commits(record)
    end
  end

  def get_repo_commits(record)
    commits = {}
    @github.repos.commits.list('DawnPaladin', record[:repo_name]) do |commit|
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
