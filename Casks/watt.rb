cask "watt" do
  version "1.1.0"
  sha256 "13356021d01279e35fa7f113f4627543654463ed2cd633f025ea7bdddd371337"

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
