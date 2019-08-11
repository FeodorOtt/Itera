unit frmClaimU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, DB, ADODB, ShellAPI, DBCtrls, ToolWin,
  ComCtrls, ActnList, Menus;

type
  TfrmClaim = class(TForm)
    grdMain: TStringGrid;
    pnlGrid: TPanel;
    btnSettings: TButton;
    btnRefresh: TButton;
    btnInsert: TButton;
    pnlButtons: TPanel;
    ActionList: TActionList;
    actDelete: TAction;
    actEdit: TAction;
    actRefresh: TAction;
    actInsert: TAction;
    PopupMenu: TPopupMenu;
    Delete1: TMenuItem;
    Edit1: TMenuItem;
    procedure btnSettingsClick(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actRefreshExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure grdMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    procedure RefreshGrid(lr: word = 0);
  public
    { Public declarations }
  end;

var
  frmClaim: TfrmClaim;

implementation

uses frmClaimEditU, ControllerU, dmConnectionU;

{$R *.dfm}

procedure TfrmClaim.btnSettingsClick(Sender: TObject);
begin
  dmConnection.SetConnect;
end;

procedure TfrmClaim.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmConnection.Disconnect;
end;

procedure TfrmClaim.grdMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  if Button <> mbLeft then Exit;
  GetCursorPos(p);
  PopupMenu.Popup(p.X, p.Y);
end;

procedure TfrmClaim.actDeleteExecute(Sender: TObject);
begin
  if not(grdMain.Cells[0, grdMain.Row] = '') then
    if Dmls.DeleteRecord(StrToInt(grdMain.Cells[0, grdMain.Row]), grdMain.Cells[1, grdMain.Row]) then
      RefreshGrid;
end;

procedure TfrmClaim.actEditExecute(Sender: TObject);
var
  Year, Month, Day: word;
begin
  if (grdMain.Cells[0, grdMain.Row] = '') then Exit;

  frmClaimEdit := TfrmClaimEdit.Create(Self);
  frmClaimEdit.ID := StrToInt(grdMain.Cells[0, grdMain.Row]);
  frmClaimEdit.Caption := 'Edit claim';
  frmClaimEdit.ShowModal;

  with frmClaimEdit do
  if (ModalResult = mrOk) then
  begin
    DecodeDate(dtpYear.Date,Year,Month,Day);
    if Dmls.UpdateRecord(ID, Year, edtName.Text, Integer(cbTypeName.Items.Objects[cbTypeName.ItemIndex]),
         StrToFloat(edtGrossClaim.Text), StrToFloat(edtDeductible.Text)) then
      RefreshGrid;
  end;
end;

procedure TfrmClaim.actInsertExecute(Sender: TObject);
var
  Year, Month, Day: word;
begin
  if (grdMain.Cells[0, grdMain.Row] = '') then Exit;

  frmClaimEdit := TfrmClaimEdit.Create(Self);
  frmClaimEdit.ID := -1;
  frmClaimEdit.Caption := 'Add new claim';
  frmClaimEdit.ShowModal;

  with frmClaimEdit do
  if (ModalResult = mrOk) then
  begin
    DecodeDate(dtpYear.Date,Year,Month,Day);
    if Dmls.UpdateRecord(ID, Year, edtName.Text, Integer(cbTypeName.Items.Objects[cbTypeName.ItemIndex]),
         StrToFloat(edtGrossClaim.Text), StrToFloat(edtDeductible.Text)) then
      RefreshGrid(1);
  end;
end;

procedure TfrmClaim.actRefreshExecute(Sender: TObject);
begin
  RefreshGrid;
end;

procedure TfrmClaim.RefreshGrid(Lr: word = 0);
var
  Dmls: TDataManipulations;
begin
  Dmls := TDataManipulations.Create;
  Dmls.Lr := Lr;
  Dmls.grdControl := grdMain;
  ActiveControl := grdMain;
end;

end.
