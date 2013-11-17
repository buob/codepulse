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

  def repos
    if @repos.nil?
      @repos = []
      github.repos.list.each do |repo|
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
