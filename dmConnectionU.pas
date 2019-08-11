unit dmConnectionU;

interface

uses
  SysUtils, Dialogs, ShellAPI, ADODB, Classes, DB;

type
  TdmConnection = class(TDataModule)
    ADOConnection: TADOConnection;
    qClaim: TADOQuery;
    qClaimType: TADOQuery;
    ADOCommand: TADOCommand;
    qOneRec: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetConnect;
    function Connect: boolean;
    procedure Disconnect;
  end;

var
  dmConnection: TdmConnection;

implementation

{$R *.dfm}

procedure TdmConnection.SetConnect;
var
  UdlFilePath: String;
begin
  UdlFilePath := ExtractFilePath(ParamStr(0)) + 'DB\connection.udl';

  if not FileExists(UdlFilePath) then
    raise Exception.Create('File not found (connection.udl)!');

  ShellExecute(0, 'open', PChar(UdlFilePath), '', '', 0);
end;

function TdmConnection.Connect: boolean;
begin
  Result := False;
  try
    ADOConnection.Connected := True;
    Result := True;
//      ShowMessage('Connection OK!');
  except
    raise Exception.Create('Connection settings are wrong. Fix it up!');
  end;
end;

procedure TdmConnection.DataModuleCreate(Sender: TObject);
var
  ConnectionString: WideString;
begin
  ADOConnection.Connected := False;
  ConnectionString := ExtractFilePath(ParamStr(0)) + 'DB\connection.udl';

  if not FileExists(ConnectionString) then
    raise Exception.Create('File not found (connection.udl)!');

  ADOConnection.ConnectionString := 'FILE NAME=' + ConnectionString;
  ADOConnection.CommandTimeout := 600;
  ADOConnection.LoginPrompt := False;
end;

procedure TdmConnection.Disconnect;
begin
  ADOConnection.Connected := False;
end;

end.
