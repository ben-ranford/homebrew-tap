class SudoYubikey < Formula
  desc "Explicit YubiKey sudo authentication with native macOS fallback"
  homepage "https://github.com/ben-ranford/sudo-yubikey"
  url "https://github.com/ben-ranford/sudo-yubikey/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "dbc1dec29622e51ed00b2258203eea70eef8aff25342ddc3ff9b0a66be3e4c9e"
  license "EPL-2.0"

  depends_on macos: :sonoma
  depends_on "pam-u2f"
  depends_on "python@3.14"

  def install
    libexec.install "sudo_yubikey.py", "tests"
    (bin/"sudo-yubikey").write <<~EOS
      #!/bin/bash
      exec "#{formula_opt_bin("python@3.14")}/python3.14" "#{libexec}/sudo_yubikey.py" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Installation does not modify PAM or enroll keys.
      Read the project configuration and recovery instructions before activation.
      Native Touch ID/password fallback is retained; no mandatory-key mode exists.
      Homebrew PAM modules require an explicit root trust decision.
      Hardware authentication has not been verified for this release.
    EOS
  end

  test do
    assert_match "sudo-yubikey #{version}", shell_output("#{bin}/sudo-yubikey --version")
    assert_match "--dry-run", shell_output("#{bin}/sudo-yubikey --help")
    system formula_opt_bin("python@3.14")/"python3.14", "-m", "unittest", "discover",
           "-s", libexec/"tests", "-v"
  end
end
