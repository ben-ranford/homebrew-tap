class LopperRolling < Formula
  desc "Local-first CLI/TUI for measuring dependency surface area"
  homepage "https://github.com/ben-ranford/lopper"
  url "https://github.com/ben-ranford/lopper/archive/refs/tags/rolling-20260329134316-4233bd7.tar.gz"
  sha256 "ce5368d5569a90cf57b5b9decf6ef9608e4702641693fbc955880dba60d96875"
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
