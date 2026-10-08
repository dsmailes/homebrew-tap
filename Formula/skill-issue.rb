class SkillIssue < Formula
  include Language::Python::Shebang

  desc "Audit and clean skills, plugins, MCP servers and caches left by AI coding agents"
  homepage "https://github.com/dsmailes/skill-issue"
  url "https://github.com/dsmailes/skill-issue/releases/download/v0.1.0/skill-issue-v0.1.0.tar.gz"
  sha256 "7063f402061c9aeb93ea4623bee9cdeacd2ead7ee26104987368255c482cc6ae"
  license "MIT"

  depends_on "python@3.13"

  def install
    rewrite_shebang detected_python_shebang, "skill-issue"
    bin.install "skill-issue"
  end

  def caveats
    <<~EOS
      skill-issue moves files out of your AI tools' config and cache folders.
      Use at your own risk, and read the disclaimer before cleaning:
        https://github.com/dsmailes/skill-issue#disclaimer

      Run `skill-issue` for a read-only report, or `skill-issue tui` for the
      interactive screen where you pick items to clean. Nothing is removed
      until you confirm, and everything removed goes to the Trash with a
      restore manifest.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skill-issue --version")
    # Audit an empty home: must run cleanly and report nothing on disk.
    with_env(HOME: testpath) do
      assert_match "Total on disk", shell_output(bin/"skill-issue")
    end
  end
end
