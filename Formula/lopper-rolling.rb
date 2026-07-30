class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/7366d8128ebab0406228a6ae090b240755caf7f5.tar.gz"
  version "rolling-20260730061111-7366d81"
  sha256 "cd7d79ef993adf08f130263fbe833ffed1b11c3d2d7b7031acedb3d3ef6bd300"
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
