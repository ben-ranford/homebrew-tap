class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260227012900-d9f9126.tar.gz"
  sha256 "df22fc9007ca651f14fe1794076c347228f6b70bdfa7683989a7868cc3f61c17"
  license "MIT"

  keg_only :versioned_formula
  depends_on "go" => :build
  conflicts_with "ben-ranford/tap/lopper", because: "both install the lopper executable"

  def install
    system "go", "build", *std_go_args(output: bin/"lopper"), "./cmd/lopper"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/lopper --help")
  end
end
