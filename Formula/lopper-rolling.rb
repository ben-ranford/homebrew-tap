class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260425102318-977495d.tar.gz"
  sha256 "9cbcaef3179bc90f6478dcc68f963ea85bd2024aa8584d4858fc1b638a82bab1"
  license "MIT"

  keg_only :versioned_formula
  depends_on "go" => :build
  conflicts_with "ben-ranford/tap/lopper", because: "both install the lopper executable"

  def install
    ldflags = %W[
      -s
      -w
      -X github.com/ben-ranford/lopper/internal/version.version=#{version}
      -X github.com/ben-ranford/lopper/internal/version.buildChannel=rolling
    ]
    system "go", "build", *std_go_args(output: bin/"lopper", ldflags: ldflags.join(" ")), "./cmd/lopper"
    system "bash", "scripts/generate-manpage.sh", "docs/man/lopper.1"
    man1.install "docs/man/lopper.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lopper --version")
  end
end
