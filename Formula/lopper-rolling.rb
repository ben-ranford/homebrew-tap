class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260330093558-596a799.tar.gz"
  sha256 "3885e646b7b883d2b8760d824f7cf17f08121f3b8cfebc33898e7468f0ab644f"
  license "MIT"

  keg_only :versioned_formula
  depends_on "go" => :build
  conflicts_with "ben-ranford/tap/lopper", because: "both install the lopper executable"

  def install
    ldflags = %W[
      -s
      -w
      -X github.com/ben-ranford/lopper/internal/version.version=#{version}
    ]
    system "go", "build", *std_go_args(output: bin/"lopper", ldflags: ldflags.join(" ")), "./cmd/lopper"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lopper --version")
  end
end
