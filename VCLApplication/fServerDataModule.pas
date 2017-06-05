unit fServerDataModule;

{$I DataAbstract.inc}
interface

uses
  {vcl:} SysUtils, Classes, DB,
  {RemObjects:} uROClient, uROClientIntf, uROServer, uROSessions, uROMessage, uROComponent, 
  uROBaseConnection, uROBinMessage, uROIndyHTTPServer,    
  {Data Abstract:} uDAEngine, uDADriverManager, uDAStreamableComponent, uDAConnectionManager, uDADataDictionary, 
  uDAScriptingProvider, uDAEcmaScriptEngine, uDASpiderMonkeyScriptProvider, uDAFields,
  uDADataTable, uDAMemDataTable, uDAReconcileDialog, uDADataAdapter, uDALocalDataAdapter, uDASDACDriver;

type
  TServerDataModule = class(TDataModule)
    Server: TROIndyHTTPServer;
    Message: TROBinMessage;
    
    ConnectionManager: TDAConnectionManager;
    DriverManager: TDADriverManager;
    DataDictionary: TDADataDictionary;
    SessionManager: TROInMemorySessionManager;
    LocalDataAdapter: TDALocalDataAdapter;
    ReconcileProvider: TDAVCLReconcileProvider;
    tbl_dbo_TipoCambio: TDAMemDataTable;
    ds_dbo_TipoCambio: TDADataSource;
    sp_tbl_dbo_TipoCambio: TDASpiderMonkeyScriptProvider;
    tbl_dbo_usuarios: TDAMemDataTable;
    ds_dbo_usuarios: TDADataSource;
    sp_tbl_dbo_usuarios: TDASpiderMonkeyScriptProvider;
    
    procedure ModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fLocalSession:TROSession;
  public
    { Public declarations }
    procedure LogOn;
    procedure LogOff;
  end;

var
  ServerDataModule: TServerDataModule;

implementation

{$IFDEF DELPHIXE2UP}
{%CLASSGROUP 'System.Classes.TPersistent'}
{$ENDIF}

uses
  uROClasses;
  
{$R *.dfm}

procedure TServerDataModule.ModuleCreate(Sender: TObject);
begin
  Server.Active := true;
  fLocalSession := nil;
end;

procedure TServerDataModule.LogOn;
var aTmpSession:TROSession;
begin
  if (fLocalSession <> nil) then exit;
  fLocalSession := ServerDataModule.SessionManager.CreateSession(NewGuid);
  aTmpSession := fLocalSession;
  ServerDataModule.SessionManager.ReleaseSession(aTmpSession, True);
  LocalDataAdapter.SessionID := fLocalSession.SessionID;
end;

procedure TServerDataModule.LogOff;
begin
  if (fLocalSession <> nil) then
  begin
    ServerDataModule.SessionManager.DeleteSession(fLocalSession.SessionID, False);
    fLocalSession := nil;
  end;
end;

end.