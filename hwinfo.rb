# frozen_string_literal: true
#
require 'etc'

module Hwinfo
  module_function

  def uname_a
    uname.values.join(" ")
  end

  def uname
    Etc.uname
  end

  def cpu_model
    if is_darwin?
      `sysctl -n machdep.cpu.brand_string`.strip
    elsif is_linux?
      `cat /proc/cpuinfo | grep 'model name' | uniq`.split(':')[1]&.strip || "Unknown"
    else
      "Unknown platform"
    end
  end

  def cpu_logical_cores
    Etc.nprocessors
  end

  def cpu_pysical_cores
    if is_darwin?
      `sysctl -n hw.physicalcpu`.to_i
    elsif is_linux?
      # Count unique core IDs
      `cat /proc/cpuinfo | grep 'core id' | sort | uniq | wc -l`.to_i
    else
      Etc.nprocessors # Fallback to logical cores
    end
  end

  # In MB
  def mem_total_mb
    if is_darwin?
      `sysctl -n hw.memsize`.to_i / (1024 * 1024)
    elsif is_linux?
      `grep MemTotal /proc/meminfo`.split[1].to_i / 1024
    else
      "Unknown"
    end
  end

  def is_darwin?
    return @is_darwin if defined?(@is_darwin)
    @is_darwin = RbConfig::CONFIG['host_os'] =~ /darwin/
  end

  def is_linux?
    return @is_linux if defined?(@is_linux)
    @is_linux = RbConfig::CONFIG['host_os'] =~ /linux/
  end
end
