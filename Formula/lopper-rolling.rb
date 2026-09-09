class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/c1155b00e7b009f33288e823f3cb157b84356006.tar.gz"
  version "rolling-20260909123710-c1155b0"
  sha256 "7dd0ffe812c53f98113a3f838fff8ebf78bca78d2588a75d229adbf66727bb7e"
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
