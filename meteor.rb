require "formula"

class Meteor < Formula
  homepage "https://www.meteor.com"
  head 'https://github.com/meteor/meteor.git'
  url "https://d3sqy0vbqsdhku.cloudfront.net/packages-bootstrap/1.2.1/meteor-bootstrap-os.osx.x86_64.tar.gz", :using => :nounzip
  sha256 'fa816178cb03f79d924d3915680fba3ebc934466d7ec92384024434a6f8c3b3d'
  version "1.2.1"

  depends_on "node" if build.head?

  def install
    if Dir.exists?("/Users/#{ENV['USER']}/.meteor")
      odie <<-EOS.undent
        ~/.meteor already exists. Please remove it
        or move it to a backup location first.
      EOS
    end

    system "tar xvfz meteor-bootstrap-os.osx.x86_64.tar.gz" unless build.head?
    system "mv .meteor meteor" unless build.head?

    system "./scripts/generate-dev-bundle.sh" if build.head?

    prefix.install Dir["meteor/*"]
    bin.install_symlink prefix/"meteor"

    ln_s prefix, "/Users/#{ENV['USER']}/.meteor"
  end

  def caveats
    s = <<-EOS.undent
      Installed meteor 1.2.1 for the initial run,
      which will update itself to the latest version.

      The brew formula will stay at 1.2.1

      If you upgrade this formula, you might want to
      run `meteor update` after upgrading.

      A symlink from /Users/#{ENV['USER']}/.meteor
      to #{prefix} was installed.
    EOS
    s unless build.head?
  end
end
