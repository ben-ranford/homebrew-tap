cask "watt" do
  version "1.1.1"
  sha256 "1f639fed4c852252d0b3d0ad698c7d7086a592c0c4d81a270b4a5c09c7075215"

  url "https://github.com/ben-ranford/watt/releases/download/v#{version}/Watt-#{version}.zip"
  name "Watt?"
  desc "Menu bar power draw monitor"
  homepage "https://github.com/ben-ranford/watt"

  auto_updates true
  depends_on macos: :ventura

  app "Watt.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Watt.app"]
  end

  zap launchctl: "io.github.ben-ranford.watt.helper",
      trash:     [
        "/Library/Application Support/Watt",
        "/Library/Application Support/Watt-maintenance-result.json",
        "/Library/LaunchDaemons/io.github.ben-ranford.watt.helper.plist",
        "/Library/PrivilegedHelperTools/io.github.ben-ranford.watt.helper",
        "~/Library/Application Support/Watt",
        "~/Library/Preferences/io.github.ben-ranford.watt.plist",
      ]

  caveats <<~EOS
    Watt is ad-hoc signed and is not notarised.
    This cask removes the quarantine attribute so Gatekeeper does not block the first launch.
  EOS
end
