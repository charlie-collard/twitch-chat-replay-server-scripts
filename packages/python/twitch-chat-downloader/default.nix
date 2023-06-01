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
    rev = "3bfc3ca7ea905e0f66f00914a6f938acbe1f6158";
    sha256 = "sha256-HFRR0AdoTwpU+IajxUDhowVZ4AOFR5IRftWY0xidu1c=";
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
