unit FormUnit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, ShellAPI,
  Vcl.ExtCtrls, Vcl.Menus, UtileriasComun;

  const
  WM_ICONTRAY = WM_USER + 100;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Mostrar1: TMenuItem;
    Ocultar1: TMenuItem;
    Cerrar1: TMenuItem;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Cerrar1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RemueveIcono;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    TrayIconData: TNotifyIconData;
    procedure WMSysCommand(var Msg: TWMSysCommand);
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TForm1.Ocultar1Click(Sender: TObject);
begin
  Hide; { hide the main form }

  WindowState := wsMinimized; { the mainform will start up minimized }
  Timer2.Enabled := True;
end;

procedure TForm1.Cerrar1Click(Sender: TObject);
begin
 Close; { exit the program }
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //if MessageDlg('Esta seguro que quiere salir?', mtconfirmation, [mbOK, mbNo], 0) = mrOk then
  //CanClose:= True
  //else
  //CanClose:= False;

  CanClose:= True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);

  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);

  with TrayIconData do
  begin
    cbSize := System.SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Application.Title);
  end;

Shell_NotifyIcon(NIM_ADD, @TrayIconData);

Sleep(1000);
StartServer;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm1.FormHide(Sender: TObject);
begin
  Hide; { hide the main form }
end;

procedure TForm1.FormShow(Sender: TObject);
var ToBeHidden: boolean;
begin
  ToBeHidden := true; 	{ example, 'ToBeHidden' can be set to any boolean }
			{ expression defined by you }
  if ToBeHidden then
  begin
    WindowState := wsMinimized; { the mainform will start up minimized }
    Timer2.Enabled := True; { start the timer to switch later to 'hidden' }
  end;
end;

procedure TForm1.Mostrar1Click(Sender: TObject);
begin
  WindowState := wsNormal;
  SetForegroundWindow(handle);
  Show; { show the mainform }
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  Mostrar1.Enabled := not Visible;
  Ocultar1.Enabled := Visible;
  Cerrar1.Enabled:= Visible;
end;

procedure TForm1.RemueveIcono;
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm1.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RemueveIcono;
  AppRestart;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Hide;
end;

procedure TForm1.TrayMessage(var Msg: TMessage);
var
  p: TPoint;
begin
    case Msg.lParam of
    WM_LBUTTONDBLCLK:
      begin
        WindowState := wsNormal;
        SetForegroundWindow(handle);
        Show;			{ Show the main form }
      end;
    WM_RBUTTONDOWN:
      begin
 	  SetForegroundWindow(Handle);
        GetCursorPos(p);
        PopUpMenu1.Popup(p.x, p.y);		{ show the popup menu }
        PostMessage(Handle, WM_NULL, 0, 0);
      end;
  end;
end;

procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
begin
 if (Msg.CmdType = SC_MINIMIZE) or
    (Msg.CmdType = SC_CLOSE) then
  begin
    Hide;
    exit;
  end
  else
    DefaultHandler(Msg);
end;

end.
