class CvbTools < Formula
  desc "cloudvBOX Linux admin tools"
  homepage "https://github.com/cloudvBOX/cvb-tools"
  url "https://example.com/cvb-tools-0.01.tar.gz"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT"

  depends_on "bash"
  depends_on "coreutils"
  depends_on "gnu-tar"
  depends_on "sqlite"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "mkold", shell_output("#{bin}/mkold -h", 2)
  end
end
