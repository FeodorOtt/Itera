unit frmClaimEditU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB, Mask, ComCtrls;

type
  TfrmClaimEdit = class(TForm)
    pnlGrid: TPanel;
    edtName: TEdit;
    edtGrossClaim: TEdit;
    edtDeductible: TEdit;
    cbTypeName: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    pnlButtons: TPanel;
    edtNetClaim: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dtpYear: TDateTimePicker;
    lbID: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtGrossClaimKeyPress(Sender: TObject; var Key: Char);
    procedure edtGrossClaimExit(Sender: TObject);
    procedure edtGrossClaimChange(Sender: TObject);
    procedure dtpYearChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbTypeNameExit(Sender: TObject);
  private
    FID: integer;
  public
    property ID: integer read FID write FID;
  end;

var
  frmClaimEdit: TfrmClaimEdit;

implementation

uses dmConnectionU, ControllerU;

{$R *.dfm}

procedure TfrmClaimEdit.edtGrossClaimChange(Sender: TObject);
var
  dGrossClaim, dDeductible: double;
begin
  if edtGrossClaim.Text = '' then edtGrossClaim.Text := '0';
  if edtDeductible.Text = '' then edtDeductible.Text := '0';

  if Valids.ValidateGrossClaim(TEdit(Sender)) then
  begin
    if TryStrToFloat(edtGrossClaim.Text, dGrossClaim) and TryStrToFloat(edtDeductible.Text, dDeductible) then
      edtNetClaim.Text := FloatToStr(dGrossClaim - dDeductible)
    else
      raise Exception.Create('Wrong decimal!');
  end;

  Valids.ValidateDiff(edtNetClaim);
end;

procedure TfrmClaimEdit.edtGrossClaimExit(Sender: TObject);
begin
  Valids.ValidateDecimal(TEdit(Sender));
end;

procedure TfrmClaimEdit.cbTypeNameExit(Sender: TObject);
begin
  Valids.ValidateComboBox(TComboBox(Sender));
end;

procedure TfrmClaimEdit.dtpYearChange(Sender: TObject);
begin
  Valids.ValidateYear(TDateTimePicker(Sender))
end;

procedure TfrmClaimEdit.edtGrossClaimKeyPress(Sender: TObject; var Key: Char);
begin
  if not Valids.ValidateDigits(Key) then
      Key := #0;
end;

procedure TfrmClaimEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    with Valids do
    if not(
      ValidateEmpty(TEdit(edtName)) and
      ValidateDecimal(edtGrossClaim) and
      ValidateGrossClaim(edtGrossClaim) and
      ValidateDecimal(edtDeductible) and
      ValidateDiff(edtNetClaim) and
      ValidateYear(dtpYear) and
      ValidateComboBox(cbTypeName) and
      ValidateEmpty(TEdit(cbTypeName))
      ) then
        CanClose := False
    else
      CanClose := True;
  end;
end;

procedure TfrmClaimEdit.FormShow(Sender: TObject);
var
  FlCtrl: TFillingUpControls;
begin
  FlCtrl := TFillingUpControls.Create;

  FlCtrl.cbControl := cbTypeName;
  FlCtrl.ID := FID;
  FlCtrl.EForm := TForm(Sender);
end;

end.
