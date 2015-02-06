require "formula"

class Gamp < Formula
  homepage 'https://github.com/Gigitsu/homebrew-gamp'
  url 'https://github.com/Gigitsu/homebrew-gamp/blob/master/gamp'
  version '1.0-alpha'

  def install
    opoo #{HOMEBREW_PREFIX}+"Cellar"
    sh = libexec + "gamp"
    chmod 0755, sh
    bin.install_symlink sh
  end

end
