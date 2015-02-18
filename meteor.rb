require "formula"

class Meteor < Formula
  homepage "https://www.meteor.com"
  head 'https://github.com/meteor/meteor.git'
  url "https://d3sqy0vbqsdhku.cloudfront.net/packages-bootstrap/1.0.2/meteor-bootstrap-os.osx.x86_64.tar.gz",
    :using => :nounzip
  sha1 "084021e8b75a73a84fff97a525740fbcbb2a75ee"
  version "1.0.2"

  # sha1 "e3c74028ffaf089408bea52a4eb06ff42cac4462"
  # version "1.0.3.1"
  # 1.0.3.1 fails the initial install, 1.0.2 seems to work and updates itself

  depends_on "node" if build.head?

  def install
    system "tar xvfz meteor-bootstrap-os.osx.x86_64.tar.gz" unless build.head?
    system "mv .meteor meteor" unless build.head?

    system "./scripts/generate-dev-bundle.sh" if build.head?

    prefix.install Dir["*"]
    bin.install_symlink prefix/"meteor"
  end

  def caveats
    s = <<-EOS.undent
      Installed meteor 1.0.2 for the initial run,
      which will update itself to the latest version.

      The brew formula will stay at 1.0.2.

      If you upgrade this formula, you might want to
      run `meteor update` after upgrading.
    EOS
    s unless build.head?
  end
end
