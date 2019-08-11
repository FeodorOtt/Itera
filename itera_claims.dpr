program itera_claims;

uses
  Forms,
  frmClaimU in 'frmClaimU.pas' {frmClaim},
  dmConnectionU in 'dmConnectionU.pas' {dmConnection: TDataModule},
  frmClaimEditU in 'frmClaimEditU.pas' {frmClaimEdit},
  ControllerU in 'ControllerU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConnection, dmConnection);
  Application.CreateForm(TfrmClaim, frmClaim);
  Application.Run;
end.
