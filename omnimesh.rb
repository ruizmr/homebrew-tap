class Omnimesh < Formula
  desc "Sovereign, content-addressed compute"
  homepage "https://github.com/omnimesh/omnimesh"
  url "https://github.com/ruizmr/omnimesh/archive/refs/tags/v2024.10.01.tar.gz"
  sha256 "placeholder"  # Update with actual sha
  license "MIT"
  head "https://github.com/omnimesh/omnimesh.git", branch: "main"

  depends_on "go" => :build
  depends_on "ipfs"

  def install
    system "go", "build", "-o", bin/"mesh-run", "./cmd/mesh-run"
  end

  def post_install
    system "#{bin}/mesh-run", "doctor"
    puts "🟢 mesh-run ready → open http://127.0.0.1:32543"
  end

  service do
    run [opt_bin/"mesh-run", "start"]
    keep_alive true
    log_path var/"log/mesh-run.log"
    error_log_path var/"log/mesh-run.err.log"
  end

  test do
    system "#{bin}/mesh-run", "--version"
  end
end 