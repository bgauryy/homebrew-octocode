require "language/node"

class Octocode < Formula
  desc "Interactive CLI installer for octocode-mcp — MCP server & skills setup"
  homepage "https://octocode.ai"
  url "https://registry.npmjs.org/octocode-cli/-/octocode-cli-1.5.3.tgz"
  sha256 "366f0323171d6b0f1bc134fa82f31fbf69d6261edd0d626187892a0a017f1297"
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
