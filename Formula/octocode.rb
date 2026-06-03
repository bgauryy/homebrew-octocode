require "language/node"

class Octocode < Formula
  desc "Interactive CLI installer for octocode-mcp — MCP server & skills setup"
  homepage "https://octocode.ai"
  url "https://registry.npmjs.org/octocode-cli/-/octocode-cli-1.5.0.tgz"
  sha256 "c530d38038dd8f1d29bc178c9359e14720b228e1cf5dab40f52c65d3526e47a6"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # The npm package declares { "octocode": "./out/octocode-cli.js" }, so this
    # symlinks the `octocode` command (not `octocode-cli`) into Homebrew's bin.
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "octocode v#{version}", shell_output("#{bin}/octocode --version")
  end
end
