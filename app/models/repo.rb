class Repo
  attr_accessor :name, :private, :languages, :primary_language_color, :owner, :stats, :displayable, :total_commits, :total_additions, :total_deletions, :this_week_additions, :this_week_deletions, :url
  def initialize(user, repo)
    @name = repo.name
    @private = repo.private
    @owner = repo.owner.login
    @url = repo.html_url

    repo = repo.name

    @languages = user.github.repos.languages(owner,repo).keys
    @primary_language_color = language_colors[@languages.first]

    if stats.length > 0
      stats = stats[0]
      @displayable = true
      @total_commits = stats.total
      @total_additions = 0
      @total_deletions = 0
      last_week = (Time.now - 14.days).to_i
      now = (Time.now - 7.days).to_i

      past_week = {}
      9.times do |i|
        past_week[(Date.today.beginning_of_week(ENV["WEEK_START_DAY"].parameterize.to_sym) - (i*7).days).strftime("%F")] = 0
      end

      stats.weeks.each do |week|
        week_date = Time.at(week.w).strftime("%F")
        past_week[week_date] = week.c unless past_week[week_date].nil?
        @total_additions += week.a
        @total_deletions += week.d
        if last_week < week.w and week.w < now
          @this_week_additions = week.a
          @this_week_deletions = week.d
        end
      end

      @stats = []
      past_week.each {|k,v| @stats << v}
      @stats.reverse!

    else
      @displayable = false
    end
  end

  private

  def stats
    Rails.cache.fetch("#{cache_key}/stats") do
      user.github.repos.stats.contributors(owner,repo).body.keep_if do |contributor|
        contributor.author.login == user.github_user
      end
    end
  end

  def language_colors
    {
      "Arduino" => "#bd79d1",
      "Java" => "#b07219",
      "VHDL" => "#543978",
      "Scala" => "#7dd3b0",
      "Emacs Lisp" => "#c065db",
      "Delphi" => "#b0ce4e",
      "Ada" => "#02f88c",
      "VimL" => "#199c4b",
      "Perl" => "#0298c3",
      "Lua" => "#fa1fa1",
      "Rebol" => "#358a5b",
      "Verilog" => "#848bf3",
      "Factor" => "#636746",
      "Ioke" => "#078193",
      "R" => "#198ce7",
      "Erlang" => "#949e0e",
      "Nu" => "#c9df40",
      "AutoHotkey" => "#6594b9",
      "Clojure" => "#db5855",
      "Shell" => "#5861ce",
      "Assembly" => "#a67219",
      "Parrot" => "#f3ca0a",
      "C#" => "#5a25a2",
      "Turing" => "#45f715",
      "AppleScript" => "#3581ba",
      "Eiffel" => "#946d57",
      "Common Lisp" => "#3fb68b",
      "Dart" => "#cccccc",
      "SuperCollider" => "#46390b",
      "CoffeeScript" => "#244776",
      "XQuery" => "#2700e2",
      "Haskell" => "#29b544",
      "Racket" => "#ae17ff",
      "Elixir" => "#6e4a7e",
      "HaXe" => "#346d51",
      "Ruby" => "#701516",
      "Self" => "#0579aa",
      "Fantom" => "#dbded5",
      "Groovy" => "#e69f56",
      "C" => "#555",
      "JavaScript" => "#f15501",
      "D" => "#fcd46d",
      "ooc" => "#b0b77e",
      "C++" => "#f34b7d",
      "Dylan" => "#3ebc27",
      "Nimrod" => "#37775b",
      "Standard ML" => "#dc566d",
      "Objective-C" => "#f15501",
      "Nemerle" => "#0d3c6e",
      "Mirah" => "#c7a938",
      "Boo" => "#d4bec1",
      "Objective-J" => "#ff0c5a",
      "Rust" => "#dea584",
      "Prolog" => "#74283c",
      "Ecl" => "#8a1267",
      "Gosu" => "#82937f",
      "FORTRAN" => "#4d41b1",
      "ColdFusion" => "#ed2cd6",
      "OCaml" => "#3be133",
      "Fancy" => "#7b9db4",
      "Pure Data" => "#f15501",
      "Python" => "#3581ba",
      "Tcl" => "#e4cc98",
      "Arc" => "#ca2afe",
      "Puppet" => "#cc5555",
      "Io" => "#a9188d",
      "Max" => "#ce279c",
      "Go" => "#8d04eb",
      "ASP" => "#6a40fd",
      "Visual Basic" => "#945db7",
      "PHP" => "#6e03c1",
      "Scheme" => "#1e4aec",
      "Vala" => "#3581ba",
      "Smalltalk" => "#596706",
      "Matlab" => "#bb92ac",
      "C#" => "#bb92af",
      "CSS" => "#1f085e",
    }
  end
end
