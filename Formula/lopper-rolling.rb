class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260422103605-c14d0d9.tar.gz"
  sha256 "833103b93205c8c2ebba5a26801592a336c80cc836e7da056dc328b762a44dda"
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
    system "bash", "scripts/generate-manpage.sh", "docs/man/lopper.1"
    man1.install "docs/man/lopper.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lopper --version")
  end
end
