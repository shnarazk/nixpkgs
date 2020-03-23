{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "cadical";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "arminbiere";
    repo = pname;
    rev = "92d72896c49b30ad2d50c8e1061ca0681cd23e60";
    sha256 = "sha256:1a66xkw42ad330fvw8i0sawrmg913m8wrq5c85lw5qandkwvxdi6";
  };

  configurePhase = "./configure";
  # nativeBuildInputs = [ make ];
  buildInputs = [ ];
  installPhase = ''
    install -Dm0755 build/cadical "$out/bin/cadical"
    install -Dm0755 build/mobical "$out/bin/mobical"
    mkdir -p "$out/share/doc/${pname}-${version}/"
    install -Dm0755 {LICEN?E,README*,VERSION} "$out/share/doc/${pname}-${version}/"
  '';


  meta = with stdenv.lib; {
    description = "Simplified Satisfiability Solver";
    maintainers = with maintainers; [ shnarazk ];
    # platforms = platforms.unix;
    license = licenses.mit;
    homepage = http://fmv.jku.at/cadical;
  };
}
