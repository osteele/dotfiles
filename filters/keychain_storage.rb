require 'shellwords'
require 'yaml'

class SecretsMap
  def initialize(path)
    @map = YAML.load_file(SECRETS_PATH)
  end

  def for_path(path)
    return @map.keep_if do |key, v|
      key = "**/#{key}" unless key[0] == '/'
      File.fnmatch(key, path)
    end.values.inject(&:merge)
  end
end

module Secrets
  class KeychainStore
    SECURITY_CMD = '/usr/bin/security'

    def _args_for(name)
      return [
        '-a', ENV['USER'],
        '-c', 'gitf',
        '-C', 'gitf',
        '-D', 'git filter secret',
        '-l', name,
        # FIXME remove reference to FNAME
        '-s', "#{REPO_NAME}/#{FNAME}/#{name}"
      ]
    end

    def find(name)
      command = Shellwords.join([
        SECURITY_CMD, 'find-generic-password', '-w'] +
        self._args_for(name))
      saved_secret = `#{command} 2>&1`.chomp
      return saved_secret if $?.exitstatus == 0
      return nil
    end

    def update(name, password)
      command = Shellwords.join([
        SECURITY_CMD, 'add-generic-password',
        '-w', password,
        '-U'] + self._args_for(name))
      `#{command}`
      exit 1 unless $?.exitstatus == 0
    end
  end
end
