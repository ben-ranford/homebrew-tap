cask "watt" do
  version "1.4.0"
  sha256 "a06c038fff6f8f9537643210880fb75bf48cfec5452a3b30cec5c1119a9001ca"

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
