require "formula"

class Gamp < Formula
  homepage 'https://github.com/Gigitsu/homebrew-gamp'
  url 'https://raw.githubusercontent.com/Gigitsu/homebrew-g2/master/gamp'
  version '1.0-beta'
  sha256 'e678fed0da4179dc836d58aea57867dc76671d9890be9272d7b590c861cc6733'
  revision 1

  def install
    libexec.install "gamp"
    sh = libexec+"gamp"
    chmod 0755, sh
    bin.install_symlink sh

    ch = HOMEBREW_PREFIX+"Cellar"
    filters = services
    Dir.mkdir libexec+"LaunchAgents"
    la = libexec+"LaunchAgents"
    Dir.entries(ch).
      select {|entry| File.directory? ch + entry and !(entry =='.' || entry == '..') and filters.any? {|service| entry.include? service }}.
      collect {|dir| lastv ch + dir}
      .each {|dir|
        Dir.entries(dir).
          select{|entry| File.file? dir + entry and ('.plist' == File.extname(entry))}.
          each{|plist| la.install_symlink dir + plist}
      }

    zshcomp = zsh_completion+"gamp-completition.zsh"
    zshcomp.write("#compdef gamp\n\n_arguments \"1:Commands:((start\:'Starts all services' stop\:'Stops all services' restart\:'Restart all services'))\"")
    zsh_completion.install zshcomp => "_gamp"
  end

  def services
    return %w(http php dnsmasq mysql)
  end

  def lastv(root)
    return root + Dir.entries(root).
      select  {|entry| File.directory? root + entry and !(entry =='.' || entry == '..')}.
      sort_by{ |f| File.mtime(root + f) }.reverse[0]
  end

end
