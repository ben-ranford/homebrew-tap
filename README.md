# Ben-ranford Tap

## How do I install these formulae?

`brew install ben-ranford/tap/<formula>`

Or `brew tap ben-ranford/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "ben-ranford/tap"
brew "<formula>"
```

## Platform support

CI tests this tap across the following versions:

| Platform | Stable checks | Optional preview checks |
| --- | --- | --- |
| Linux | Ubuntu 24.04 (`ubuntu-24.04`) | Ubuntu 26.04 (`ubuntu-26.04`) |
| Apple Silicon macOS | macOS 15 (`macos-15`), macOS 26 (`macos-26`) | macOS 27 (`xcode-27`) |

Stable checks must pass for CI to succeed. Preview checks may fail without failing
their workflow. Preview checks run separately so they cannot delay stable bottle
publishing, and only stable checks upload bottles. The preview runner labels follow [GitHub's available images](https://github.com/actions/runner-images#available-images).

Intel macOS installations are untested and supported on a best-effort basis.
Homebrew has moved Intel macOS to Tier 3 and stopped building new Intel bottles;
updated dependencies may require source builds or fail to install. Homebrew plans
to remove Intel macOS support in or after September 2027. See
[Homebrew's support policy](https://docs.brew.sh/Support-Tiers#future-macos-support).

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
