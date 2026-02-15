class Lopper < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "15e24b667f0505e68add4e62c230bbaab4ca1a550f82b7652dd624acd1fbad45"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"lopper"), "./cmd/lopper"
  end

  test do
    assert_match "Lopper", shell_output("#{bin}/lopper --help")
  end
end
