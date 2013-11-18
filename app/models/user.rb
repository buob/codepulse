class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  has_one :pulse, dependent: :destroy
  has_many :social_accounts, dependent: :destroy
  has_many :social_profiles, through: :social_accounts

  after_create :create_pulse

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(
                    name: auth.extra.raw_info.name,
                    provider: auth.provider,
                    uid: auth.uid,
                    email: auth.info.email,
                    github_user: auth.info.nickname,
                    username: auth.info.nickname,
                    password: Devise.friendly_token[0,20],
                    auth_token: auth.credentials.try(:token)
                  )
    end
    user
  end

  def github
    @_github ||= Github.new oauth_token: auth_token
  end

  def activity
    activity = {}
    earliest = Date.today
    repos.each do |repo|
      github.repos.commits.all(user: repo.owner, repo: repo.name, author: github_user, per_page: 100).each do |c|
        date = Date.parse(c.commit.author.date)
        earliest = date < earliest ? date : earliest
        if activity[date].nil?
          activity[date] = 1
        else
          activity[date] = activity[date] + 1
        end
      end
    end
    date = earliest
    while date < Date.today do
      if activity[date].nil?
        activity[date] = 0
      end
      date = date + 1.days
    end
    activity_array = []
    activity.each {|k,v| activity_array << {date: k, commits: v}}
    activity_array.sort { |x, y| y[:date] <=> x[:date] }
  end

  def shots
    dribbble = SocialProfile.find_by(name: 'dribbble')
    dribbble_account = dribbble.social_accounts.find_by(user_id: self.id)
    if dribbble_account
      handle = dribbble_account.handle
      player = Dribbble::Player.find(handle)
      player.shots.sort do |x,y|
        if y.likes_count != x.likes_count
          y.likes_count <=> x.likes_count
        else
          y.created_at <=> x.created_at
        end
      end
    end
  end

  def repos
    if @repos.nil?
      @repos = []
      github.repos.list(per_page: 100).each do |repo|
        repo = github.repos.get(repo.owner.login, repo.name).source if repo.fork
        repo = Repo.new(self, repo)
        @repos << repo if repo.displayable
      end
      @repos.sort! { |x,y| y.total_commits <=> x.total_commits }
    else
      @repos
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
