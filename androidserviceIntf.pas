{ Invokable interface Iandroidservice }

unit androidserviceIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  TEnumTest = (etNone, etAFew, etSome, etAlot);

  TDoubleArray = array of Double;

  TMyEmployee = class(TRemotable)
  private
    FLastName: AnsiString;
    FFirstName: AnsiString;
    FSalary: Double;
  published
    property LastName: AnsiString read FLastName write FLastName;
    property FirstName: AnsiString read FFirstName write FFirstName;
    property Salary: Double read FSalary write FSalary;
  end;

  { Invokable interfaces must derive from IInvokable }
  Iandroidservice = interface(IInvokable)
  ['{93CACC0C-0C7E-4DD6-BA1D-498A72B7A600}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;
    function holamundo: String; stdcall;
    function guardadatosfirma(const Actividad,Frecuencia,Observaciones,FechaHora,Folio,Fecha,usuarioid,estacionid,firmabase64,fotobase64:AnsiString): AnsiString; stdcall;
    function login(usr,password:AnsiString): AnsiString; stdcall;
    function firmadefault(const Actividad, Frecuencia,Observaciones, FechaHora, Folio, Fecha, usuarioid, estacionid,firmabase64,fotobase64: AnsiString): AnsiString; stdcall;
    function comboalmacen(const estacionid: AnsiString):AnsiString; stdcall;
    function generareporte(const nombrereporte,fechaini,fechafin,numestacion,idalmacen:AnsiString): AnsiString; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(Iandroidservice));

end.
