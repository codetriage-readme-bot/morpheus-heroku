module MorpheusHeroku
  module Deploy
    DEPLOY_ENV = "production"

    extend self

    def production
      fetch_active_remotes!
      ensure_local_remote_is_up_to_date!
      deploy_to_heroku!
      run_database_migrations!
      restart_server!
      tag_release!
      update_git!
    end

    private

    def fetch_active_remotes!
      Helper.bash_run(command: "git fetch")
    end

    def git_branch
      @branch ||= `git branch | grep -e "^*"`.strip.gsub("* ", "")
    end

    def ensure_local_remote_is_up_to_date!
      Helper.bash_run(command: "git pull origin #{git_branch}")
    end

    def deploy_to_heroku!
      Helper.bash_run(command: "git push heroku #{git_branch}:master --force")
    end

    def run_database_migrations!
      Helper.heroku_run(command: "heroku run rake db:migrate")
    end

    def tag_release!
      Helper.bash_run(command: "git tag #{tag_name}")
    end

    def tag_name
      "heroku_#{DEPLOY_ENV}_#{Time.now.to_s(:db).gsub(/[- :]/, "_")}"
    end

    def update_git!
      Helper.bash_run(command: "git push origin --tags")
    end

    def restart_server!
      Helper.heroku_run(command: "heroku restart")
    end
  end
end
