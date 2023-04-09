unit AWS4Delphi.SMS;

interface

uses
  AWS4Delphi.Interfaces,
  AWS4Delphi.Model.SMS,
  System.Classes;

type
  //Signature DLL
  TSendSMS = function(aJSONParameters: PAnsiChar): PAnsiChar; stdcall;

  TAmazonPinpoint = class(TInterfacedObject, ISendSMS)
    private
      FSMS: TSMS;

      procedure ValidatedPhoneNumber(const aNumber: String);
      constructor Create;
    public
      class function New: ISendSMS;
      destructor Destroy; override;

      function SetMessage(const aMessage: String): ISendSMS;
      function SetPhoneNumber(const aNumber: String): ISendSMS; overload;
      function SetPhoneNumber(const aNumber: TStrings): ISendSMS; overload;
      function SetRegion(const aRegion: String): ISendSMS;
      function SetAppId(const aAppId: String): ISendSMS;

      procedure SendSMS(var aResult: String);
  end;

implementation

uses
  System.SysUtils, Winapi.Windows, AWS4Delphi.Constants;

{ TAmazonPinpoint }

constructor TAmazonPinpoint.Create;
begin
  FSMS := TSMS.Create;
end;

destructor TAmazonPinpoint.Destroy;
begin
  FreeAndNil(FSMS);
  inherited;
end;

class function TAmazonPinpoint.New: ISendSMS;
begin
  Result := Self.Create;
end;

procedure TAmazonPinpoint.SendSMS(var aResult: String);
var
  xHandle: THandle;
  xSendSMS: TSendSMS;
begin
  aResult := '';
  xHandle := LoadLibrary(NAME_DLL);

  if xHandle > 0 then
  begin
    try
      @xSendSMS := GetProcAddress(xHandle, 'SendSMS'); //Method name of dll

      if @xSendSMS <> nil then
        aResult := xSendSMS(PAnsiChar(AnsiString(FSMS.JSONParameters)))
      else
        aResult := 'Método da DLL não carregado.';
    finally
      FreeLibrary(xHandle);
    end;
  end
  else
    aResult := 'DLL não carregada.';
end;

function TAmazonPinpoint.SetAppId(const aAppId: String): ISendSMS;
begin
  FSMS.AppID := aAppId;
  Result := Self;
end;

function TAmazonPinpoint.SetMessage(const aMessage: String): ISendSMS;
begin
  FSMS.MessageBody := aMessage;
  Result := Self;
end;

function TAmazonPinpoint.SetPhoneNumber(const aNumber: String): ISendSMS;
begin
  Self.ValidatedPhoneNumber(aNumber);

  FSMS.AddPhoneNumber(aNumber);
  Result := Self;
end;

function TAmazonPinpoint.SetPhoneNumber(const aNumber: TStrings): ISendSMS;
var
  xNumber: String;
begin
  for xNumber in aNumber do
    Self.SetPhoneNumber(xNumber);

  Result := Self;
end;

function TAmazonPinpoint.SetRegion(const aRegion: String): ISendSMS;
begin
  FSMS.RegionAWS := aRegion;
  Result := Self;
end;

procedure TAmazonPinpoint.ValidatedPhoneNumber(const aNumber: String);
var
  I: Integer;
  xStr: String;
begin
  xStr := aNumber;

  if xStr[1] <> '+' then
    raise Exception.Create('Número Inválido: Não foi encontrado o caracter "+" no início.');

  for I := 2 to Length(xStr) do
    if not (CharInSet(xStr[I], ['0'..'9'])) then    
      raise Exception.Create('Número Inválido: Possui caracteres diferentes de numerais.');

  if (Length(xStr) < 13) or (Length(xStr) > 14) then
    raise Exception.Create('Número Inválido: Possui tamanho diferente do permitido.');
end;

end.
