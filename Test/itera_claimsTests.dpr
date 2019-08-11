program itera_claimsTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestControllerU in 'TestControllerU.pas',
  dmConnectionU in '..\dmConnectionU.pas',
  ControllerU in '..\ControllerU.pas',
  frmClaimEditU in '..\frmClaimEditU.pas' {frmClaimEdit},
  frmClaimU in '..\frmClaimU.pas' {frmClaim};

{*.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmConnection, dmConnection);
  //  Application.CreateForm(TfrmClaimEdit, frmClaimEdit);
  Application.CreateForm(TfrmClaim, frmClaim);
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

