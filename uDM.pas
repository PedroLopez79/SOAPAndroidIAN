unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, uDAFields, uDADataTable,
  uROComponent, uDAScriptingProvider, uDAMemDataTable, uDADataStreamer,
  uDABin2DataStreamer, uDADataAdapter, uDARemoteDataAdapter,
  uROChannelAwareComponent, uRORemoteService, uROMessage, uROBinMessage,
  uROBaseConnection, uROTransportChannel, uROBaseHTTPClient,
  uROWinInetHttpChannel, UtileriasComun, LibraryIngresos_Intf, ppParameter,
  ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, uDACDSDataTable,
  DateUtils, raCodMod;

type
  TDM = class(TDataModule)
    cdsBitacoraServ: TDAMemDataTable;
    dsBitacoraServ: TDADataSource;
    Channel: TROWinInetHTTPChannel;
    Message: TROBinMessage;
    RemoteService: TRORemoteService;
    RemoteDataAdapter: TDARemoteDataAdapter;
    DataStreamer: TDABin2DataStreamer;
    cdsFirmaDefaultUsuario: TDAMemDataTable;
    dsFirmaDefaultUsuario: TDADataSource;
    cdsMaestro: TDACDSDataTable;
    cdsDetalle: TDACDSDataTable;
    dsMaestro: TDADataSource;
    dsDetalle: TDADataSource;
    dbpMaestro: TppDBPipeline;
    dbpDetalle: TppDBPipeline;
    repReportes: TppReport;
    ppParameterList1: TppParameterList;
    rdaMaestro: TDARemoteDataAdapter;
    rdaDetalle: TDARemoteDataAdapter;
    rdaReportesWEB: TDARemoteDataAdapter;
    cdsReportes: TDACDSDataTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AsignaServidor(Svr: String);
  public
    { Public declarations }
    Puerto: Integer;
    Parametros: TParametrosBI;
    RUTAPDF: String;
    procedure AsignaParametros(Cad: String);
    function Servidor: IServiceIngresos;
    function Folio(ACampo, ASerie: String): Integer;
    function login(usr,password: String):String;
    function Imprimir_Proxy(CualReporte: String; IdentificadorID: Integer; AParametros, Ruta, TipoArchivo: String): String;
    procedure Imprime(SQL1, SQL2, Template, Documento, CampoJoin: String; var Ruta: String; TipoArchivo: String; Directo: Boolean = False);
    procedure AbreDataSetsReportes(SQL1, SQL2: String);
    function Imprimir(CualReporte: String; IdentificadorID: Integer; AParametros, Ruta, TipoArchivo: String): String;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.AbreDataSetsReportes(SQL1, SQL2: String);
begin
  cdsMaestro.Close;
  cdsDetalle.Close;

  cdsMaestro.Fields.Clear;
  cdsDetalle.Fields.Clear;

  rdaMaestro.GetDataCall.ParamByName('SQL').AsString:=SQL1;
  rdaMaestro.GetDataCall.ParamByName('Parametros').AsComplexType:=Parametros;
  cdsMaestro.Open;

  if Trim(SQL2) <> '' then
  begin
    rdaDetalle.GetDataCall.ParamByName('SQL').AsString:=SQL2;
    rdaDetalle.GetDataCall.ParamByName('Parametros').AsComplexType:=Parametros;
    cdsDetalle.Open;
  end;
end;

procedure TDM.AsignaParametros(Cad: String);
const
  MisNombres: Array[1..14] of String = ('FECHAINI',
                                        'FECHAFIN',
                                        'CLIENTEINI',
                                        'CLIENTEFIN',
                                        'ESTACIONINI',
                                        'ESTACIONFIN',
                                        'STATUS',
                                        'ANIO',
                                        'SERIE',
                                        'EJERCICIO',
                                        'IDENTIFICADOR',
                                        'ALMACENINI',
                                        'ALMACENFIN',
                                        'ESTACION');
var
  i, j, Aux: Integer;
  Valor: String;
begin
  Parametros.FechaIni:=0;
  Parametros.FechaFin:=0;
  Parametros.ClienteIni:=0;
  Parametros.ClienteFin:=99999999;
  Parametros.EstacionIni:=0;
  Parametros.EstacionFin:=9999;
  Parametros.Estacion:= 0;
  Parametros.Status:='';
  Parametros.Ejercicio:=2006;
  Parametros.Serie:='';
  Parametros.Secuencia:= '';
  Parametros.Almacen:=0;
  Cad:=UpperCase(Cad);
  i:=0;
  Aux:=0;
  while (GetParsedItem(Cad, '@', i) <> '') AND (i <= 200) do
  begin
    Valor:=GetParsedItem(Cad, '@', i);
    for j := 1 to 14 do    // Iterate
    begin
      if Pos(MisNombres[j], Valor) > 0 then
      begin
        Aux:=j;
        if GetParsedItem(Valor, '=', 1) = '' then
          Aux:=0
        else
          Valor:=GetParsedItem(Valor, '=', 1);
        Break;
      end;
    end;    // for
    case Aux of    //
      1: Parametros.FechaIni:=EncodeDateTime(StrToInt(Copy(Valor, 1, 4)),
                                             StrToInt(Copy(Valor, 6, 2)),
                                             StrToInt(Copy(Valor, 9, 2)),
                                             StrToInt('00'),
                                             StrToInt('00'),
                                             StrToInt('00'),
                                             0);
      2: Parametros.FechaFin:=EncodeDateTime(StrToInt(Copy(Valor, 1, 4)),
                                             StrToInt(Copy(Valor, 6, 2)),
                                             StrToInt(Copy(Valor, 9, 2)),
                                             StrToInt('23'),
                                             StrToInt('59'),
                                             StrToInt('59'),
                                             0);

      3: Parametros.ClienteIni:=StrToInt(Valor);
      4: Parametros.ClienteFin:=StrToInt(Valor);
      5: Parametros.EstacionIni:=StrToInt(Valor);
      6: Parametros.EstacionFin:=StrToInt(Valor);
      7: Parametros.Status:=Valor;
      8: Parametros.Ejercicio:=StrToInt(Valor);
      9: Parametros.Ejercicio:=StrToInt(Valor);
     10: Parametros.Serie:=Valor;
     11: Parametros.Ejercicio:=StrToInt(Valor);
     12: Parametros.Secuencia:= Valor;
     13: Parametros.Secuencia:= Valor;
     14: Parametros.Estacion:= StrToInt(Valor);

    end;    // case
    Inc(i);
  end;    // while
end;

procedure TDM.AsignaServidor(Svr: String);
const
  URL = 'http://%s:%d/BIN';
begin
  Channel.Connected:=False;
  Channel.TargetURL:=Format(URL, [Svr, Puerto]);
end;

procedure TDM.DataModuleCreate(Sender: TObject);
const
  URL = 'http://%s:9090/BIN';
begin
  Parametros:= TParametrosBI.Create;
  Puerto := StrToInt(LeerRegistro('Puerto', '9090'));
  AsignaServidor(LeerRegistro('Server', '127.0.0.1'));
  RUTAPDF:= LeerRegistro('RUTAPDF', '');
end;

function TDM.Folio(ACampo, ASerie: String): Integer;
begin
  Result:=Servidor.Folio(ACampo, ASerie);
end;

procedure TDM.Imprime(SQL1, SQL2, Template, Documento, CampoJoin: String;
  var Ruta: String; TipoArchivo: String; Directo: Boolean);
var
  Aux: TStringStream;
  lFieldLink: TppMasterFieldLink;
begin
  AbreDataSetsReportes(SQL1, SQL2);
  if cdsMaestro.RecordCount < 1 then
  begin
    Ruta:='';
    //Error:='No hay datos';
    Exit;
  end;
  if CampoJoin <> '' then
  begin
    dbpDetalle.MasterDataPipeline := dbpMaestro;
    lFieldLink := TppMasterFieldLink.Create(nil);
    lFieldLink.Parent := dbpDetalle;
    lFieldLink.DetailFieldName := CampoJoin;
    lFieldLink.MasterFieldName := CampoJoin;
  end;
  Aux:=TStringStream.Create(Template);
  repReportes.Template.LoadFromStream(Aux);
  Aux.Free;
  repReportes.AllowPrintToFile:=True;
  repReportes.AllowPrintToArchive:=True;
  repReportes.PrinterSetup.DocumentName:=Documento;
  if Directo then
  begin
    repReportes.DeviceType:='Printer';
    repReportes.ShowPrintDialog:=False;
  end
  else
  begin
    if TipoArchivo = 'XLS' then
    begin
      repReportes.DeviceType := 'ExcelFile';
      Ruta:=Ruta + FormatDateTime('ddmmyyyyhhnnsszzz".xls"', Now);
    end
    else
    begin
      repReportes.DeviceType := 'PDF';
      Ruta:=Ruta + FormatDateTime('ddmmyyyyhhnnsszzz".pdf"', Now);
    end;
    repReportes.TextFileName := Ruta;
    repReportes.ShowPrintDialog:=False;
  end;
  repReportes.Print;
end;

function TDM.Imprimir(CualReporte: String; IdentificadorID: Integer;
  AParametros, Ruta, TipoArchivo: String): String;
begin
  try
    try
      Result:=Imprimir_Proxy(CualReporte, IdentificadorID, AParametros, Ruta, TipoArchivo);
    except
      on E : Exception do
      Result:= E.ClassName+' error raised, with message : '+E.Message;
    end;
  finally

  end;
  if not FileExists(Result) then
    Result:='';
  //if Error <> '' then
  //begin
  //  Result:=Error;
  //end;
end;

function TDM.Imprimir_Proxy(CualReporte: String; IdentificadorID: Integer;
  AParametros, Ruta, TipoArchivo: String): String;
begin
    Result:='';
    try
      cdsReportes.ParamByName('Nombre').AsString:=CualReporte;
      cdsReportes.Open;
      if cdsReportes.RecordCount > 0 then
      begin
        //Error:='Asigna parametros';
        AsignaParametros(AParametros);
        //Error:='Imprime';
        Imprime(cdsReportes.FieldByName('SQL1').AsString,
                    cdsReportes.FieldByName('SQL2').AsString,
                    cdsReportes.FieldByName('Template').AsString,
                    '',
                    cdsReportes.FieldByName('CampoJoin').AsString,
                    Ruta, TipoArchivo);
        //Error:='';
        Result:=Ruta;
      end
      else
        //Error:='No se encontr� el layout del reporte.';
    except
      on e: Exception do
        //Error:=Error + ' Imprimir Proxy:' + e.Message;
    end;
end;

function TDM.login(usr, password: String): String;
var
  Aux: LibraryIngresos_Intf.TLoginInfoBI;
begin
  Aux:=Servidor.Login(Usr, password);

  result:= '-1';
  try
  if Aux.Valida then
  begin
     result:= inttostr(Aux.EmpleadoID)+'@'+Aux.NombreEmpleado;
  end;
  finally
    Aux.Free;
  end;
end;

function TDM.Servidor: IServiceIngresos;
begin
  Result:=CoServiceIngresos.Create(Message, Channel);
end;

end.
