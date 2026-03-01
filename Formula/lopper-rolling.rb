class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260301071926-d12fb94.tar.gz"
  sha256 "4ef678c945df81b971544aa2b10d8be19965f533dfc6c7aebafa36c0241886da"
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
