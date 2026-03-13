class Lopper < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "f894a1f85bdccde022a167e136bcaa630891e8562c618cc9ff5ab4f8e1aa3dbf"
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
