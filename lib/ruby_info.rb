module RubyInfo
  module_function
  def ruby_info_simple
    {
      RUBY_DESCRIPTION: RUBY_DESCRIPTION,
      YJIT_enabled: defined?(RubyVM::YJIT) && RubyVM::YJIT.respond_to?(:enabled?) && RubyVM::YJIT.enabled?,
      MJIT_enabled: defined?(RubyVM::MJIT) && RubyVM::MJIT.respond_to?(:enabled?) && RubyVM::MJIT.enabled?,
    }.compact
  end

  def ruby_info
    {
      **ruby_info_simple,
      RUBYOPT: ENV['RUBYOPT'],
      CONFIG_MAINLIBS: RbConfig::CONFIG['MAINLIBS'],
      CONFIG_LIBS: RbConfig::CONFIG['LIBS'],
    }.compact
  end

  def yjit_enabled?
    defined?(RubyVM::YJIT) && RubyVM::YJIT.respond_to?(:enabled?) && RubyVM::YJIT.enabled?
  end

  def print_info
    puts "Ruby Information:"
    pp ruby_info_simple
  end
end
