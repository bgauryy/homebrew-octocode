require "language/node"

class Octocode < Formula
  desc "Interactive CLI installer for octocode-mcp — MCP server & skills setup"
  homepage "https://octocode.ai"
  url "https://registry.npmjs.org/octocode/-/octocode-2.0.0.tgz"
  sha256 "b3cd113eff00ec8331590c6539f00b7cc88140bd42633226767d62d8445710cf"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # The npm package declares { "octocode": "./out/octocode.js" }, so this
    # symlinks the `octocode` command into Homebrew's bin.
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "octocode v#{version}", shell_output("#{bin}/octocode --version")
  end
end
