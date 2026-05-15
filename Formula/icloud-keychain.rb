class IcloudKeychain < Formula
  desc "CLI tool to manage iCloud Keychain items"
  homepage "https://github.com/piotrrojek/icloud-keychain"
  url "https://github.com/piotrrojek/icloud-keychain/releases/download/v1.0.1/icloud-keychain-1.0.1-macos-universal.tar.gz"
  sha256 "93039396e7f813060080f834b49af4554c7253f62f78c35b01e92f626cc3c358"
  version "1.1.0"
  license "MIT"

  depends_on :macos

  def install
    # Tarballs from v1.1.0+ include a completions/ dir alongside the .app.
    # Older tarballs don't — fall through gracefully so re-installing an old
    # version still works.
    if File.exist?("completions/_icloud-keychain")
      zsh_completion.install "completions/_icloud-keychain"
      rm_rf "completions"
    end
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
