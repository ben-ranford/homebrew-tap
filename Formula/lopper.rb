class Lopper < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "a283e67f2c1088499d5217ac42bfc1fe23c1699d29094c837cee41238e2b9bd1"
  license "MIT"

  depends_on "go" => :build
  conflicts_with "ben-ranford/tap/lopper-rolling", because: "both install the lopper executable"

  def install
    ldflags = %W[
      -s
      -w
      -X github.com/ben-ranford/lopper/internal/version.version=#{version}
      -X github.com/ben-ranford/lopper/internal/version.buildChannel=release
    ]
    system "go", "build", *std_go_args(output: bin/"lopper", ldflags: ldflags.join(" ")), "./cmd/lopper"
    system "bash", "scripts/generate-manpage.sh", "docs/man/lopper.1"
    man1.install "docs/man/lopper.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lopper --version")
  end
end
