cask "watt" do
  version "1.3.2"
  sha256 "d4e2baab532e7e5e1078729e0438e929aef47d03f0028773303c7b9ccf21e492"

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
