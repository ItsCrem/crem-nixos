{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "smugglefuzz";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "Moopinger";
    repo = "smugglefuzz";
    rev = "v0.2.2";
    hash = "sha256-A7HI46eE3ya0uVLPb3lYpulDD2oTLrTY6LwP/CiF39o=";
  };

  vendorHash = "sha256-9Nll3K93IaGbEXu+WRBKvqTLhBdkQVvzcTZFDGbCpA0=";

  meta = {
    description = "A rapid HTTP downgrade smuggling scanner written in Go. ";
    homepage = "https://github.com/Moopinger/smugglefuzz";
    license = lib.licenses.mit;
    mainProgram = "smugglefuzz";
    maintainers = with lib.maintainers; [
      emilytrau
      crem
    ];
  };
}
