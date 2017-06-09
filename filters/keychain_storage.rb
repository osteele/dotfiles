require 'shellwords'
require 'yaml'

class SecretsMap
  def initialize(path)
    @map = YAML.load_file(SECRETS_PATH)
  end

  def for_path(path)
    return @map.keep_if do |key, v|
      key = "**/#{key}" unless key[0] == '/'
      File.fnmatch(key, FNAME)
    end.values.inject(&:merge)
  end
end

module Secrets
  class KeychainStore
    def _keys_for(name, key) # label = secrets[name]
      return ['-a', ENV['USER'], '-c', 'gitf', '-C', 'gitf', '-D', 'git filter secret', '-l', key]
    end

    def get(name, key)
      saved_secret = `#{Shellwords.join(['security', 'find-generic-password', '-w'] + self._keys_for(name, key))}`.chomp
      return saved_secret if $?.exitstatus == 0
      return nil
    end

    def update(name, key, value)
      command = Shellwords.join([
        'security', 'add-generic-password',
        '-s', "#{REPO_NAME}/#{FNAME}/#{name}",
        '-w', value,
        '-U'] + self._keys_for(name, key))
      `#{command}`
      exit 1 unless $?.exitstatus == 0
    end
  end
end
