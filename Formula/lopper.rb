class Lopper < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "5f60ebaed5a34c9dc79b1d503a54c904758bc506d19c70d46884163f428daaea"
  license "MIT"

  depends_on "go" => :build
  conflicts_with "ben-ranford/tap/lopper-rolling", because: "both install the lopper executable"

  def install
    system "go", "build", *std_go_args(output: bin/"lopper"), "./cmd/lopper"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/lopper --help")
  end
end
