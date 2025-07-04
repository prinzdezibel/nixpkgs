{
  lib,
  buildPythonPackage,
  fetchPypi,
  isPy27,
  pythonOlder,
  future,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "parsedatetime";
  version = "2.6";
  format = "setuptools";
  disabled = isPy27; # no longer compatible with icu package

  src = fetchPypi {
    inherit pname version;
    sha256 = "4cb368fbb18a0b7231f4d76119165451c8d2e35951455dfee97c62a87b04d455";
  };

  propagatedBuildInputs = lib.optional (pythonOlder "3.13") future;

  nativeCheckInputs = [ pytestCheckHook ];

  enabledTestPaths = [ "tests/Test*.py" ];

  disabledTests = [
    # https://github.com/bear/parsedatetime/issues/263
    "testDate3ConfusedHourAndYear"
    # https://github.com/bear/parsedatetime/issues/215
    "testFloat"
  ];

  pythonImportsCheck = [ "parsedatetime" ];

  meta = with lib; {
    description = "Parse human-readable date/time text";
    homepage = "https://github.com/bear/parsedatetime";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
