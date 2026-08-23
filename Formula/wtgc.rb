class Wtgc < Formula
  desc "Conservative Git worktree cleanup CLI"
  homepage "https://github.com/ben-ranford/wtgc"
  url "https://github.com/ben-ranford/wtgc/archive/58209a8a369b99dc0fd784d89297524a40feba9e.tar.gz"
  version "1.0.0"
  sha256 "5b11d4fd68614122810c4337ff207cf87a2718f8d2d6d0a52e5370d0edab09ad"
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
