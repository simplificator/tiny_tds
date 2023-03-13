# encoding: UTF-8

desc 'Build the native binary gems using rake-compiler-dock'
task 'gem:native' => ['ports:cross'] do
  require 'rake_compiler_dock'

  # make sure to install our bundle
  sh "bundle package --all" # Avoid repeated downloads of gems by using gem files from the host.

  GEM_PLATFORM_HOSTS.each do |plat, meta|
    RakeCompilerDock.sh "bundle --local && RUBY_CC_VERSION=#{meta[:ruby_versions]} rake native:#{plat} gem", platform: plat
  end
end
