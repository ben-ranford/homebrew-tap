class Wtgc < Formula
  desc "Conservative Git worktree cleanup CLI"
  homepage "https://github.com/ben-ranford/wtgc"
  url "https://github.com/ben-ranford/wtgc/archive/3ce701367ff0142ea623378560c134a911d4d5ad.tar.gz"
  version "1.2.0"
  sha256 "056e31cf377113c376f3d763ac60efc04895b3974fdfffb98bd89a9c0c9ce935"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -buildid=
      -X main.version=v#{version}
      -X main.commit=homebrew
      -X main.date=homebrew
    ]
    system "go", "build", *std_go_args(output: bin/"wtgc", ldflags: ldflags.join(" ")), "./cmd/wtgc"
  end

  test do
    assert_match "wtgc v#{version}", shell_output("#{bin}/wtgc --version")
  end
end
