{ buildPythonPackage
, python3Packages
, fetchPypi
, pipenv
, lib
}:

buildPythonPackage rec {
  pname = "twitch-python";
  version = "0.0.20";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-bgnXIQuOCrtoknZ9ciB56zWxTCnncM2032TVaey6oXw=";
  };

  doCheck = false;

  buildInputs = with python3Packages; [ pipenv ];

  propagatedBuildInputs = with python3Packages; [
    rx
    requests
  ];

  meta = with lib; {
    description = "Object-oriented Twitch API for Python developers";
    homepage = "https://github.com/PetterKraabol/Twitch-Python";
    license = licenses.mit;
  };
}
