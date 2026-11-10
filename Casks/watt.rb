cask "watt" do
  version "1.0.0"
  sha256 "7d2e46406913c42afa76a8740d3dca86910ce203458a00a445d2c4cc0d2ede46"

  url "https://github.com/ben-ranford/watt/releases/download/v#{version}/Watt-#{version}.zip"
  name "Watt?"
  desc "Menu-bar app that shows Mac power draw in watts"
  homepage "https://github.com/ben-ranford/watt"

  depends_on macos: ">= :ventura"

  app "Watt.app"

  auto_updates true

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Watt.app"]
  end

  zap trash: [
    "~/Library/Application Support/Watt",
    "~/Library/Preferences/io.github.ben-ranford.watt.plist",
    "/Library/Application Support/Watt",
    "/Library/Application Support/Watt-maintenance-result.json",
    "/Library/LaunchDaemons/io.github.ben-ranford.watt.helper.plist",
    "/Library/PrivilegedHelperTools/io.github.ben-ranford.watt.helper",
  ],
    launchctl: "io.github.ben-ranford.watt.helper"

  caveats <<~EOS
    Watt is ad-hoc signed and is not notarised.
    This cask removes the quarantine attribute so Gatekeeper does not block the first launch.
  EOS
end
