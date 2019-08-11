unit ControllerU;

interface

uses
  SysUtils, Dialogs, Controls, OleCtrls, DB, ComCtrls, StdCtrls, Forms, ADODB, Grids, dmConnectionU;//, Classes, ShellAPI, ActnList;

{$RTTI EXPLICIT METHODS([vcPrivate..vcPublished])}
  type
    TDataManipulations = class(TObject)
  private
    FLr: Word;
    FgrdControl: TStringGrid;
    procedure RefreshGrid(FgrdControl: TStringGrid);
  public
    function UpdateRecord(ID: integer; Year: integer; _Name: string; TypeID: integer; GrossClaim: double; Deductible: double): boolean;
    function DeleteRecord(ID: integer; Name: string): boolean;

    property Lr: Word read FLr write FLr;
    property grdControl: TStringGrid read FgrdControl write RefreshGrid;
  end;

  type
    TValidates = class(TObject)
  private

  public
    function ValidateYear(dtpControl: TDateTimePicker): boolean;
    function ValidateDigits(Key: Char): boolean;
    function ValidateDecimal(edtControl: TEdit): boolean;
    function ValidateGrossClaim(edtControl: TEdit): boolean;
    function ValidateDiff(edtControl: TEdit): boolean;
    function ValidateEmpty(frmControl: TEdit): boolean;
    function ValidateComboBox(cbControl: TComboBox): boolean;
  end;

  type
    TFillingUpControls = class(TObject)
  private
    FcbControl: TComboBox;
    FEForm: TForm;
    FID: integer;
    procedure FillUpComboBox(FcbControl: TComboBox);
    procedure FillUpForm(FForm: TForm);
  public
    property ID: integer read FID write FID;
    property EForm: TForm read FEForm write FillUpForm;
    property cbControl: TComboBox read FcbControl write FillUpComboBox;
  end;

var
  Dmls: TDataManipulations;
  Valids: TValidates;
  FlCtrl: TFillingUpControls;

implementation

function TValidates.ValidateComboBox(cbControl: TComboBox): boolean;
var
  NewItem: string;
begin
  Result := True;
  NewItem := cbControl.Text;

  if cbControl.Items.IndexOf(NewItem) = -1 then
  begin
    Result := False;
    if MessageDlg(' Add new Claim type "' + cbControl.Text + '"? ', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    with dmConnection.ADOCommand do
    begin
      Parameters.Clear;
      CommandText :=
          'INSERT INTO ClaimType (Name) VALUES (''' + cbControl.Text + ''')';
      try
        Execute;
        FlCtrl.FillUpComboBox(cbControl);
        cbControl.ItemIndex := cbControl.Items.IndexOf(NewItem);
        Result := True;
      except
        raise Exception.Create('Can''t insert new Claim type!');
      end;
    end;
  end;
end;

function TValidates.ValidateEmpty(frmControl: TEdit): boolean;
begin
  Result := True;

  if Trim(frmControl.Text) = '' then
  begin
    Result:= False;
    frmControl.SetFocus;
    raise Exception.Create('The field can''t be empty!');
  end;
end;

function TValidates.ValidateDiff(edtControl: TEdit): boolean;
begin
  Result := True;
    if StrToFloat(edtControl.Text) < 0 then
    begin
      Result := False;
      raise Exception.Create('Deductible can''t be more than Gross Claim!');
    end;
end;

function TValidates.ValidateGrossClaim(edtControl: TEdit): boolean;
begin
  Result := True;
    if StrToFloat(edtControl.Text) > 100000 then
    begin
      Result := False;
      raise Exception.Create('Gross Claim can''t exceed 100,000!');
    end;
end;

function TValidates.ValidateDecimal(edtControl: TEdit): boolean;
begin
  Result := False;
  try
    edtControl.Text := FloatToStr(StrToFloat(edtControl.Text));
    Result := True;
  except
    edtControl.SetFocus;
    raise Exception.Create('Wrong decimal!');
  end;
end;

function TValidates.ValidateDigits(Key: Char): boolean;
begin
  Result := CharInSet(Key, ['0'..'9', DecimalSeparator, #8])
end;

function TValidates.ValidateYear(dtpControl: TDateTimePicker): boolean;
var
  Year, NowYear, Month, Day: word;
begin
  DecodeDate(Now,NowYear,Month,Day);
  DecodeDate(dtpControl.Date,Year,Month,Day);
  Result := (Year <= NowYear) and (NowYear - Year <= 10);
  if not Result then
  begin
    dtpControl.SetFocus;
    raise Exception.Create('Can''t be in the future or more than 10 years back!');
  end;
end;

procedure TDataManipulations.RefreshGrid(FgrdControl: TStringGrid);
var
  i, j: integer;
begin
  if not dmConnection.Connect then Exit;

  with dmConnection.qClaim do
  begin
    Active := False;

    try
      Active := True;
    except
      raise Exception.Create('Database connection error!');
    end;

    FgrdControl.ColCount := FieldCount;
    FgrdControl.RowCount := RecordCount + 1;

    for i := 0 to Fields.Count-1 do
      FgrdControl.Cells[i, 0] := Fields[i].DisplayLabel;
    j := 1;

    while not Eof do
    begin
      for i := 0 to Fields.Count-1 do
      begin
        if FgrdControl.Cells[i, 0] = 'ID' then FgrdControl.ColWidths[i] := 0;
        FgrdControl.Cells[i, j] := Fields.Fields[i].AsString
      end;
      inc(j);
      Next;
    end;

    if not(lr = 0) then
      FgrdControl.Row := FgrdControl.RowCount - 1;

    Active := False;
  end;
end;

function TDataManipulations.UpdateRecord(ID: integer; Year: integer; _Name: string; TypeID: integer; GrossClaim: double; Deductible: double): boolean;
begin
  Result := False;

  with dmConnection.ADOCommand do
  begin
    Parameters.Clear;

    Parameters.AddParameter;
    Parameters[0].Name := 'Year';
    Parameters.ParamByName('Year').Value := Year;

    Parameters.AddParameter;
    Parameters[1].Name := 'Name';
    Parameters.ParamByName('Name').Value := _Name;

    Parameters.AddParameter;
    Parameters[2].Name := 'TypeID';
    Parameters.ParamByName('TypeID').Value := TypeID;

    Parameters.AddParameter;
    Parameters[3].Name := 'GrossClaim';
    Parameters.ParamByName('GrossClaim').Value := GrossClaim;

    Parameters.AddParameter;
    Parameters[4].Name := 'Deductible';
    Parameters.ParamByName('Deductible').Value := Deductible;

    if ID <> -1 then
    begin
      Parameters.AddParameter;
      Parameters[5].Name := 'ID';
      Parameters.ParamByName('ID').Value := ID;
      CommandText :=
        'DECLARE @Year int ' +
        'DECLARE @Name varchar(100) ' +
        'DECLARE @TypeID int ' +
        'DECLARE @GrossClaim numeric(15,3) ' +
        'DECLARE @Deductible numeric(15,3) ' +
        'DECLARE @ID int ' +
        'SET @Name = :Name ' +
        'SET @TypeID = :TypeID ' +
        'SET @Year = :Year ' +
        'SET @GrossClaim = :GrossClaim ' +
        'SET @Deductible = :Deductible ' +
        'SET @ID = :ID ' +
        'UPDATE Claim ' +
        'SET Year = @Year, Name = @Name, TypeID = @TypeID, GrossClaim = @GrossClaim, Deductible = @Deductible ' +
        'WHERE ID = @ID';
    end
    else
    begin
      CommandText :=
        'DECLARE @Year int ' +
        'DECLARE @Name varchar(100) ' +
        'DECLARE @TypeID int ' +
        'DECLARE @GrossClaim numeric(15,3) ' +
        'DECLARE @Deductible numeric(15,3) ' +
        'SET @Name = :Name ' +
        'SET @Year = :Year ' +
        'SET @TypeID = :TypeID ' +
        'SET @GrossClaim = :GrossClaim ' +
        'SET @Deductible = :Deductible ' +
        'INSERT INTO Claim (Name, Year, TypeID, GrossClaim, Deductible) '+
        'VALUES(@Name, @Year, @TypeID, @GrossClaim, @Deductible)';
    end;

    try
      Execute;
      Result := True;
    except
      raise Exception.Create('Can''t update/insert a Claim!');
    end;
  end;
end;

function TDataManipulations.DeleteRecord(ID: integer; Name: string): boolean;
begin
  Result := False;

  if MessageDlg(' Delete Claim "' + Name + '"? ', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  with dmConnection.ADOCommand do
  begin
    Parameters.Clear;
    Parameters.AddParameter;
    Parameters[0].Name := 'ID';
    Parameters.ParamByName('ID').Value := ID;
    CommandText := 'DELETE FROM Claim WHERE ID = :ID';
    try
      Execute;
      Result := True;
    except
      raise Exception.Create('Can''t delete a Claim!');
    end;
  end;
end;

procedure TFillingUpControls.FillUpComboBox(FcbControl: TComboBox);
begin
  with dmConnection.qClaimType do
  begin
    Active := False;
    try
      Active := True;
    except
      raise Exception.Create('Database connection error!');
    end;

    FcbControl.Items.Clear;

    while not Eof do
    begin
      FcbControl.AddItem(Fields.FieldByName('Name').AsString, TObject(Fields.FieldByName('ID').AsInteger));
      Next;
    end;

    Active := False;
  end;
end;

procedure TFillingUpControls.FillUpForm(FForm: TForm);
begin
  with dmConnection.qOneRec do
  begin
    Parameters.ParamByName('ID').Value := FID;

    try
      Active := True;
    except
      raise Exception.Create('Database connection error!');
    end;

    with FForm do
    begin
      if FID <> -1 then
      begin
        (FindComponent('lbID') as TLabel).Caption := IntToStr(FID);
        (FindComponent('dtpYear') as TDateTimePicker).Date := EncodeDate(FieldByName('Year').AsInteger, 1, 1);
        (FindComponent('cbTypeName') as TComboBox).ItemIndex := (FindComponent('cbTypeName') as TComboBox).Items.IndexOfObject(TObject(FieldByName('TypeID').AsInteger));
      end
      else
      begin
        (FindComponent('dtpYear') as TDateTimePicker).Date := Now;
        (FindComponent('cbTypeName') as TComboBox).ItemIndex := 0;
      end;

      (FindComponent('edtName') as TEdit).Text := FieldByName('Name').AsString;
      (FindComponent('edtGrossClaim') as TEdit).Text := FieldByName('GrossClaim').AsString;
      (FindComponent('edtDeductible') as TEdit).Text := FieldByName('Deductible').AsString;

    end;

    Active := False;
  end;
end;

end.
