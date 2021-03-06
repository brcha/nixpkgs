{ lib, fetchFromGitHub, rustPlatform, libiconv, llvmPackages, v8 }:

rustPlatform.buildRustPackage rec {
  pname = "rq";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "dflemstr";
    repo = pname;
    rev = "v${version}";
    sha256 = "0km9d751jr6c5qy4af6ks7nv3xfn13iqi03wq59a1c73rnf0zinp";
  };

  # Delete this on next update; see #79975 for details
  legacyCargoFetcher = true;

  cargoSha256 = "0z971fpyj4v5hjp6q4yxgxv069h9idkpkcixb14gxi7kpiswprvz";

  buildInputs = [ llvmPackages.clang-unwrapped v8 ];

  configurePhase = ''
    export LIBCLANG_PATH="${llvmPackages.clang-unwrapped}/lib"
    export V8_SOURCE="${v8}"
  '';

  meta = with lib; {
    description = "A tool for doing record analysis and transformation";
    homepage = "https://github.com/dflemstr/rq";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ aristid filalex77 ];
    platforms = platforms.all;
  };
}
