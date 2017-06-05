program VCLApplication;

{#ROGEN:VCLApplication.RODL} // RemObjects SDK: Careful, do not remove!

uses
  uROComInit,
  uROComboService,
  Forms,
  fMainForm in 'fMainForm.pas' {MainForm},
  LoginService_Impl in 'LoginService_Impl.pas' {LoginService: TSimpleLoginService},
  DataService_Impl in 'DataService_Impl.pas' {DataService: TDARemoteService},
  fServerDataModule in 'fServerDataModule.pas' {ServerDataModule: TDataModule};

{$R *.res}
{$R RODLFile.res}

begin
  if ROStartService('VCLApplication', 'VCLApplication') then begin
    ROService.CreateForm(TServerDataModule, ServerDataModule);
    ROService.Run;
    Exit;
  end;

  Application.Initialize;
  Application.CreateForm(TServerDataModule, ServerDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
