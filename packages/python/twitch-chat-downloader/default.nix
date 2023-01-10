{ buildPythonPackage
, python3Packages
, fetchFromGitHub
, twitchPython
, pipenv
, lib
}:

buildPythonPackage rec {
  pname = "Twitch-Chat-Downloader";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "bspammer";
    repo = "Twitch-Chat-Downloader";
    rev = "b32c60a6f094b3bd2c8128a1d409e85ece6df821";
    sha256 = "sha256-C9BT4HZWC14E3kSKw74w4vOEq3ZRJ1J/cEpgwDerJb8=";
  };

  doCheck = false;

  buildInputs = with python3Packages; [ pipenv ];

  propagatedBuildInputs = with python3Packages; [
    twitchPython
    dateutil
    pytz
    requests
  ];

  meta = with lib; {
    description = "Download chat messages from past broadcasts on Twitch";
    homepage = "https://github.com/PetterKraabol/Twitch-Chat-Downloader";
    license = licenses.mit;
  };
}
