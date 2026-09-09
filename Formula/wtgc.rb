class Wtgc < Formula
  desc "Conservative Git worktree cleanup CLI"
  homepage "https://github.com/ben-ranford/wtgc"
  url "https://github.com/ben-ranford/wtgc/archive/7f67e54d011cba7aca93f50668eebfcc854179ad.tar.gz"
  version "1.1.0"
  sha256 "c7d86a2a8394dbb8711d3352b9d3c4ac2d6016130c2e703ccf430d4acabab983"
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
