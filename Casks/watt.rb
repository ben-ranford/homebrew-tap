cask "watt" do
  version "1.2.0"
  sha256 "cbb44521f7d6404542a8f3cfa3a75fffeff0b012595aef8a82dc85a502f50974"

  url "https://github.com/ben-ranford/watt/releases/download/v#{version}/Watt-#{version}.zip"
  name "Watt?"
  desc "Menu bar power draw monitor"
  homepage "https://github.com/ben-ranford/watt"

  auto_updates true
  depends_on macos: :ventura

  app "Watt.app"

  zap launchctl: "io.github.ben-ranford.watt.helper",
      trash:     [
        "/Library/Application Support/Watt",
        "/Library/Application Support/Watt-maintenance-result.json",
        "/Library/LaunchDaemons/io.github.ben-ranford.watt.helper.plist",
        "/Library/PrivilegedHelperTools/io.github.ben-ranford.watt.helper",
        "~/Library/Application Support/Watt",
        "~/Library/Preferences/io.github.ben-ranford.watt.plist",
      ]
end
