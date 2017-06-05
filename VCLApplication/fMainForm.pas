unit fMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  uROPoweredByRemObjectsButton, uDAPoweredByDataAbstractButton;

type
  TMainForm = class(TForm)
    DAPoweredByDataAbstractButton1: TDAPoweredByDataAbstractButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  fServerDataModule;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ServerDataModule.LogOn;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ServerDataModule.LogOff;
end;

end.
