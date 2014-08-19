#  Aliases
Pry.config.commands.tap do |c|
  c.alias_command "q", "exit-all"
  c.alias_command "n", "next"
  c.alias_command "s", "step"
end

# Load 'awesome_print'
begin
  require 'awesome_print'
  require 'awesome_print/ext/active_record'
  require 'awesome_print/ext/active_support'
  AwesomePrint.pry!
rescue LoadError => err
end

# Launch Pry with access to the entire Rails stack
rails = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0].in?(['3', '4'])
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2, Rails3 or Rails4?)"
  end

  # Rails' pry prompt
  env = ENV['RAILS_ENV'] || Rails.env
  rails_root = File.basename(Dir.pwd)

  rails_env_prompt = case env
  when "development" then "[DEV]"
  when "production" then "[PROD]"
  else "[#{env.upcase}]"
  end

  prompt = '%s %s %s:%s'
  Pry.config.prompt = [ proc { |obj, nest_level, *| "#{prompt} > " % [rails_root, rails_env_prompt, obj, nest_level] },
                        proc { |obj, nest_level, *| "#{prompt} * " % [rails_root, rails_env_prompt, obj, nest_level] } ]

  # Add Rails console helpers (like `reload!`) to pry
  if defined?(Rails::ConsoleMethods)
    extend Rails::ConsoleMethods

    # Load model classes
    def self.reload_model_classes
      ActiveRecord::Base.connection.tables.map(&:classify).map(&:safe_constantize).compact.map(&:name).tap do |x|
        return if x.empty?
        # Implement detect the window width with `tput cols`.to_i
        max_padding = x.max_by(&:length).length + 1
        title       = "Loading #{x.length} Models"
        group_size  = 4
        dash_count  = ((max_padding + 2) * group_size - 1)

        puts "+" + ("-" * dash_count + "+")
        puts "| %s%#{dash_count - title.length-1}s|" %[title, ""]
        puts "+" + ("-" * dash_count) + "+"
        x.sort.in_groups_of(group_size).each do |classes|
          classes.each_with_index do |klass, i|
            padding = max_padding - (klass.try(:length) || 0)
            print "| %s%#{padding}s" %[klass, ""]
          end
          print "|\r\n"
        end
        puts "+" + ("-" * dash_count) + "+"
      end
      true
    end

    def self.reload!
      super
      reload_model_classes
    end
  end


  # set logging to screen
  if ENV.include?('RAILS_ENV')
    # Rails 2.x
    if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
      require 'logger'
      Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
    end
  else
    # Rails 3
    if Rails.logger and defined?(ActiveRecord)
      Rails.logger = Logger.new(STDOUT)
      ActiveRecord::Base.logger = Rails.logger
    end
  end

end

# From http://blog.evanweaver.com/articles/2006/12/13/benchmark/
# Call benchmark { } with any block and you get the wallclock runtime
# as well as a percent change + or - from the last run
def benchmark
  cur = Time.now
  result = yield
  print "#{cur = Time.now - cur} seconds"
  puts " (#{(cur / $last_benchmark * 100).to_i - 100}% change)" rescue puts ""
  $last_benchmark = cur
  result
end
