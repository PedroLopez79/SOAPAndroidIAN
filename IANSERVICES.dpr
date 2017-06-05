program IANSERVICES;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit1 in 'FormUnit1.pas' {Form1},
  WebModuleUnit4 in 'WebModuleUnit4.pas' {WebModule4: TWebModule},
  androidserviceImpl in 'androidserviceImpl.pas',
  androidserviceIntf in 'androidserviceIntf.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  UtileriasComun in 'UtileriasComun.pas',
  LibXmlParser in 'LibXmlParser.pas',
  ufrmPassword in 'ufrmPassword.pas' {frmPassword},
  LibraryIngresos_Intf in 'LibraryIngresos_Intf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
