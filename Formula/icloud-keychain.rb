class IcloudKeychain < Formula
  desc "CLI tool to manage iCloud Keychain items"
  homepage "https://github.com/piotrrojek/icloud-keychain"
  url "https://github.com/piotrrojek/icloud-keychain/releases/download/v1.0.1/icloud-keychain-1.0.1-macos-universal.tar.gz"
  sha256 "94b4b5bef1d5b633f2a3cccda7811c03de166819c0f3eae428c33d28d83dd509"
  version "1.0.1"
  license "MIT"

  depends_on :macos

  def install
    (prefix / "icloud-keychain.app").install Dir["*"]
    bin.install_symlink prefix / "icloud-keychain.app" / "Contents" / "MacOS" / "icloud-keychain"
  end

  def caveats
    <<~EOS
      icloud-keychain requires Keychain access entitlements.
      The signed .app bundle is installed at:
        #{prefix}/icloud-keychain.app
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/icloud-keychain 2>&1", 1)
  end
end
