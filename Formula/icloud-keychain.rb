class IcloudKeychain < Formula
  desc "CLI tool to manage iCloud Keychain items"
  homepage "https://github.com/piotrrojek/icloud-keychain"
  url "https://github.com/piotrrojek/icloud-keychain/releases/download/v1.0.0/icloud-keychain-1.0.0-macos-universal.tar.gz"
  sha256 "a7ad1bbff35063c5ff5fb6862c3425ee2064111e7972376cd99e498091fe1d8b"
  version "1.0.0"
  license "MIT"

  depends_on :macos

  def install
    prefix.install "icloud-keychain.app"
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
